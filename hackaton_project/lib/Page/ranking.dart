import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/Page/chatpage.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}
class _RankingPageState extends State<RankingPage> {
  
  
  final List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'name': 'Alice', 'points': 1500},
    {'rank': 2, 'name': 'Bob', 'points': 1400},
    {'rank': 3, 'name': 'Charlie', 'points': 1300},
    {'rank': 4, 'name': 'Dave', 'points': 1200},
    {'rank': 5, 'name': 'Eve', 'points': 1100},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking Page'),
      ),
      body: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          final entry = leaderboard[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(entry['rank'].toString()),
              ),
              title: Text(entry['name']),
              subtitle: Text('Points: ${entry['points']}'),
              trailing: Icon(Icons.star, color: Colors.amber),
            ),
          );
        },
      ),
    );
  }
}