import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/Page/chatpage.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => GroupChatState();
}

class GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        centerTitle: true,),
        body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('User').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      }
      );
  }
  Widget _buildUserListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    print(data);
    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['Nickname']),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            userName: data['Nickname'],
            recieveUserID: data['uid'],
          )));
        },
      );
    }else {
      return Container();
    }
  }

}