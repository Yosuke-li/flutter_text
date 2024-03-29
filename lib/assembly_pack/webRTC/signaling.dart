import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:flutter_text/utils/common/screen_select_dialog.dart';
import 'package:flutter_text/utils/common/random_string.dart';

import 'package:flutter_text/utils/common/device_info.dart';
import 'package:flutter_text/utils/common/websocket.dart';
import 'package:flutter_text/utils/common/turn.dart' ;

enum SignalingState {
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}

enum CallState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
}

enum VideoSource {
  Camera,
  Screen,
}

class Session {
  Session({required this.sid, required this.pid});

  String pid;
  String sid;
  RTCPeerConnection? pc;
  RTCDataChannel? dc;
  List<RTCIceCandidate> remoteCandidates = [];
}

class Signaling {
  Signaling(this._context);

  JsonEncoder _encoder = JsonEncoder();
  JsonDecoder _decoder = JsonDecoder();
  String _selfId = randomNumeric(6); //todo 之后改为服务端返回的id
  SimpleWebSocket? _socket;
  BuildContext? _context;
  final _host = GlobalStore.server;
  final _port = GlobalStore.port;
  var _turnCredential;
  Map<String, Session> _sessions = {};
  MediaStream? _localStream;
  List<MediaStream> _remoteStreams = <MediaStream>[];
  List<RTCRtpSender> _senders = <RTCRtpSender>[];
  VideoSource _videoSource = VideoSource.Camera;

  Function(SignalingState state)? onSignalingStateChange;
  Function(Session session, CallState state)? onCallStateChange;
  Function(MediaStream stream)? onLocalStream;
  Function(Session session, MediaStream stream)? onAddRemoteStream;
  Function(Session session, MediaStream stream)? onRemoveRemoteStream;
  Function(dynamic event)? onPeersUpdate;
  Function(dynamic event)? onInviteStream;
  Function(Session session, RTCDataChannel dc, RTCDataChannelMessage data)?
      onDataChannelMessage;
  Function(Session session, RTCDataChannel dc)? onDataChannel;

  String get sdpSemantics => 'unified-plan'; // unified-plan plan-b

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  void close() async {
    await _cleanSessions();
    _socket?.close();
  }

  // todo 邀请连接
  void inviteConn(String peerId)  async {

  }

  void invite(String peerId) async {
    var sessionId = _selfId + '-' + peerId;
    Session session = await _createSession(null,
        peerId: peerId, sessionId: sessionId, isInvite: true);
    _sessions[sessionId] = session;
    await _createDataChannel(session);
    await _createOffer(session);
    onCallStateChange?.call(session, CallState.CallStateNew);
    onCallStateChange?.call(session, CallState.CallStateInvite);
  }

  void bye(String sessionId) {
    _send('bye', {
      'session_id': sessionId,
      'from': _selfId,
    });
    var sess = _sessions[sessionId];
    if (sess != null) {
      _closeSession(sess);
    }
  }

  void accept(String sessionId) {
    var session = _sessions[sessionId];
    if (session == null) {
      return;
    }
    _createAnswer(session);
  }

