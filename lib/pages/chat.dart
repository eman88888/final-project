import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:finalproject/models/messages.dart';
import 'package:finalproject/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Chat_Page extends StatefulWidget {
  const Chat_Page({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat_Page> {
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Message> messagesList = [];
  bool isTyping = false;

  void _sendMessage() async {
    String text = controller.text;
    String apiKey = "";
    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          messagesList.insert(0, Message(true, text));
          isTyping = true;
        });
        _controller.animateTo(0,
            duration: const Duration(milliseconds: 90), curve: Curves.easeOut);
        var response = await http.post(
            Uri.parse(""),
            headers: {
              "Authorization": "Bearer $apiKey",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": text}
              ]
            }));
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            messagesList.insert(
                0,
                Message(
                    false,
                    json["choices"][0]["message"]["content"]
                        .toString()
                        .trimLeft()));
          });
          _controller.animateTo(0,
              duration: const Duration(milliseconds: 90),
              curve: Curves.easeOut);
        }
      }
    } on Exception {
      // ignore: use_build_context_synchronously
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
                  ///main page of Chat
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
              //info page
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
                              child: Image.asset("assets/loading_animation.gif"),
                            ),),
                              )
                            ],
                          )
                        : BubbleNormal(
                            text: messagesList[index].message,
                            isSender: messagesList[index].isSender,
                            color: messagesList[index].isSender
                                ? const Color(0xFF1D5D9B)
                                : const Color(0xFFB5B5B5),
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: messagesList[index].isSender
                                  ? Colors.white
                                  : Colors.black, // ChatGPT text color
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
                controller.clear();
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
          )
        ],
      ),
    );
  }
}
