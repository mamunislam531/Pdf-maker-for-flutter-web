import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker_flutter_web/screen/pdf_maker.dart';


class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.put(PdfController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate CV PDF'),
      ),
      body: Center(
        child: Obx(() {
          if (pdfController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return ElevatedButton(
              onPressed: () {
                pdfController.generateAndDownloadPdf();
              },
              child: const Text('Generate and Download PDF'),
            );
          }
        }),
      ),
    );
  }
}
