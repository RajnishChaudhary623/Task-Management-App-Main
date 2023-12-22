import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database/database_handler.dart';
import 'package:notes_app/screens/signup.dart';
import 'package:notes_app/utils/utility.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 70.0,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              StringConst.passwordRecovery,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            StringConst.enterEmail,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white70, width: 2.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return StringConst.pleaseEnterEmail;
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: StringConst.email,
                                hintStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 30.0,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                              });
                              DatabaseHandler().resetPassword(email,context);
                            }
                          },
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                StringConst.sendEmail,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              StringConst.dontHaveAccount,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text(
                                StringConst.create,
                                style: TextStyle(
                                    color: Color.fromARGB(225, 184, 166, 6),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
