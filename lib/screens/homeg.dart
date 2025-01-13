import 'package:flutter/material.dart';
import 'package:qrgcode/screens/Genererqrcode.dart';

class Homeg extends StatefulWidget {
  const Homeg({super.key});

  @override
  State<Homeg> createState() => _HomegState();
}

class _HomegState extends State<Homeg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(children: [
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
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            height: 300,
            width: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/git logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Bienvenue sur G.code',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Vous pouvez maintenant générer\n        ou scanner un QR.Code',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Genererqrcode()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              fixedSize: Size(200, 50),
            ),
            child: Text('Generer QR.Code',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
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
        ],
      ),
    ));
  }
}
