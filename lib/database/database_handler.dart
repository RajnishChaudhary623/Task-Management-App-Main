
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/utils/utility.dart';
import 'package:the_apple_sign_in/scope.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../screens/home_page.dart';

class DatabaseHandler {
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserCredential ?result;
  getCurrentUser() async {
    return await auth.currentUser;
  }
//add user details
  Future addUser(String userId, Map<String, dynamic>  userInfoMap){
    return FirebaseFirestore.instance.collection(StringConst.collectionUser).doc(userId).set(userInfoMap);
  }
  //to find notes collection

   static CollectionReference<Map<String, dynamic>> getNotesCollection(String userId,){
    return FirebaseFirestore.instance.collection(StringConst.collectionUser).doc(userId).collection(StringConst.collectionNotes);
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

     result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result?.user;

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "id": userDetails.uid
      };
      await addUser(userDetails.uid, userInfoMap)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }
  }
  //login with email
  userLogin(String email,String password,BuildContext context) async {
    UserCredential result =  await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    try {
      User? userDetails = result.user;
      if (result != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails?.email,
          "id": userDetails?.uid
        };
        await addUser(userDetails!.uid, userInfoMap).then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }


  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential = result.credential!;
        final oAuthCredential = OAuthProvider('apple.com');
        final credential = oAuthCredential.credential(
            idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
        final UserCredential = await auth.signInWithCredential(credential);
        final firebaseUser = UserCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = AppleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName}${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      default:
        throw UnimplementedError();
    }
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Note
  Future<void> createNote(NoteModel note) async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      final id = getNotesCollection(FirebaseAuth.instance.currentUser!.uid).doc().id;
      final newNote = NoteModel(
        id: id,
        title: note.title,
        body: note.body,
        color: note.color,
      ).toDocument();

      try {
        getNotesCollection(FirebaseAuth.instance.currentUser!.uid).doc(id).set(newNote);
      } catch (e) {
        toast(message: "Some error occur $e");
        print("Some error occur $e");
      }
    } else {
      print("Document ID is empty. Unable to create note.");
    }
  }


  // Read Note
  Stream<List<NoteModel>> getNotes() {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      return getNotesCollection(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList());
    } else {
      return Stream.value([]); // Return an empty stream if documentId is not set
    }
  }

  // Update/Edit Note
  Future<void> updateNote(NoteModel note) async {

    final newNote = NoteModel(
        id: note.id,
        title: note.title,
        body: note.body,
        color: note.color
    ).toDocument();

    try {
      await getNotesCollection(FirebaseAuth.instance.currentUser!.uid).doc(note.id).update(newNote);
    } catch (e) {
      print("Some error occur $e");
      toast(message: "Some error occur $e");
    }
  }

  // Delete Note
  Future<void> deleteNote(String id) async {

    try {
      await getNotesCollection(FirebaseAuth.instance.currentUser!.uid).doc(id).delete();
    } catch (e) {
      toast(message: "Some error occur $e");
      print("Some error occur $e");
    }
  }
  resetPassword(String email,context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Password Reset Email has been sent !",
            style: TextStyle(fontSize: 20.0),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
  }

}