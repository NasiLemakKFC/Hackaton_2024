import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
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
                Text("Your Earning",overflow: TextOverflow.clip, style:  GoogleFonts.poppins(color: Colors.white, fontSize: 30,decoration: TextDecoration.none)),
                Text("POINTS",overflow: TextOverflow.clip, style: GoogleFonts.poppins(color: Colors.white, fontSize: 30,decoration: TextDecoration.none)),
                Text("67 pts",overflow: TextOverflow.clip, style: GoogleFonts.poppins(color: Colors.white, fontSize: 60,decoration: TextDecoration.none)),
                SizedBox(height: 30,),

                Expanded(
                  child: Container(//warp in expand
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(width: 10,),
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
                        
                        // SizedBox(width: 50,),
                  
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
                  
                        // SizedBox(width: 50,),
                  
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
                        
                        // SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Mission section
        ],
                    ),
    );
  }
}