import 'package:final_project/models/models.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserTypeScreen> {
  final List<UserType> user = [
    UserType(
        'student2.png',
        'Student',
        'You have to dream before your dreams can come true.',
        '- A.P.J. Abdul Kalam'),
    UserType(
        'teacher2.png',
        'Teacher',
        'Teaching is the highest form of understanding.',
        '- A.P.J. Abdul Kalam'),
  ];

  void onSignUp(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, 'teacherSignUp');
    } else {
      Navigator.pushNamed(context, 'studentSignUp');
    }
  }

  void onLogin(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, 'teacherLogin');
    } else {
      Navigator.pushNamed(context, 'studentLogin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        flexibleSpace: const CustomAppBar(),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: user.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage("assets/img/${user[index].img}"),
                fit: BoxFit.contain,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralAppText(
                        text: "Hello ${user[index].user}",
                        color: Theme.of(context).primaryColor,
                        weight: FontWeight.bold,
                      ),
                      GeneralAppText(
                        text: "Let the journey begin!",
                        color: Colors.black.withOpacity(0.8),
                        weight: FontWeight.normal,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onLogin(index);
                                },
                                child: PrimaryAppText(
                                  text: "Login",
                                  color: primaryColor,
                                  weight: FontWeight.bold,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onSignUp(index);
                                },
                                child: PrimaryAppText(
                                  text: "Sign Up",
                                  color: primaryColor,
                                  weight: FontWeight.bold,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        width: 300,
                        child: GeneralAppText(
                          text: "‘‘${user[index].quote}’’",
                          color: Theme.of(context).primaryColor,
                          size: 14,
                          weight: FontWeight.normal,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 80),
                          child: GeneralAppText(
                            text: user[index].speaker,
                            color: Theme.of(context).primaryColor,
                            weight: FontWeight.normal,
                            size: 14,
                          )),
                    ],
                  ),
                  Column(
                    children: List.generate(2, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index == indexDots ? 25 : 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index == indexDots
                                ? Colors.orange
                                : const Color.fromARGB(255, 255, 187, 84)),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
