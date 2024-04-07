import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/common/chat/message_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final searchUserController = TextEditingController();

  final items = List.generate(3, (index) => index);

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Inbox',
          size: 22,
          weight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextField(
                  controller: searchUserController,
                  onChanged: (value) {
                    setState(() {
                      searchUserController.text = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: GeneralAppText(
                  text: 'Recent Chats',
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
              /* Student ko display karnewali list */
              //_buildUserList(),

              /* Teacher */
              // Chat List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MessageScreen(
                          userName: items[index].toString(),
                        );
                      }));
                    },
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(items[index].toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SecondaryAppText(
                                          text: 'John Doe',
                                          size: 17,
                                          weight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        SecondaryAppText(
                                          text: 'Hello, how are you?',
                                          size: 15,
                                          color: theme.isLightMode == true
                                              ? textColor1
                                              : textColor2,
                                        ),
                                      ],
                                    ),
                                    SecondaryAppText(
                                      text: '10:30 AM',
                                      size: 13,
                                      color: theme.isLightMode == true
                                          ? textColor1
                                          : textColor2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
