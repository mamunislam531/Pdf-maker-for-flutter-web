import 'package:flutter/material.dart';
import 'package:pdf_maker_flutter_web/screen/pdf_maker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              PdfMaker().printCustomersPdf();
            },
            child: Text("Make Pdf")),
      ),
    );
  }
}
