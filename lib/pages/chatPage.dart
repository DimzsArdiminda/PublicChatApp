import 'package:chat_massanger_app/component/chat_buble.dart';
import 'package:chat_massanger_app/component/my_text_field.dart';
import 'package:chat_massanger_app/services/chat/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String ReceverUserEmail;
  final String RecevierUserID;
  const ChatPage(
      {super.key,
      required this.ReceverUserEmail,
      required this.RecevierUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.RecevierUserID, _messageController.text);

      // clear text
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ReceverUserEmail),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(children: [
        // pesan
        Expanded(child: _buildMessageList()),

        // user input
        _buildMessageInput()
      ]),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.RecevierUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }

          return ListView(
            children: snapshot.data!.docs.map((document) => _buildMessageitem(document)).toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align the message to right or left if the sender is the current user or not
    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid) ?
          CrossAxisAlignment.end : CrossAxisAlignment.start,

          mainAxisAlignment:(data['senderID'] == _firebaseAuth.currentUser!.uid) ? 
          MainAxisAlignment.end : MainAxisAlignment.start,

          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message'])
            ,
          ],
        ),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
                controller: _messageController,
                hintText: "enter messege",
                obscureText: false)),

        // send button
        IconButton(
          onPressed: () {
            sendMessage();
          },
          icon: const Icon(
            Icons.send_sharp,
            color: Colors.blueGrey,
            size: 40,
          ),
        ),
      ],
    );
  }
}
