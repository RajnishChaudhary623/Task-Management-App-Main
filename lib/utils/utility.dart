
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<Color> predefinedColors = [
  const Color(0xffFD99FF),
  const Color(0xffFF9E9E),
  const Color(0xfffedc56),
  const Color(0xfffca3b7),
  const Color(0xff91F48F),
  const Color(0xffB69CFF),
  const Color(0xff9EFFFF),
];

void toast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}
class StringConst{
  static const collectionNotes = "notes";
  static const collectionUser = "UserName";
  static const title = "Title";
  static const typing = "Start typing...";
  static const enterTitle = 'Enter Title';
  static const typesomething ='Type something in the body';
  static const enterEmail =  "Enter your mail";
  static const pleaseEnterEmail = 'Please Enter Email';
  static const email = "Email";
  static const sendEmail = "Send Email";
  static const dontHaveAccount = "Don't have an account?";
  static const create ="Create";
  static const passwordRecovery = "Password Recovery";
  static const areYouSureDelete = "Are you sure you want\nto delete this note ?";
  static const noConnection = 'No Internet Connection';
  static const createColourNotes=  "Create Colorful Notes";
  static const notes = 'Notes';
  static const registerSuccessuly ="Registered Successfully";
  static const signIn =  "Sign In";
  static const soonThisIsAvailable = "Soon This feature available";
  static const signUp = "Sign Up";
  static const orLoginWith = "or LogIn with";
  static const forgotPassword = "Forgot Password?";
  static const pleaseEnterPassword ='Please Enter Password';
  static const password = "Password";
  static const addNotes = "Add Notes";
  static const accountExists = "Account Already exists";
  static const emailInUse = "email-already-in-use";
  static const passwordProvidedIsTooWeak =  "Password Provided is too Weak";
  static const weakPassword = 'weak-password';
  static const alreadyAccount ="Already have an account?";
  static const login = "LogIn";
  static const name = "Name";
  static const pleaseEnterName= 'Please Enter Name';
}
//
class ImageConst{
  static const String loadingGif = "assets/ios_loadings.gif";
  static const String logo= "assets/logo.jpeg";
  static const String google= "assets/google.png";
  static const String apple= "assets/apple.png";
}