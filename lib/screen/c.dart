// import 'dart:convert';
// import 'dart:html';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class PdfController extends GetxController {
//   var isLoading = false.obs;
//   late PdfFont font;


//   Future<void> generateAndDownloadPdf() async {
    
//     try {
//       isLoading(true);
      

//       // Load the custom font
//       final ByteData fontData =
//           await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
//       font = PdfTrueTypeFont(fontData.buffer.asUint8List(), 12);
//       final PdfFont headerFont = PdfTrueTypeFont(
//           fontData.buffer.asUint8List(), 24,
//           style: PdfFontStyle.bold);
//       final PdfFont subHeaderFont = PdfTrueTypeFont(
//           fontData.buffer.asUint8List(), 18,
//           style: PdfFontStyle.bold);

//       // Create a new PDF document
//       final PdfDocument document = PdfDocument();
//       final PdfPage page = document.pages.add();

//       // Draw the profile image
//       const String imageUrl =
//           'https://avatars.githubusercontent.com/u/106102340?v=4';
//       final http.Response response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         final PdfBitmap image = PdfBitmap(response.bodyBytes);
//         page.graphics.drawImage(image, const Rect.fromLTWH(30, 30, 100, 100));
//       }

//       // Draw name and title
//       page.graphics.drawString('Md Abdullah Al Siddik', headerFont,
//           bounds: const Rect.fromLTWH(150, 30, 400, 40));
//       page.graphics.drawString('Flutter Developer', subHeaderFont,
//           bounds: const Rect.fromLTWH(150, 70, 400, 30));

//       // Draw About Me section
//       double yOffset = 150;
//       page.graphics.drawString('About Me', subHeaderFont,
//           bounds: Rect.fromLTWH(30, yOffset, 500, 30));
//       yOffset += 30;
//       page.graphics.drawString(
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum at sem eget mauris vehicula aliquet.',
//           font,
//           bounds: Rect.fromLTWH(30, yOffset, 200, 80));

//       // Draw Contact Info
//       yOffset += 90;
//       page.graphics.drawString(
//           '📞 +123 456 7890\n✉️ hello@realemail.com\n📍 123 Anywhere St., Any City',
//           font,
//           bounds: Rect.fromLTWH(30, yOffset, 200, 60));

//       // Draw Skills section
//       yOffset += 90;

//       page.graphics.drawString('SKILLS', subHeaderFont,
//           bounds: Rect.fromLTWH(30, yOffset, 200, 30));
//       yOffset += 40;
//       page.graphics.drawString(
//           '• Dart & Flutter\n• Firebase\n• REST APIs\n• Git & Version Control\n• Agile Methodologies\n• UX/UI Design\n• Graphic Design',
//           font,
//           bounds: Rect.fromLTWH(30, yOffset, 500, 100));

//       // Draw Skills Summary
//        yOffset += 90;
     
//       page.graphics.drawString('SKILLS SUMMARY', subHeaderFont, bounds: Rect.fromLTWH(30, yOffset, 200, 20));
//       yOffset += 30;

//       drawSkillBar(page, 'Design Process', 0.78, 250, yOffset, );
//       yOffset += 30;
//       drawSkillBar(page, 'Project Management', 0.81, 250, yOffset,);

     

//       // Draw Experience section
//       double xOffset = 250;
//       yOffset = 150;
//       page.graphics.drawString('EXPERIENCE', subHeaderFont,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 500, 30));
//       yOffset += 30;
//       page.graphics.drawString(
//           'Studio Shovde\nCanberra - Australia\n2020 - 2022\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 300, 60));

//       yOffset += 70;
//       page.graphics.drawString(
//           'Elevenon Co.\nKota Baru - Singapore\n2016 - 2020\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 300, 60));

//       yOffset += 70;
//       page.graphics.drawString(
//           'Studio Shovde\nSydney - Australia\n2010 - 2015\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 300, 60));

//       // Draw Education section
//       yOffset += 90;
//       page.graphics.drawString('EDUCATION', subHeaderFont,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 500, 30));
//       yOffset += 30;
//       page.graphics.drawString(
//           'Borelle University\nBachelor of Business Management\n2014 - 2018',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 300, 50));

//       yOffset += 70;
//       page.graphics.drawString(
//           'Borelle University\nMaster of Business Management\n2018 - 2020',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 300, 50));

//       // Draw Projects section
//       yOffset += 120;
//       page.graphics.drawString('PROJECTS', subHeaderFont,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 500, 30));
//       yOffset += 40;
//       page.graphics.drawString(
//           'Project A\n• Developed a mobile app with 10K+ downloads\n• Implemented a new feature increasing engagement by 20%',
//           font,
//           bounds: Rect.fromLTWH(xOffset, yOffset, 200, 60));

//       // Save the document
//       List<int> bytes = await document.save();

//       // Trigger download of the PDF in the web browser
//       AnchorElement(
//           href:
//               "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
//         ..setAttribute("download", "resume.pdf")
//         ..click();

//       // Dispose of the document
//       document.dispose();
//     } catch (e) {
//       print("Error generating PDF: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   void drawSkillBar(PdfPage page, String skill, double percentage,
//       double xOffset, double yOffset, ) {
//     const double barWidth = 100;
//     page.graphics.drawString(skill, font,
//         bounds: Rect.fromLTWH(30, yOffset, 200, 20));

//     double filledWidth = percentage * barWidth;
//     page.graphics.drawRectangle(
//       pen: PdfPens.darkBlue,
//       brush: PdfBrushes.darkBlue,
//       bounds: Rect.fromLTWH(30, yOffset + 20, filledWidth, 10),
//     );
//     page.graphics.drawRectangle(
//       pen: PdfPens.gray,
//       bounds: Rect.fromLTWH(
//           30 + filledWidth, yOffset + 20, barWidth - filledWidth, 10),
//     );

//     page.graphics.drawString('${(percentage * 100).round()} %', font,
//         bounds: Rect.fromLTWH(30 + barWidth + 10, yOffset + 15, 50, 20));
//   }

  
 
// }
