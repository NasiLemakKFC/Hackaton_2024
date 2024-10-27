import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key, required this.text, 
    required this.onPressed,required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.only(left: 15,bottom: 15),
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(sectionName,style: GoogleFonts.poppins(color: Colors.grey.shade500),),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.settings,color: Colors.grey.shade500,)),
            ]
            ),
          Text(text),
        ],
      ),
    );
  }
}