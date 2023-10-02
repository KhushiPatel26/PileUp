import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class sketch extends StatefulWidget {
  const sketch({Key? key}) : super(key: key);

  @override
  State<sketch> createState() => _sketchState();
}

class _sketchState extends State<sketch> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Color pen = Colors.black;
  Color bg = Colors.white;

  void _clearSignature() {
    _signaturePadKey.currentState?.clear();
  }

  Future<void> saveAsPdf() async {
    final signatureImage = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? data = await signatureImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List bytes = data!.buffer.asUint8List();

    final pdfDocument = pdf.Document();
    pdfDocument.addPage(
      pdf.Page(
          build: (context) {
            return pdf.Center(
              child: pdf.Image(pdf.MemoryImage(bytes)),
            );
          }
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/signature.pdf');
    await file.writeAsBytes(await pdfDocument.save());

    print("PDF saved at: ${file.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sketch'),
        actions: [
          IconButton(
            onPressed: () async {
              await saveAsPdf();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('PDF saved successfully'),
                ),
              );
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 630,
            child: SfSignaturePad(
              key: _signaturePadKey,
              backgroundColor: bg,
              strokeColor: pen,
              maximumStrokeWidth: 5,
              minimumStrokeWidth: 1,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.black,
        child: Row(
          children: [
            IconButton(
              onPressed: _clearSignature,
              icon: Icon(Icons.delete_outline),
            ),
            TextButton(
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Pick a color"),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Color(0xffffffff),
                        paletteType: PaletteType.hueWheel,
                        onColorChanged: (Color value) {
                          setState(() {
                            pen = value;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: pen,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pen Color',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Pick a color"),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Color(0xff000000),
                        paletteType: PaletteType.hueWheel,
                        onColorChanged: (Color value) {
                          setState(() {
                            bg = value;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: bg,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Bg Color",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}