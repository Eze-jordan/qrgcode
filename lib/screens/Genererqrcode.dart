import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrgcode/screens/scannerqrcode.dart';

class Genererqrcode extends StatefulWidget {
  const Genererqrcode({super.key});

  @override
  State<Genererqrcode> createState() => _GenererqrcodeState();
}

class _GenererqrcodeState extends State<Genererqrcode> {
  final TextEditingController _controller = TextEditingController();
  String _qrData = ""; // Données à encoder dans le QR code

  // Fonction pour télécharger l'image
  Future<void> _downloadQRCode() async {
    if (_qrData.isEmpty) return;

    // Demander la permission d'accéder au stockage
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        // ignore: unused_local_variable
        final path = '${directory.path}/qrcode.png';

        // Créer l'image QR avec QrPainter
        final qrCodeImage = await QrPainter(
          data: _qrData,
          version: QrVersions.auto,
          errorCorrectionLevel: QrErrorCorrectLevel.L,
        ).toImage(300);

        // Convertir l'image QR en bytes
        final byteData =
            await qrCodeImage.toByteData(format: ImageByteFormat.png);
        final buffer = byteData!.buffer.asUint8List();

        // Sauvegarder l'image dans le stockage
        final result =
            await ImageGallerySaver.saveImage(Uint8List.fromList(buffer));
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR Code téléchargé avec succès !')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Échec du téléchargement du QR Code.')),
          );
        }
      } catch (e) {
        print('Erreur lors du téléchargement du QR Code: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Une erreur s\'est produite.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission de stockage non accordée')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Iconsax.arrow_left_1,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 120),
                    Column(children: [
                      Container(
                        height: 50,
                        width: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/qrlogo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        'G code',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Un QR code (Quick Response Code) est un type de code-barres en 2D qui permet de stocker divers types d'informations, comme des liens URL, des contacts, des messages ou encore des informations de paiement. Dans cette application, vous pouvez générer un QR code personnalisé à partir du texte ou du lien que vous entrez.",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                // Champ de texte pour entrer un lien ou du texte
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Entrez le lien ou le texte',
                    hintText: 'Entrez votre lien ou texte ici',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0x41FFFFFF),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _qrData = value; // Mise à jour des données du QR code
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Affichage du QR code
                if (_qrData.isNotEmpty)
                  QrImageView(
                    data: _qrData, // Données à encoder
                    size: 300.0, // Taille du QR code
                    backgroundColor: Colors.white, // Couleur de fond
                    foregroundColor: Colors.black, // Couleur du QR code
                  ),
                const SizedBox(height: 20),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scannerqrcode()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(200, 50),
                  ),
                  child: Text('Scanner QR.Code',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
                // Bouton pour télécharger le QR Code
                ElevatedButton(
                  onPressed: _downloadQRCode,
                  child: const Text("Télécharger le QR Code"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
