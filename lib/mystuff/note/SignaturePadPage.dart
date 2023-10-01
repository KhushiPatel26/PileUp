
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:path_provider/path_provider.dart';

class SignaturePadPage extends StatefulWidget {
  const SignaturePadPage({Key? key}) : super(key: key);

  @override
  State<SignaturePadPage> createState() => _SignaturePadPageState();
}

class _SignaturePadPageState extends State<SignaturePadPage> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  void _clearSignature() {
    _signaturePadKey.currentState?.clear();
  }

  void _saveAsPdf() async {
    final ui.Image image = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final Uint8List uint8List = byteData.buffer.asUint8List();

      final pdf = PdfDocument();
      final page = pdf.pages.add();

      final g = page.graphics;

      final signatureImage = PdfBitmap(uint8List);
      double h=signatureImage.height.toDouble();
      double w=signatureImage.width.toDouble();
      g.drawImage(
        signatureImage,
        Rect.fromLTWH(10,10, 10,10),
      );
      final directory = await getExternalStorageDirectory();

      if (directory != null) {
        final file = File('${directory.path}/document.pdf');
        final pdfBytes = await pdf.save();
        await file.writeAsBytes(pdfBytes);

        print("PDF saved at: ${file.path}");

      } else {
        print("Directory is null or not accessible.");

      }


      // final file = File('$customDirPath/signature.pdf'); // Change 'signature.pdf' to your desired file name
      // await file.writeAsBytes(await pdf.save());


      //print('PDF saved at: ${file.path}');
    } else {
      print('Error converting image to byte data.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature to PDF'),
        actions: [
          IconButton(onPressed: (){

          },
              icon: Icon(Icons.more_vert)
          )
        ],
      ),
      body: Column(
        children: [
          SfSignaturePad(
            key: _signaturePadKey,
            backgroundColor: Colors.white,
            strokeColor: Colors.black,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _clearSignature,
                child: Text('Clear'),
              ),
              ElevatedButton(
                onPressed: _saveAsPdf,
                child: Text('Save as PDF'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