  void reject(String sessionId) {
    var session = _sessions[sessionId];
    if (session == null) {
      return;
    }
    bye(session.sid);
  }

  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    var data = mapData['data'];
    if (mapData['type'] != null && mapData['type'] != '') {
      print('Received data: ' + message.toString());
    }
    switch (mapData['type']) {
      case 'peers':
        {
          List<dynamic> peers = data;
          if (onPeersUpdate != null) {
            Map<String, dynamic> event = Map<String, dynamic>();
            event['self'] = _selfId;
            event['peers'] = peers;
            onPeersUpdate?.call(event);
          }
        }
        break;
      case 'offer':
        {
            var peerId = data['from'];
            var description = data['description'];
            var sessionId = data['session_id'];
            var session = _sessions[sessionId];
            var newSession = await _createSession(session,
                peerId: peerId,
                sessionId: sessionId,
                isInvite: false);
            _sessions[sessionId] = newSession;
            await newSession.pc?.setRemoteDescription(
                RTCSessionDescription(description['sdp'], description['type']));
            // await _createAnswer(newSession);

            if (newSession.remoteCandidates.isNotEmpty) {
              newSession.remoteCandidates.forEach((candidate) async {
                await newSession.pc?.addCandidate(candidate);
              });
              newSession.remoteCandidates.clear();
            }
            onCallStateChange?.call(newSession, CallState.CallStateNew);
            onCallStateChange?.call(newSession, CallState.CallStateRinging);
          }
        break;
      case 'answer':
        {
          var description = data['description'];
          var sessionId = data['session_id'];
          var session = _sessions[sessionId];
          session?.pc?.setRemoteDescription(
              RTCSessionDescription(description['sdp'], description['type']));
          onCallStateChange?.call(session!, CallState.CallStateConnected);
        }
        break;
      case 'candidate':
        {
          var peerId = data['from'];
          var candidateMap = data['candidate'];
          var sessionId = data['session_id'];
          var session = _sessions[sessionId];
          RTCIceCandidate candidate = RTCIceCandidate(candidateMap['candidate'],
              candidateMap['sdpMid'], candidateMap['sdpMLineIndex']);

          if (session != null) {
            if (session.pc != null) {
              await session.pc?.addCandidate(candidate);
            } else {
              session.remoteCandidates.add(candidate);
            }
          } else {
            _sessions[sessionId] = Session(pid: peerId, sid: sessionId)
              ..remoteCandidates.add(candidate);
          }
        }
        break;
      case 'leave':
        {
          //todo 待修改
          var peerId = data as String;
          _closeSessionByPeerId(peerId);
        }
        break;
      case 'bye':
        {
          var sessionId = data['session_id'];
          print('bye: ' + sessionId);
          var session = _sessions.remove(sessionId);
          if (session != null) {
            onCallStateChange?.call(session, CallState.CallStateBye);
            _closeSession(session);
          }
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      default:
        break;
    }
  }

  // websocket连接
  Future<void> connect() async {
    var url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(url);

    print('connect to $url');

    if (_turnCredential == null) {
      try {
        _turnCredential = await getTurnCredential(_host, _port);
        _iceServers = {
          'iceServers': [
            {
              'urls': _turnCredential['uris'][0],
              'username': _turnCredential['username'],
              'credential': _turnCredential['password']
            },
          ]
        };
      } catch (e) {}
    }

    _socket?.onOpen = () {
      print('onOpen');
      onSignalingStateChange?.call(SignalingState.ConnectionOpen);
      _send('new', {
        'name': DeviceInfo.label,
        'id': _selfId,
        'user_agent': DeviceInfo.userAgent
      });
    };

    _socket?.onMessage = (message) {
      onMessage(_decoder.convert(message));
    };

    _socket?.onClose = (int? code, String? reason) {
      print('Closed by server [$code => $reason]!');
      onSignalingStateChange?.call(SignalingState.ConnectionClosed);
    };

    await _socket?.connect();
  }

  // 创建视频流
  Future<MediaStream> createStream(
      {BuildContext? context}) async {
    late MediaStream stream;
    if (WebRTC.platformIsDesktop) {
      // final source = await showDialog<DesktopCapturerSource>(
      //   context: context!,
      //   builder: (context) => ScreenSelectDialog(),
      // );
      stream = await navigator.mediaDevices
          .getDisplayMedia(<String, dynamic>{'audio': true, 'video': true});
    } else {
      stream = await navigator.mediaDevices.getDisplayMedia(<String, dynamic>{
        'audio': false,
        'video': true
      });
      // stream = await navigator.mediaDevices.getUserMedia(mediaConstraints); // 没问题
    }

    return stream;
  }

