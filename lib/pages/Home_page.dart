import 'package:chat_massanger_app/pages/chatPage.dart';
import 'package:chat_massanger_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Public Messenger App"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  } 

  // ignore: always_declare_return_types

  Widget _buildUserList() {
    // 
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .where((doc) => doc.id != _auth.currentUser?.uid)
              .map<Widget>(_buildUserListItem)
              .toList(),
        );
      },
    );
  }

  // membuat list item user yang akan ditampilkan (individual user list item)
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
      title: Text(data['email']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              // mengirim data email dan uid ke halaman chat
              ReceverUserEmail: data['email'],
              RecevierUserID: data['uid'],
            ),
          ),
        );
      },
    );
    }else{
      return Container();
    }
  }
}
