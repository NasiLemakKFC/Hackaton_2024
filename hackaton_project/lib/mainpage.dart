import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/Page/chat.dart';
import 'package:hackaton_project/Page/homepage.dart';
import 'package:hackaton_project/Page/profile.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

int dex = 0;
@override
Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: getselectedwidget(index: dex),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blue,
          index: dex,
          animationDuration: Duration(milliseconds: 300),
          color: Colors.blue.shade200,
          onTap: (index){
            setState(() {
              dex = index;
              print(dex);
            });
          },
          items: [
            Icon(Icons.home),
            Icon(Icons.message),
            Icon(Icons.person),
          ],
        ),
      );
    }
  Widget getselectedwidget({required int index}){
  Widget widget;
  switch(index){
    case 1:
      widget = GroupChat();
      break;
    case 2:
      widget = Profile();
      break;
    default:
      widget = HomePage();
      break;
  }
  print(widget);
  return widget;
}
}


