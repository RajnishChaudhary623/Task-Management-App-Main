// ignore_for_file: use_build_context_synchronously

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database/database_handler.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/signup.dart';
import 'package:notes_app/utils/utility.dart';
import '../theme/colors.dart';
import 'forgot_password.dart';
import 'package:notes_app/theme/colors.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";
  bool isLoading = false; // Boolean variable to track loading state

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: ListView(
          children: [
            SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      ImageConst.logo,
                    ))),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConst.pleaseEnterEmail;
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: StringConst.email,
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConst.pleaseEnterPassword;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: StringConst.password,
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = mailcontroller.text;
                            password = passwordcontroller.text;
                            isLoading = true; // Set loading state to true
                          });
                        }
                        try {
                          // Perform the login operation
                          await DatabaseHandler().userLogin(email, password, context);
                          // You can add more logic after the login is successful
                        } catch (e) {
                          // Handle login errors if needed
                          toast(message: 'Login failed: $e');
                        } finally {
                          setState(() {
                            isLoading = false; // Set loading state to false
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: bluecolor,
                            borderRadius: BorderRadius.circular(30)),
                        child:  Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                            // Display a CircularProgressIndicator while loading
                            valueColor: AlwaysStoppedAnimation<Color>(
                              whiteColor,
                            ),
                          )
                              : const Text(
                            StringConst.signIn,
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()));
              },
              child:  Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(StringConst.forgotPassword,
                      style: TextStyle(
                          color: textGreycolor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          Center(
              child: Text(
                StringConst.orLoginWith,
                style: TextStyle(
                    color: bluecolor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    toast(message: StringConst.soonThisIsAvailable);
                    //  DatabaseHandler().signInWithGoogle(context);
                  },
                  child: Image.asset(
                    ImageConst.google,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    toast(message: StringConst.soonThisIsAvailable);
                    //DatabaseHandler().signInWithApple();
                  },
                  child: Image.asset(
                    ImageConst.apple,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringConst.dontHaveAccount,
                    style: TextStyle(
                        color: textGreycolor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
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
                  child:  Text(
                    StringConst.signUp,
                    style: TextStyle(
                        color: bluecolor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
