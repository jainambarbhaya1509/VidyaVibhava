import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/authentication_repository.dart';
import '../signups/signup_pages/personal_info.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String? errorMessage1;
  String? errorMessage2;

  @override
  void initState() {
    loadSavedData();
    super.initState();
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('studentUsername') ?? '';
      _phoneNumberController.text = prefs.getString('studentPhoneNumber') ?? '';
    });
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('studentUsername', _usernameController.text);
    prefs.setString('studentPhoneNumber', _phoneNumberController.text);
  }

  void validatePhoneNumber() {
    setState(() {
      if (_phoneNumberController.text.length < 10) {
        errorMessage1 = "Invalid Phone Number";
      } else {
        errorMessage1 = null;
        Navigator.pushNamed(context, 'getOTP', arguments: 0);
      }
    });
  }

  void validateUsername() {
    setState(() {
      if (_usernameController.text.isEmpty) {
        errorMessage2 = "Invalid Username";
      } else {
        errorMessage2 = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GeneralAppText(
                          text: "Hi",
                          color: Theme.of(context).primaryColor,
                          weight: FontWeight.w300,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GeneralAppText(
                          text: "Student",
                          color: Theme.of(context).primaryColor,
                          weight: FontWeight.bold,
                          size: 24,
                        ),
                      ],
                    ),
                    GeneralAppText(
                      text: "Login to Continue!",
                      color: Theme.of(context).primaryColor,
                      weight: FontWeight.normal,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/login.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Enter Username',
                        errorText: errorMessage2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Enter your phone number',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              '+91 |',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          errorText: errorMessage1),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  validatePhoneNumber();
                  validateUsername();

                  if (errorMessage1 == null && errorMessage2 == null) {
                    AuthenticationRepository.instance.phoneAuthentication(_phoneNumberController.text);
                    saveData();
                    Navigator.pushReplacementNamed(
                      context,
                      'getOTP',
                      arguments: 0,
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryAppText(
                        text: "Get OTP",
                        size: 15,
                        weight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GeneralAppIcon(
                        icon: Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'studentSignUp');
                },
                child: GeneralAppText(
                  text: "Don't have an account? Sign Up",
                  size: 15,
                  weight: FontWeight.normal,
                  alignment: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('studentUsername');
    prefs.remove('studentPhoneNumber');
  }
}
