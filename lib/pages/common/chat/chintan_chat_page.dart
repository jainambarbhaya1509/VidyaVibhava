import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/chat_service.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/chat_bubble.dart';
import '../../../widgets/custom_text_field.dart';

class Chat_Page extends ConsumerStatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const Chat_Page({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  ConsumerState<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends ConsumerState<Chat_Page> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(theme),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Container(
      padding: const EdgeInsets.only(
          left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: ((data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))
                : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            color: (data['senderId'] == _firebaseAuth.currentUser!.uid
                ? Colors.grey.shade200
                : Colors.blue[200]),
          ),
          padding: const EdgeInsets.all(16),
          child: SecondaryAppText(
            text: data["message"],
            size: 15,
          ),),
      ),
    );

  }

  Widget _buildMessageInput(theme) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.isLightMode
              ? const Color.fromARGB(211, 228, 228, 228)
              : const Color.fromARGB(255, 54, 54, 54),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: sendMessage,
              child: GeneralAppIcon(
                
                icon: Icons.send,
                color: Colors.grey,
              ),
            ),
            hintText: "Send message",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
          ),
        ),
      ),

      // Container(
      //   width: double.infinity,
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(50),
      //     border: Border.all(color: Colors.grey),
      //   ),
      //   child: TextField(
      //     controller: _messageController,
      //     maxLines: null,
      //     decoration: InputDecoration(
      //       hintText: 'Type a message',
      //       hintStyle: const TextStyle(color: Colors.grey),
      //       border: InputBorder.none,
      //       suffixIcon: IconButton(
      //         icon: GeneralAppIcon(
      //           icon: Icons.send,
      //           color: Colors.grey,
      //         ),
      //         onPressed: () => sendMessage,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
