import 'package:chat_massanger_app/model/massage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instence of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receverID, massage) async {
    // get current user info
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp currentTime = Timestamp.now();

    // create a new massage
    Message newMassage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receverID: receverID,
      message: massage,
      timestamp: currentTime,
    );

    // constrac chat room id form current user id and recever id(sorted to ensure uniqess)
    List<String> ids = [currentUserID, receverID];
    ids.sort(); //untuk memastikan bhawa id chat room selalu sama untuk setiap pencocokan setiap orang
    String chatRoomID = ids.join(
        '_'); // menggabungkan ids ke dalam satu string digunakan untuk id char room

    // add a new massage to database
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMassage.toMap());
  }

  //  get message
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firebaseFirestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}
