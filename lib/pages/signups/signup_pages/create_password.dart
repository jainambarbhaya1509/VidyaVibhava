import 'package:final_project/controllers/sign_up_controller.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePassword extends ConsumerStatefulWidget {
  const CreatePassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyYourselfState();
}

TextEditingController createPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _VerifyYourselfState extends ConsumerState<CreatePassword> {
  final controller = SignUpController();
  @override
  Widget build(BuildContext context) {
    final password = ref.read(createPasswordProvider.notifier).state;
    final teacherPersonalInfo = ref.watch(teacherPersonalInfoProvider);
    return Container(
      margin: const EdgeInsets.only(
        left: 30,
        top: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppText(
            text: "Create Password",
            size: 20,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                GeneralAppText(
                  text: "Enter Password",
                  size: 17,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    password['password'] = createPasswordController.text;
                  },
                  obscureText: true,
                  controller: createPasswordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: GeneralAppIcon(
                        icon: Icons.password,
                        size: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter your password',
                      errorText: null),
                ),
                const SizedBox(
                  height: 30,
                ),
                GeneralAppText(
                  text: "Confirm Password",
                  size: 17,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    password['confirmPassword'] =
                        confirmPasswordController.text;
                  },
                  obscureText: true,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: GeneralAppIcon(
                        icon: Icons.password,
                        size: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Confirm your password',
                      errorText: null),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    controller.RegisterUser(teacherPersonalInfo["email"],
                        confirmPasswordController.text);
                    // Add your logic for creating the account here
                  },
                  child: Text('Create Account'),
                ),
              ]),
        ],
      ),
    );
  }
}
