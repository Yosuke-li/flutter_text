import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

class ChatGptPage extends StatefulWidget {
  const ChatGptPage({Key? key}) : super(key: key);

  @override
  State<ChatGptPage> createState() => _ChatGptPageState();
}

const Color backgroundColor = Color(0xff343541);
const Color botBackgroundColor = Color(0xff444654);

class _ChatGptPageState extends State<ChatGptPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late ChatGPTApi _api;

  String? _parentMessageId;
  String? _conversationId;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    _api = ChatGPTApi(
      // userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.2 Safari/605.1.15',
      clearanceToken:
          'frOrTltRdUBDGFgQlhio72J6h.l_BY2.IUrByjRO1ZQ-1676338419-0-1-529b268b.b9ed53d.59a796b-160',
      sessionToken: 'eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..AwfmE0tPUxE5PBkq.A-P-ItYk46U_JI_dGlmc8a6j9PP2JsiIRZ-cEw4O__dW6mjKZeR4__xuprHAEFTfc5lKPihkDa4Zqo3mDU4BmzZ74GNI0EcOtPFu6FXNigQUqTRVAp4FLKRF0W4BajndsZXL47qRlJntP7tFwDPQ2Vn4BTv3ThoWExUIUausJAthGmMD-vmpQ6HFNvdiJngB8aRoBnvvXbWVU6iLmjh-bcy2IIHTv2az5J72xfBnVD99JuJR1W5rM1SO3R078pX8LcJhKljKt_S8yo_X9ROX4VqfI5fDXwr2XlkdgClkmoxy1WNjrZIIOTUhZWDlRnXYqG5UuZHCpJdHpveSlXIf7TDzzNv8K3IB_i4H6IOd7Rxp3PVjRrDbHpuBU4_npo3j50qNpuLJgg31B022-1vEtCudnZtYoj1xrQpDybi4byUjVI-lL_P5PBMBpVKM7woNfG0eHa16tkEvNSETJY8HTbQG0O3szB0cgHNMHIfLiTBrHnYnclJ5TDfP5-E0K_HpaWKs07seTzSSHWE5tRrkdLoOI1jUUEfhKHUbrR49lB7HNhxkbLLGHmCHEPVTY73qxTp99QMtijLQpCEQGJiOQvXdn6NnupmQlOr_UsKPpbjpIu4kUxvQID7wNkyvleLLHnH3qbJx77Azn7ofGJEoEBob2BZnjy13vO_qC4v7vHtEaDACRlCcmU5orJt6IcMR5UQZ9fRb4-kKy8WLt3rwsyMbAS39DaqRKtoyjg6rvsXQ1eUDS8eL6oTkL2IL1GeuO9mY0ggXGad5qB6uglDK-UgEFILldM_5kuaB90Ys9Ysr7Eo9s_eVMNwzWnCoYr9sQ9uw-rlP-LJmw-lu-7v4qrVbDPQu7N_7yjAFCCIl5DiI-t24xd3aveLyjLIW4LWkVyAwYhSzFXek_8m7Yy3dkV3gCJLFzi-SEYLCfNRBqEAyKEdGgl2ezCEKOzDM66OQe6-wnaexhGJcpTudSeFQnKMAi-texVVZ8cbiL9EmPTW8erKLismqcmSHA11gbIBzgkY9K1WkRiZMxTFH76cF6XjsHFCUw7NBAcxbQuUu9-n2EIfx4S0gmtz92ZI48UuQtlQouzx3mrJ8mpIlpoS2Bh2VsTG5QnT3lJknkB8PERVk0lTw4Ah3XQY6xObJts-fJQTAOgnyG49Er0xCEOWL97UbBRqa7MBk__2FlTOridYYUHmEUoFiCDFoUTEAuQd9fLxJ8CGKqzwe0Ad91j78Z71RZ6LcIgxAirYAmAK7imNrh0vm8c44qfunK9MXWZQXA66MXBZBibrl0P6Swxw8IJnf7AS6NBL9LZLz0AQjF-W1kV3KD0nK-F_jOM9slFCP_SmX68CB4xNGPeuukTMdW-nA7o0ZCIesHm0EA-234GJx1RuIJSpM-fZD9Aan_ASaOjW-maGOV4IdvMXrHFJ60DKpG69g2LacpqvXmQcgIul-pUEqdlPDjJgWaRzO44d6WtjvV7vl8muq3aZE2-t3e4FglHMsf9QQjtDvKLkUraltb7DqW8RLm6AgrAXlDk8v54RguYc0KyKAebdzumbMv8MvwhJIHFT26ktGdXIBWTSibavzyw7atdDD0zpJIiGMk-43zMbZfxYA80YLg4lcrbYHIZYSXUv3C2BDgH6MflNw8Ty1Ddh-6Ha-QTRzRmrxWic5ON6MlN-OTMmVXMn7zjTvOssuR-YUvVmPkfjrlEJ5vs0xS5Q_hZQS6S5FH0ZaVehDaxV8vq-o3PkIKHTFb2quTHiDGRdPqF7GRPeSQKHCM1n2O9x1qLDQl_0UFPl59TXN5nFlgIEd4ho_FGapGZnQ6IqR_VBgYC-pR1ya7KjtBODAiCR_TqdKmHOvOekllzUglH2wVUOCMMHS195LYkQOnm1OXmpP4p1ays-Scd0n9Y8-oAEE0UH6UGjluYXpx9rBfau2GRlVRDsGd_Zy4S4FYn1BDJeCqBHcvt_iiveFrr1FYxduEzQCJQ38l5f7REnm2qJmUcoDBjhK7pewqep-4VaJndnhPDneT9Wv8zY52oAyi8A22Emec59qBzaSnkt4nIjwcssoGgZXT85qs8wJ0De6outlzqDoPeogL04DSdGOkJbPTqJX_GaB1bQd4RdahGtSC035m2dDkfL0jrUz9ykkazo__jn5lOO2aPccx_Qycx85Dokp4nnJwp156PtMma6TOcViF65vp84IBExd1gKEK7xENL6LpxnKqYoBuAAd4KwGLusCeWgWQdDlBC6_tAfxthSEbmbGv0nO8ysx45099BSE9lqtRZ2HSGGyHYpRlvRIQv9IHwSVowjG5JEC8J_qzVkvfzDDp2xSx-LcphWwoiH1znGM7eAI6zOjK_112-deOqz6WCCIJJkAv8ss0ntBzqhRsQFjZrhCtnB-F-t92QeEpTpvAf0vuFNorlnZ4MD_ad8csxnOGPpAACjrJVMeGpUk8ms3LMWfoUng7LU85l4qma-Dc3ZtRQ3QVHhKDKTlPIxtUDAm2cnnxGP6bJSweSS2Bf1_UPWXdb04hltjxoDCcGl_.-Qc_ugodAwZojVbrl2NXdw'
    );
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGpt text'),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            var newMessage = await _api.sendMessage(
              input,
              conversationId: _conversationId,
              parentMessageId: _parentMessageId,
            );
            setState(() {
              _conversationId = newMessage.conversationId;
              _parentMessageId = newMessage.messageId;
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: newMessage.message,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset(
                      'assets/bot.png',
                      color: Colors.white,
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
