import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/main.dart';
import 'package:hackaton_project/service/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("User");

  Future<void> _signOut() async{
       FirebaseAuth.instance.signOut();
  }
  Future<void> editFields(String field, String userCollectionUid) async {
  String newValue = "";
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text('Edit $field',
        style: GoogleFonts.poppins(color: Colors.white),
      ),
      content: TextFormField(
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Enter new $field",
          hintStyle: GoogleFonts.poppins(color: Colors.white),
        ),
        onChanged: (value) {
          newValue = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(newValue),
          child: Text('Save', style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    ),
  );

  if (newValue.trim().isNotEmpty) {
    await userCollection.doc(userCollectionUid).update({ // Use the user collection uid to update the user data
      field: newValue
    });
  }
}

 @override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 45, 81),
        title: Text('Profile Page', style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("User").where("email", isEqualTo: user.email).limit(1)
          .snapshots().map((querySnapshot) => querySnapshot.docs[0]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final userCollectionUid = snapshot.data!.id; // Store the user collection uid

            return ListView(
              children: [
                SizedBox(height: 50,),
                Icon(Icons.person, size: 72,),

                Text(user.email!, style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,),

                SizedBox(height: 50,),

                Padding(padding: const EdgeInsets.only(left: 25),
                  child: Text('My Details', style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),),
                ),

                MyTextBox(text: userData['Nickname'], sectionName: 'username',
                  onPressed: () => editFields('Nickname', userCollectionUid),), // Pass the user collection uid to editFields

                MyTextBox(text: userData['Phone Number'], sectionName: 'Phone Number',
                  onPressed: () => editFields('Phone Number', userCollectionUid),), // Pass the user collection uid to editFields
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    )
  );
}
}


