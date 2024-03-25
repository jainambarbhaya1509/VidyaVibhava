import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello", messageType: "receiver"),
  ChatMessage(messageContent: "Hi", messageType: "sender"),
];

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.userName});
  final String userName;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: SecondaryAppText(text: widget.userName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Container(
              height: 45,
              width: 120,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(66, 211, 210, 210),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GeneralAppIcon(
                    icon: Icons.call,
                    color: const Color.fromARGB(255, 77, 77, 77),
                    size: 20,
                  ),
                  const VerticalDivider(
                    color: Color.fromARGB(255, 77, 77, 77),
                    thickness: 0.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  GeneralAppIcon(
                      icon: Icons.video_call_rounded,
                      color: const Color.fromARGB(255, 77, 77, 77))
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(

                      borderRadius: messages[index].messageType == "receiver"
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: SecondaryAppText(
                      text: messages[index].messageContent,
                      size: 15,
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: GeneralAppIcon(
                        icon: Icons.send,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
