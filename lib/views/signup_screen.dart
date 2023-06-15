import 'package:app_api/componants/global/text_field_custom.dart';
import 'package:app_api/services/api/Auth/create_user.dart';
import 'package:app_api/services/extention/navigator/push_ext.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldCustom(
                hint: "user123",
                label: "User name",
                icon: Icons.person,
                onChanged: (value) {
                  username = value;
                },
              ),
              TextFieldCustom(
                hint: "Fahad Alazmi",
                label: "Name",
                icon: Icons.person,
                controller: nameController,
              ),
              TextFieldCustom(
                hint: "example@gmail.com",
                label: "Email",
                icon: Icons.email,
                controller: emailController,
              ),
              TextFieldCustom(
                hint: "AAaa1100229933",
                label: "password",
                icon: Icons.lock,
                obscureText: true,
                isPassword: true,
                onChanged: (pass) {
                  password = pass;
                },
              ),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Already have an account?',
                              style: TextStyle(fontSize: 16)),
                          InkWell(
                              onTap: () {
                                if (context.mounted) {
                                  context.pushAndRemove(
                                      view: const LoginScreen());
                                }
                              },
                              child: const Text('  Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))),
                        ],
                      ),
                      // _________________________ SignUp Button _________________________
                      Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.person_add),
                            label: const Text(
                              "SignUp",
                              style: TextStyle(fontSize: Checkbox.width),
                            ),
                            onPressed: () async {
                              if (nameController.text.isNotEmpty &&
                                  username != "" &&
                                  password != "" &&
                                  emailController.text.isNotEmpty) {
                                final Map body = {
                                  "email": emailController.text,
                                  "password": password,
                                  "username": username,
                                  "name": nameController.text
                                };
                                final response = await createUser(body: body);
                                if (response.statusCode == 200) {
                                  if (context.mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please fill the Signup form')));
                              }
                            },
                          )),
                    ],
                  ))
            ],
          ),
        ));
  }
}
