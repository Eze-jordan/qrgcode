import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scannerqrcode extends StatefulWidget {
  const Scannerqrcode({super.key});

  @override
  State<Scannerqrcode> createState() => _ScannerqrcodeState();
}

class _ScannerqrcodeState extends State<Scannerqrcode> {
  final GlobalKey<QRViewController> qrKey =
      GlobalKey<QRViewController>(); // Utilisation de QRViewController
  String _qrResult = "Scan a QR Code"; // Résultat du scan

  // Fonction appelée lorsque la vue du scanner est prête
  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _qrResult = scanData.code; // Mettre à jour le résultat du scan
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner QR Code"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated:
                  _onQRViewCreated, // Lier la fonction à l'événement de création
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _qrResult, // Afficher le résultat du scan
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
