import 'package:attendance_app/result_screen.dart';
import 'package:attendance_app/widgets/qr_overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'constant/colors.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              controller.toggleTorch();
            },
            icon: Icon(
              Icons.flash_on,
              color: isFlashOn ? primaryColor : greyColor,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              controller.switchCamera();
            },
            icon: Icon(
              Icons.camera_front,
              color: isFrontCamera ? primaryColor : greyColor,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: blackColor),
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
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place the QR Code in the area',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Scanning will be started  automatically',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        String code = barcode.rawValue ?? '---';
                        isScanCompleted = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              closeScreen: closeScreen,
                              code: code,
                            ),
                          ),
                        );
                        print(code);
                      }
                    },
                  ),
                  const QRScannerOverlay(overlayColour: bgColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
