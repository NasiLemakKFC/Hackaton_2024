import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/chat.dart';
import 'package:hackaton_project/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Points section
          Container(
            height: 450,
            width: 500,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 29, 137, 225),
                  const Color.fromARGB(255, 2, 45, 217),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Text("Your Earning", style:  GoogleFonts.poppins(color: Colors.white, fontSize: 30)),
                Text("POINTS", style: GoogleFonts.poppins(color: Colors.white, fontSize: 30)),
                Text("67 pts", style: GoogleFonts.poppins(color: Colors.white, fontSize: 60)),
                SizedBox(height: 30,),
                Container(
                  height: 110,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          
                          IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset('asset/image/mission.png'),
                        ),
                        color: Colors.black,
                      ),
                      Text('Mission', style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),),
                        ],
                      ),
                      
                      SizedBox(width: 50,),

                      Column(
                        children: [
                          IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset('asset/image/ranking.png'),
                        ),
                        color: Colors.black,
                      ),
                      Text('Ranking', style: GoogleFonts.poppins(color: Colors.black, fontSize: 15)),
                        ],
                      ),

                      SizedBox(width: 50,),

                      Column(
                        children: [
                          IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset('asset/image/event.png'),
                        ),
                        color: Colors.black,
                      ),
                      Text('Event', style: GoogleFonts.poppins(color: Colors.black, fontSize: 15)),
                        ],
                      ),
                      
                      SizedBox(width: 20,),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mission section
        ],
                    ),
                    bottomNavigationBar: CurvedNavigationBar(
                      backgroundColor: Colors.blue,
                      animationDuration: Duration(milliseconds: 300),
                      color: Colors.blue.shade200,
                      onTap: (index){
                        if (index == 1) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const GroupChat(),
                          ));
                        }
                        else if (index == 0) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ));
                        }
                      },
                      items: [
                        Icon(Icons.home),
                        Icon(Icons.message),
                        Icon(Icons.person),
                      ],
                    ),
                    );
  }
}

