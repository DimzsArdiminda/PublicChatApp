import 'package:chat_massanger_app/pages/Home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // instance of firebase store 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // user login
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // add new document
      _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid' : userCredential.user!.uid,
          'email' : email,
          'timestamp' : DateTime.now().millisecondsSinceEpoch.toString(),
        }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // create new user 
  Future<UserCredential> signUpWithEmailandPassword(String email, password) async{
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // after creating new user we need to update the display name
        _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid' : userCredential.user!.uid,
          'email' : email,
          'timestamp' : DateTime.now().millisecondsSinceEpoch.toString(),
        });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // user logout
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
