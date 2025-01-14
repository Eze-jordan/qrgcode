import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart'; // Import du package

class Scannerqrcode extends StatefulWidget {
  const Scannerqrcode({super.key});

  @override
  State<Scannerqrcode> createState() => _ScannerqrcodeState();
}

class _ScannerqrcodeState extends State<Scannerqrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 70),
                const Text(
                  "SCAN QR.CODE",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.green,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
            ),

            // Affichage des données scannées
            if (scannedData != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Données scannées : $scannedData',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final scannedCode = scanData.code;

      if (scannedCode != null &&
          Uri.tryParse(scannedCode)?.hasAbsolutePath == true) {
        // Si les données scannées sont une URL valide, ouvrir dans le navigateur
        if (await canLaunch(scannedCode)) {
          await launchUrl(Uri.parse(scannedCode)); // Utiliser launchUrl
        } else {
          print("Impossible d'ouvrir l'URL.");
        }
      } else {
        // Sinon, mettez simplement à jour l'affichage
        setState(() {
          scannedData = scannedCode;
        });
      }
    });
  }
}
