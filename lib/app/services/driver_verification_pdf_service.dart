import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class DriverVerificationPdfService {
  static const PdfColor tyvaaPrimaryColor = PdfColor(0.416, 0.051, 0.855);
  static const PdfColor tyvaaPrimaryLight = PdfColor(0.576, 0.337, 0.816);
  static const PdfColor tyvaaGreyLight = PdfColor(0.973, 0.976, 0.996);
  static const PdfColor tyvaaGreyBorder = PdfColor(0.875, 0.882, 0.914);

  Future<Uint8List> generateDriverVerificationPdf({
    required String driverName,
    required String driverPhone,
    String? driverEmail,
    String? dateNaissance,
    required File driverLicenseFrontImage,
    required File driverLicenseBackImage,
    required File carteGriseFrontImage,
    required File carteGriseBackImage,
    required File idCardFrontImage,
    required File idCardBackImage,
  }) async {
    final pdf = pw.Document();

    try {
      final dateFormatter = DateFormat('dd/MM/yyyy', 'fr_FR');
      final currentDate = dateFormatter.format(DateTime.now());

      pw.MemoryImage? driverLicenseFrontImageData;
      pw.MemoryImage? driverLicenseBackImageData;
      pw.MemoryImage? carteGriseFrontImageData;
      pw.MemoryImage? carteGriseBackImageData;
      pw.MemoryImage? idCardFrontImageData;
      pw.MemoryImage? idCardBackImageData;

      try {
        driverLicenseFrontImageData = await _safeLoadImage(
          driverLicenseFrontImage,
        );
        driverLicenseBackImageData = await _safeLoadImage(
          driverLicenseBackImage,
        );
        carteGriseFrontImageData = await _safeLoadImage(carteGriseFrontImage);
        carteGriseBackImageData = await _safeLoadImage(carteGriseBackImage);
        idCardFrontImageData = await _safeLoadImage(idCardFrontImage);
        idCardBackImageData = await _safeLoadImage(idCardBackImage);
      } catch (e) {
        print('Error loading images: $e');
      }

      final headingStyle = pw.TextStyle(
        fontSize: 18,
        fontWeight: pw.FontWeight.bold,
        color: tyvaaPrimaryColor,
      );

      final subheadingStyle = pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: tyvaaPrimaryLight,
      );

      final bodyStyle = pw.TextStyle(fontSize: 10, color: PdfColors.black);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(10),
                  color: tyvaaPrimaryColor,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'TYVAA',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'Documents du chauffeur · $currentDate',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 15),

                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  color: tyvaaGreyLight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Informations du chauffeur',
                        style: subheadingStyle,
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text('Nom: $driverName', style: bodyStyle),
                      if (dateNaissance != null)
                        pw.Text(
                          'Date de naissance: $dateNaissance',
                          style: bodyStyle,
                        ),
                      pw.Text('Téléphone: $driverPhone', style: bodyStyle),
                      if (driverEmail != null)
                        pw.Text('Email: $driverEmail', style: bodyStyle),
                    ],
                  ),
                ),

                pw.SizedBox(height: 15),

                pw.Text('Documents fournis', style: headingStyle),
                pw.SizedBox(height: 10),

                if (idCardFrontImageData != null && idCardBackImageData != null)
                  _buildDocumentSection(
                    'Pièce d\'identité',
                    idCardFrontImageData,
                    idCardBackImageData,
                    subheadingStyle,
                  ),

                pw.SizedBox(height: 10),

                if (driverLicenseFrontImageData != null &&
                    driverLicenseBackImageData != null)
                  _buildDocumentSection(
                    'Permis de conduire',
                    driverLicenseFrontImageData,
                    driverLicenseBackImageData,
                    subheadingStyle,
                  ),

                pw.SizedBox(height: 10),

                if (carteGriseFrontImageData != null &&
                    carteGriseBackImageData != null)
                  _buildDocumentSection(
                    'Carte grise',
                    carteGriseFrontImageData,
                    carteGriseBackImageData,
                    subheadingStyle,
                  ),

                pw.Spacer(),
                pw.Divider(),
                pw.Center(
                  child: pw.Text(
                    'TYVAA · Documents confidentiels',
                    style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                  ),
                ),
              ],
            );
          },
        ),
      );

      return pdf.save();
    } catch (e) {
      print('PDF generation error: $e');
      return _generateErrorPdf('Erreur de génération du PDF: $e');
    }
  }

  pw.Widget _buildDocumentSection(
    String title,
    pw.MemoryImage frontImage,
    pw.MemoryImage backImage,
    pw.TextStyle titleStyle,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: titleStyle),
        pw.SizedBox(height: 5),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Recto'),
                  pw.Container(
                    height: 120,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: tyvaaGreyBorder),
                    ),
                    child: pw.Image(frontImage, fit: pw.BoxFit.contain),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Verso'),
                  pw.Container(
                    height: 120,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: tyvaaGreyBorder),
                    ),
                    child: pw.Image(backImage, fit: pw.BoxFit.contain),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<Uint8List> _generateErrorPdf(String errorMessage) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Text(errorMessage));
        },
      ),
    );
    return pdf.save();
  }

  Future<pw.MemoryImage> _safeLoadImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return pw.MemoryImage(bytes);
    } catch (e) {
      print('Error loading image file: $e');
      return pw.MemoryImage(Uint8List.fromList([0, 0, 0, 0]));
    }
  }

  Future<void> saveAndSharePdf(Uint8List pdfBytes, String driverName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final sanitizedName = driverName
          .replaceAll(RegExp(r'[^\\w\s]+'), '')
          .trim()
          .replaceAll(' ', '_');
      final file = File(
        '${directory.path}/chauffeur_${sanitizedName}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      await file.writeAsBytes(pdfBytes);
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Documents du chauffeur: $driverName');
    } catch (e) {
      print('Error sharing PDF: $e');
    }
  }

  Future<void> previewPdf(Uint8List pdfBytes) async {
    try {
      await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
    } catch (e) {
      print('Error previewing PDF: $e');
    }
  }
}
