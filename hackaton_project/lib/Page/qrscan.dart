import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_project/Page/resultscan.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xfffafafa);

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  bool isScanCompleted = false;

  void closeScanner() {
    isScanCompleted = false;
  }

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
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  children: [
                    Text(
                      "Place the QR code in the frame",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 20,
                    ),),
                  ],
                ),
              ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                onDetect: (barcodeCapture) {
                    if (!isScanCompleted) {
                      String code = barcodeCapture.barcodes.first.rawValue ?? '---';
                      isScanCompleted = true;
                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => 
                                        ResultScanner(closeScanner: closeScanner, code: code,),
                                      ),);
                  }
                },
              ),
            ),
            Expanded(child: Container(
              alignment: Alignment.center,
              child: Text(
                      "Powered by CamScanner",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 14,
                    ),),
            ))
          ],
        ),
      ),
    );
  }
}