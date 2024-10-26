import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/Page/qrscan.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScanner extends StatelessWidget {

  final String code;
  final Function() closeScanner;

  const ResultScanner({super.key, required this.closeScanner, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
                      "QR SCANNER",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 20,
                    ),),
                    centerTitle: true,
                    leading: IconButton(onPressed: (){
                      closeScanner();
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
             
             QrImageView(
              data: code,
              size: 150,
              version: QrVersions.auto,),

            Text(
                "Scan Result",
                  style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 20,
                    ),),

          ],
        ),
      ),
    );
  }
}