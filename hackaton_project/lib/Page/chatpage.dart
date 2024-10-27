import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/service/chat_service/chatbubble.dart';
import 'package:hackaton_project/service/chat_service/chatservice.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String recieveUserID;
  const ChatPage({super.key, 
  required this.userName, 
  required this.recieveUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final Chatservice _chatservice = Chatservice();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatservice.sendMessage(widget.recieveUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          _buildMessageInput(),

          SizedBox(height: 25,),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
   return StreamBuilder(
     stream: _chatservice.getMessages(
      widget.recieveUserID, _firebaseAuth.currentUser!.uid),
     builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView(
        children: snapshot.data!.docs.map((document) => 
        _buildMessageItem(document)).toList(),
      );
     },
   );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid) ?
     Alignment.centerRight : Alignment.centerLeft;

     return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: 
        (data['senderID'] == _firebaseAuth.currentUser!.uid) ? 
        CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid) ? 
        MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Text(data['senderEmail']),
          SizedBox(height: 5  ,),
          ChatBubble(message: data['message']), 
        ],
      ),
     );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Enter a Message',
              ),
              obscureText: false,
              ),
              ),
      
              IconButton(onPressed: _sendMessage, 
              icon: const Icon(Icons.arrow_upward,size: 30,))
        ],
      ),
    );
  }
}
