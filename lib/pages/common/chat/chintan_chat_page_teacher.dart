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

class TeacherChatActivity extends StatefulWidget {
  const TeacherChatActivity({Key? key}) : super(key: key);

  @override
  State<TeacherChatActivity> createState() => _TeacherChatActivityState();
}

class _TeacherChatActivityState extends State<TeacherChatActivity> {
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
    /*return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
    );*/
    return Container( // Wrap the ListView with a Container
      height: 150, // Provide a fixed height
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ......");
          }
          return _buildUserListItem();
        },
      ),
    );
  }

  Widget _buildUserListItem() {
    final controller = Get.put(ProfileController());
    return FutureBuilder(
      future: controller.getStudentForMentorData(),
      builder: (context, AsyncSnapshot<Iterable<Student>> studentSnapshot) {
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (studentSnapshot.hasError) {
          return Text('Error fetching mentor data : ${studentSnapshot.error}');
        } else {
          Iterable<Student> studentList = studentSnapshot.data!;
          print("\n\n\n\n\n\n\n\n\n\n\n Students Ka list : ${studentList.length}\n\n\n---------------------------\n\n\n\n\n-------------\n\n\n\n");
          return Container(
            height: MediaQuery.of(context).size.height, // Or specify a fixed height
            child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                final student = studentList.elementAt(index);
                return ListTile(
                  title: Text(student.firstName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat_Page(
                          receiverUserEmail: student.firstName,
                          receiverUserID: student.uid!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );

        }
      },
    );
  }
}
