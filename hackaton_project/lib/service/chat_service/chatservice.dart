import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/model/message.dart';

class Chatservice extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future <void> sendMessage(String receiverId, String message) async {

    //get current user
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;  
    final Timestamp timestamp = Timestamp.now();

    //create message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      receiverID: receiverId,
      message: message,
      timestamp: timestamp
    );

    //make a chat id
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatId = ids.join("_");

    //add new message to database
    await _firestore.collection('chat_rooms').doc(chatId).
    collection('messages').add(newMessage.toMap());
  }

  //get message

  Stream<QuerySnapshot> getMessages(String userId,String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatId = ids.join("_");
    return _firestore.collection('chat_rooms').doc(chatId).
    collection('messages').orderBy('timestamp',descending: false)
    .snapshots();
  }

}