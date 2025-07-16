import 'package:flutter/material.dart';
import 'package:ma/controllers/app.dart';

class Imagem extends StatefulWidget {
  const Imagem({super.key});

  @override
  State<Imagem> createState() => _ImagemState();
}

class _ImagemState extends State<Imagem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Image.asset(App.img, fit: BoxFit.cover),
      ),
    );
  }
}
