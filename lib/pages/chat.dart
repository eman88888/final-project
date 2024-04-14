import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:finalproject/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Chat_Page extends StatefulWidget {
  const Chat_Page({Key? key}) : super(key: key);
  @override
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1D5D9B),
          duration: Duration(milliseconds: 90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white, width: 2),
          ),
          content: Text(
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
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ///main page of Chat
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
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
              Text(
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
                  // Navigate to info page
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
          Divider(
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
                                textStyle: TextStyle(color: Colors.white),
                                
                              ),
                               Padding(
                                padding: EdgeInsets.only(left: 16, top: 4),
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
                                ? Color(0xFF1D5D9B)
                                : Color(0xFFB5B5B5),
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
                hintStyle: TextStyle(
                  color: Color(0xffA2A2A2),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send_rounded),
                  color: Color(0xFF047EB0),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: Color(0xFF047EB0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
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
