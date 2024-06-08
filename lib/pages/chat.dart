//chat 
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:finalproject/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/svg.dart';

class Message {
  final String message;
  final bool isSender;

  Message({required this.message, required this.isSender});
}

const String GEMINI_API_KEY = 'AIzaSyD_YN09H-umI4NGz2VvsoESthhMk9zC2JY';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  final Gemini gemini = Gemini.instance;
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Message> messagesList = [];
  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  //main page of chat
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              Image.asset(
                'assets/Animation3.gif',
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
              const Text(
                'Mr. Tox',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'MulishRomanBold',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const info()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 180),
                  child: SvgPicture.asset(
                    'assets/information.svg',
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.9,
            color: Colors.blueGrey,
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesList.length,
              controller: _controller,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: isTyping && index == 0
                      ? Column(
                          children: [
                            BubbleNormal(
                              text: messagesList[0].message,
                              isSender: true,
                              color: Colors.blue.shade100,
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 120,
                                  width: 110,
                                  child: Image.asset(
                                      "assets/loading_animation.gif"),
                                ),
                              ),
                            ),
                          ],
                        )
                      : BubbleNormal(
                          text: messagesList[index].message,
                          isSender: messagesList[index].isSender,
                          color: messagesList[index].isSender
                              ? const Color(0xFF1D5D9B)
                              : Color.fromARGB(255, 212, 207, 207),
                          textStyle: TextStyle(
                            fontSize: 17,
                            color: messagesList[index].isSender
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                _sendMessage();
              },
              decoration: InputDecoration(
                hintText: 'Write your message',
                hintStyle: const TextStyle(
                  color: Color(0xffA2A2A2),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send_rounded),
                  color: const Color(0xFF047EB0),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: Color(0xFF047EB0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF88AACA),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    String text = controller.text;
    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          messagesList.insert(0, Message(message: text, isSender: true));
          isTyping = true;
        });
        _controller.animateTo(0,
            duration: const Duration(milliseconds: 50), curve: Curves.easeOut);

        gemini
            .streamGenerateContent(
              text,
            )
            .listen((event) {
          String response = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';

          setState(() {
            isTyping = false;
            messagesList.insert(
                0, Message(message: response.trimLeft(), isSender: false));
          });
          _controller.animateTo(0,
              duration: const Duration(milliseconds: 90),
              curve: Curves.easeOut);
        });
      }
    } catch (e) {
      setState(() {
        isTyping = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF1D5D9B),
          duration: const Duration(milliseconds: 90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          content: const Text(
            "Some error occurred, please try again!",
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFFF1F4FF),
            ),
          ),
        ),
      );
    }
  }
}
