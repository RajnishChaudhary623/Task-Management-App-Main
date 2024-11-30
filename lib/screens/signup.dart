import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/utils/utility.dart';

import '../theme/colors.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
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
                    borderRadius: BorderRadius.circular(20),
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
                            return StringConst.pleaseEnterName;
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: StringConst.name,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConst.pleaseEnterPassword;
                          }
                          return null;
                        },
                        controller: passwordcontroller,
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
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = mailcontroller.text;
                            name = namecontroller.text;
                            password = passwordcontroller.text;
                          });
                        }
                        registration();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: const Color(0xFF273671),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text(
                                StringConst.signIn,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500),
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Center(
              child: Text(
                StringConst.orLoginWith,
                style: TextStyle(
                    color: Color(0xFF273671),
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
                const Text(StringConst.alreadyAccount ,
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LogIn()));
                  },
                  child: const Text(
                    StringConst.login,
                    style: TextStyle(
                        color: Color(0xFF273671),
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
  registration() async {
    if (passwordcontroller.text.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty) {
      try {
        // Check connectivity before proceeding
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "No internet connection. Please try again later.",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
          return;
        }

        // Try to create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim());

        // Save user details in Firebase Authentication
        userCredential.user?.updateDisplayName(name.trim());

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Registered successfully! Redirecting to home...",
            style: TextStyle(fontSize: 20.0),
          ),
        ));

        // Navigate to the Home Page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // Email already exists; redirect to login
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "This email is already registered. Redirecting to login...",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LogIn()));
        } else if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "The password provided is too weak.",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "The email address is not valid.",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else {
          // Generic error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "An error occurred: ${e.message}",
              style: const TextStyle(fontSize: 18.0),
            ),
          ));
        }
      } catch (e) {
        // Handle any other errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "An unexpected error occurred: $e",
            style: const TextStyle(fontSize: 18.0),
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Please fill in all fields.",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    }
  }

}
