import 'package:flutter/material.dart';
import 'package:notes_app/screens/signup.dart';
import 'package:notes_app/screens/forgot_password.dart';
import 'package:notes_app/utils/utility.dart';
import 'package:notes_app/database/database_handler.dart';
import '../theme/colors.dart';

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
  void dispose() {
    // Dispose controllers to prevent memory leaks
    mailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

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
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: mailcontroller,
                      hint: StringConst.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringConst.pleaseEnterEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),
                    _buildTextField(
                      controller: passwordcontroller,
                      hint: StringConst.password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringConst.pleaseEnterPassword;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          if (mounted) {
                            setState(() {
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                              isLoading = true; // Set loading state to true
                            });
                          }
                          try {
                            await DatabaseHandler()
                                .userLogin(email, password, context);
                          } catch (e) {
                           // toast(message: 'Login failed: $e');
                          } finally {
                            if (mounted) {
                              setState(() {
                                isLoading = false; // Reset loading state
                              });
                            }
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: bluecolor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
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
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    StringConst.forgotPassword,
                    style: TextStyle(
                      color: textGreycolor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Center(
              child: Text(
                StringConst.orLoginWith,
                style: TextStyle(
                  color: bluecolor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(ImageConst.google),
                const SizedBox(width: 30.0),
                _buildSocialIcon(ImageConst.apple),
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConst.dontHaveAccount,
                  style: TextStyle(
                    color: textGreycolor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    StringConst.signUp,
                    style: TextStyle(
                      color: bluecolor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFb2b7bf),
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String asset) {
    return GestureDetector(
      onTap: () {
        toast(message: StringConst.soonThisIsAvailable);
      },
      child: Image.asset(
        asset,
        height: 45,
        width: 45,
        fit: BoxFit.cover,
      ),
    );
  }
}
