import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../controllers/profile_controller.dart';
import '../../../models/backend_model.dart';
import '../../../repository/authentication_repository.dart';
import 'chintan_chat_page.dart';

class ChatActivity extends StatefulWidget {
  const ChatActivity({Key? key}) : super(key: key);

  @override
  State<ChatActivity> createState() => _ChatActivityState();
}

class _ChatActivityState extends State<ChatActivity> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authService =
        Provider.of<AuthenticationRepository>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Mentors').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ......");
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    final controller = Get.put(ProfileController());
    return FutureBuilder(
      future: controller
          .getMentorData(), // Call getMentorByMentorId to fetch mentor data
      builder: (context, AsyncSnapshot<Mentor> mentorSnapshot) {
        if (mentorSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching mentor data
        } else if (mentorSnapshot.hasError) {
          return Text(
              'Error fetching mentor data : ${mentorSnapshot.error}'); // Show error if fetching fails
        } else {
          Mentor mentor =
              mentorSnapshot.data!; // Mentor data fetched successfully
          return ListTile(
            title: Text(mentor.mentorName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat_Page(
                    receiverUserEmail: mentor.mentorName,
                    receiverUserID: mentor.mentorId,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
