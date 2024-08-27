import 'dart:convert';
import 'dart:io';
import 'dart:html';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PdfMaker {
  Future<void> printCustomersPdf() async {

    // Create a new PDF document.
    final PdfDocument document = PdfDocument();

    // Add a page to the document.
    final PdfPage page = document.pages.add();

    // Create a font for the headers.
    final PdfFont headerFont = PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);

    // Create a font for the content.
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

    // Define a starting point for the Y axis.
    double yOffset = 0;


    // Load a network image.
    final String imageUrl = 'https://avatars.githubusercontent.com/u/106102340?v=4';
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final PdfBitmap image = PdfBitmap(response.bodyBytes);

    // Draw the image on the page.
    yOffset += 0;
    page.graphics.drawImage(image, Rect.fromLTWH(0, yOffset, 100, 100));

    // Draw the header for the CV.
    yOffset += 100;
    page.graphics.drawString('John Doe', headerFont, bounds: Rect.fromLTWH(0, yOffset, 500, 40));

    // Draw contact information.
    yOffset += 30;
    page.graphics.drawString('Email: johndoe@example.com | Phone: +1234567890', contentFont, bounds: Rect.fromLTWH(0, yOffset, 500, 20));
    yOffset += 20;
    page.graphics.drawString('LinkedIn: linkedin.com/in/johndoe | GitHub: github.com/johndoe', contentFont, bounds: Rect.fromLTWH(0, yOffset, 500, 20));

    // Draw a line separator.
    yOffset += 20;
    page.graphics.drawLine(PdfPen(PdfColor(0, 0, 0)), Offset(0, yOffset), Offset(page.getClientSize().width, yOffset));

    // Add a section for the CV (Work Experience).
    yOffset += 30;
    page.graphics.drawString('Work Experience', headerFont, bounds: Rect.fromLTWH(0, yOffset, 500, 30));
    yOffset += 30;
    page.graphics.drawString(
        'Senior Flutter Developer\nABC Corp, 2018 - Present\n- Developed and maintained multiple mobile applications\n- Led a team of 5 developers in the implementation of new features\n',
        contentFont,
        bounds: Rect.fromLTWH(0, yOffset, 500, 80)
    );

    // Add more sections like Education, Skills, Projects, etc.
    yOffset += 90;
    page.graphics.drawString('Education', headerFont, bounds: Rect.fromLTWH(0, yOffset, 500, 30));
    yOffset += 30;
    page.graphics.drawString(
        'B.Sc. in Computer Science\nXYZ University, 2014 - 2018\n- Graduated with First-Class Honors\n',
        contentFont,
        bounds: Rect.fromLTWH(0, yOffset, 500, 60)
    );

    yOffset += 70;
    page.graphics.drawString('Skills', headerFont, bounds: Rect.fromLTWH(0, yOffset, 500, 30));
    yOffset += 30;
    page.graphics.drawString(
        '• Dart & Flutter\n• Firebase\n• REST APIs\n• Git & Version Control\n• Agile Methodologies\n',
        contentFont,
        bounds: Rect.fromLTWH(0, yOffset, 500, 80)
    );





    List<int> bytes =  await document.save();

    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "ss.pdf")
      ..click();

    document.dispose();
  }
}
