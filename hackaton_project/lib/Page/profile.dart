import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override

  Future<void> _signOut() async{
       FirebaseAuth.instance.signOut();
                  }
  @override
  Widget build(BuildContext context) {

    return  Container(
      color: Colors.blue,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 45, 81),
        title:Text('Profile',style: GoogleFonts.poppins(color: Colors.white),),
        centerTitle: true,
        ),
        body: Column(
          children: [
             ElevatedButton(
                onPressed: () async {
                  await _signOut();
                  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ));
                },
                child: Text('sign out'),
             ),
          ]
      ),
      ),
    );
  }
}