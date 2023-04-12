import 'dart:convert';

import 'package:flutter_text/init.dart';
import 'package:intl/intl.dart';

enum EventType {
  normal,
  finish,
  expire,
}

extension EventTypeTxt on EventType {
  String get enumToString {
    switch (this) {
      case EventType.normal:
        return 'normal';
      case EventType.finish:
        return 'finish';
      case EventType.expire:
        return 'expire';
    }
  }
}

extension EventTypeEunm on String {
  EventType? get stringToEnum {
    switch (this) {
      case 'normal':
        return EventType.normal;
      case 'finish':
        return EventType.finish;
      case 'expire':
        return EventType.expire;
    }
    return null;
  }
}

class Event {
  int id;
  String title;
  String desc; //内容
  String time;
  String type;

  Event(this.id, this.title, this.time, this.desc, this.type);

  String getTitle() => title;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        json['id'] as int,
        json['title'] as String,
        json['time'] as String,
        json['desc'] as String,
        json['type'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['time'] = time;
    data['type'] = type;
    return data;
  }

  static List<Event> listFromJson(List<dynamic>? json) {
    return json == null
        ? <Event>[]
        : json.map((e) => Event.fromJson(e)).toList();
  }
}

class EventHelper {
  static List<Event> event = [];

  static String key = 'calendar';

  static List<Event> getEvents(DateTime time) {
    final List<Event> res = _getAllEvents();
    event = res;
    return event
        .where(
          (e) => e.time == DateFormat('yyyy-MM-dd').format(time),
        )
        .toList();
  }

  static void setEvents(Event val) {
    event.add(val);
    _setEvents(val);
  }

  static void deleteOneEvent(Event val) {
    final List<Event> res = _getAllEvents();
    res.removeWhere((Event element) => element.id == val.id);
    event = res;
    LocateStorage.setString(key, jsonEncode(res));
  }

  static void changeOneEvent(Event val) {
    final List<Event> res = _getAllEvents();
    res.removeWhere((Event element) => element.id == val.id);
    res.add(val);
    event = res;
    LocateStorage.setString(key, jsonEncode(res));
  }

  static List<Event> _getAllEvents() {
    List<Event> res = [];
    final String? resString = LocateStorage.getString(key);
    if (resString != null) {
      res = Event.listFromJson(jsonDecode(resString));
    }
    return res;
  }

  static void _setEvents(Event val) {
    final List<Event> res = _getAllEvents();
    res.add(val);
    LocateStorage.setString(key, jsonEncode(res));
  }
}
