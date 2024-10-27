import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/Page/qrscan.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Mission Page", style: GoogleFonts.poppins(color: Colors.white)),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 29, 137, 225),
              Color.fromARGB(255, 2, 45, 217),
            ],
          ),
        ),
      ),
    ),
    body: Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('MissionUser').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Text('No data');
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length + 1, // Add 1 for the Mission container
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      // Return the Mission container
                      return Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "Mission",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      // Return the mission data
                      DocumentSnapshot missionUserDoc = snapshot.data!.docs[index - 1];
                      int missionID = missionUserDoc['MissionID'];

                      // Fetch the corresponding Mission document
                      Future<QuerySnapshot> missionDocFuture = FirebaseFirestore.instance
                          .collection('Mission')
                          .where('MissionID', isEqualTo: missionID)
                          .get();

                      return FutureBuilder(
                        future: missionDocFuture,
                        builder: (context, missionSnapshot) {
                          if (missionSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!missionSnapshot.hasData) {
                            return const Text('No data');
                          }

                          QuerySnapshot missionDoc = missionSnapshot.data!;

                          if (missionDoc.docs.isEmpty) {
                            return const Text('No mission found');
                          }

                          return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  missionUserDoc['Percentage'] != null
                                                    ? '${missionUserDoc['Percentage']}%'
                                                    : '0%',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                missionDoc.docs[0]['Name'],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(Icons.qr_code_scanner),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const ScanQR(),
                                                  ),
                                                );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}