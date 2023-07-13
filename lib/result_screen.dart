import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'constant/colors.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final String macAddres;
  final Function() closeScreen;

  const ResultScreen({
    super.key,
    required this.code,
    required this.closeScreen,
    required this.macAddres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            closeScreen();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'QR Scanner',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show QR Code here
            QrImageView(
              data: code,
              size: 150,
              version: QrVersions.auto,
            ),

            const Text(
              'Scanned result',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Device Mac Address is: $macAddres',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
