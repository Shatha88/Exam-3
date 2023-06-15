import 'dart:convert';

import 'package:app_api/componants/global/text_field_custom.dart';
import 'package:app_api/services/api/Auth/login.dart';
import 'package:app_api/services/extention/navigator/push_ext.dart';
import 'package:app_api/views/home_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
        appBar: AppBar(
          title: const Text("Sign in"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(children: [
            // __________________ Email TextFeild __________________
            TextFieldCustom(
              hint: "example@gmail.com",
              label: "Email",
              icon: Icons.email,
              controller: emailController,
            ),
            // __________________ Password TextFeild __________________
            TextFieldCustom(
              hint: "******",
              label: "Password",
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController,
            ),
            Align(
                alignment: Alignment.center,
                child: Column(children: [
                  Row(
                    children: [
                      const Text('New to the app click on',
                          style: TextStyle(fontSize: 16)),
                      InkWell(
                          onTap: () {
                            if (context.mounted) {
                              context.pushAndRemove(view: const SignUpScreen());
                            }
                          },
                          child: const Text('  Signup',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                    ],
                  ),
                  // _________________________ Login Button _________________________
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: Checkbox.width),
                      ),
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          final Map body = {
                            "email": emailController.text,
                            "password": passwordController.text,
                          };
                          lodingPage(context: context);
                          final response = await loginUser(body: body);
                          _test(response: response);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please enter email and Password')));
                        }
                      },
                    ),
                  ),
                ]))
          ]),
        ));
  }

  _test({required Response response}) async {
    if (response.statusCode == 200) {
      isloading = true;
      if (isloading) {
        final box = GetStorage();
        box.write("token", json.decode(response.body)["data"]["token"]);
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        }
      }
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter correct email and Password')));
      setState(() {});
    }
  }

  lodingPage({required BuildContext context}) {
    showDialog(
        context: context,
        barrierColor: const Color.fromARGB(0, 255, 255, 255),
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }
}