  // 创建session
  Future<Session> _createSession(
    Session? session, {
    required String peerId,
    required String sessionId,
    required bool isInvite,
  }) async {
    var newSession = session ?? Session(sid: sessionId, pid: peerId);

    _localStream = await createStream(context: _context);
    print('_iceServers:$_iceServers');
    RTCPeerConnection pc = await createPeerConnection({
      ..._iceServers,
      ...{'sdpSemantics': sdpSemantics}
    }, _config);

    switch (sdpSemantics) {
      case 'plan-b':
        pc.onAddStream = (MediaStream stream) {
          onAddRemoteStream?.call(newSession, stream);
          _remoteStreams.add(stream);
        };
        await pc.addStream(_localStream!);
        break;
      case 'unified-plan':
        pc.onTrack = (event) {
          if (event.track.kind == 'video') {
            onAddRemoteStream?.call(newSession, event.streams[0]);
          }
        };
        _localStream!.getTracks().forEach((track) async {
          _senders.add(await pc.addTrack(track, _localStream!));
        });
        break;
    }

    pc.onIceCandidate = (candidate) async {
      if (candidate == null) {
        print('onIceCandidate: complete!');
        return;
      }
      // This delay is needed to allow enough time to try an ICE candidate
      // before skipping to the next one. 1 second is just an heuristic value
      // and should be thoroughly tested in your own environment.
      await Future.delayed(
          const Duration(seconds: 1),
          () => _send('candidate', {
                'to': peerId,
                'from': _selfId,
                'candidate': {
                  'sdpMLineIndex': candidate.sdpMLineIndex,
                  'sdpMid': candidate.sdpMid,
                  'candidate': candidate.candidate,
                },
                'session_id': sessionId,
              }));
    };

    pc.onIceConnectionState = (state) {};

    pc.onRemoveStream = (stream) {
      onRemoveRemoteStream?.call(newSession, stream);
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    pc.onDataChannel = (channel) {
      _addDataChannel(newSession, channel);
    };

    newSession.pc = pc;
    return newSession;
  }

  void _addDataChannel(Session session, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};
    channel.onMessage = (RTCDataChannelMessage data) {
      onDataChannelMessage?.call(session, channel, data);
    };
    session.dc = channel;
    onDataChannel?.call(session, channel);
  }

  Future<void> _createDataChannel(Session session,
      {label = 'fileTransfer'}) async {
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit()
      ..maxRetransmits = 30;
    RTCDataChannel channel =
        await session.pc!.createDataChannel(label, dataChannelDict);
    _addDataChannel(session, channel);
  }

  Future<void> _createOffer(Session session, {String? media}) async {
    try {
      RTCSessionDescription s =
          await session.pc!.createOffer(media == 'data' ? _dcConstraints : {
            // 'mandatory': {
            //   'OfferToReceiveAudio': false,
            //   'OfferToReceiveVideo': true,
            // },
            // 'optional': [],
          });
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('offer', {
        'to': session.pid,
        'from': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  RTCSessionDescription _fixSdp(RTCSessionDescription s) {
    var sdp = s.sdp;
    s.sdp =
        sdp!.replaceAll('profile-level-id=640c1f', 'profile-level-id=42e032');
    return s;
  }

  Future<void> _createAnswer(Session session, {String? media}) async {
    try {
      RTCSessionDescription s =
          await session.pc!.createAnswer(media == 'data' ? _dcConstraints : {});
      await session.pc!.setLocalDescription(_fixSdp(s));
      _send('answer', {
        'to': session.pid,
        'from': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': session.sid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _send(event, data) {
    var request = Map();
    request["type"] = event;
    request["data"] = data;
    _socket?.send(_encoder.convert(request));
  }

  Future<void> _cleanSessions() async {
    if (_localStream != null) {
      _localStream!.getTracks().forEach((element) async {
        await element.stop();
      });
      await _localStream!.dispose();
      _localStream = null;
    }
    _sessions.forEach((key, sess) async {
      await sess.pc?.close();
      await sess.dc?.close();
    });
    _sessions.clear();
  }

  void _closeSessionByPeerId(String peerId) {
    var session;
    _sessions.removeWhere((String key, Session sess) {
      var ids = key.split('-');
      session = sess;
      return peerId == ids[0] || peerId == ids[1];
    });
    if (session != null) {
      _closeSession(session);
      onCallStateChange?.call(session, CallState.CallStateBye);
    }
  }

  Future<void> _closeSession(Session session) async {
    _localStream?.getTracks().forEach((element) async {
      await element.stop();
    });
    await _localStream?.dispose();
    _localStream = null;

    await session.pc?.close();
    await session.dc?.close();
    _senders.clear();
    _videoSource = VideoSource.Camera;
  }
}
