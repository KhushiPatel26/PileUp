import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class sketch extends StatefulWidget {
  const sketch({Key? key}) : super(key: key);

  @override
  State<sketch> createState() => _sketchState();
}

class _sketchState extends State<sketch> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Color pen = Colors.black;
  Color bg = Colors.white;
  // late ui.Image image;
  // ByteData? byteData;
  // void saveimg() async{
  //   image = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
  //   byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  // }
  void _clearSignature() {
    _signaturePadKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sketch'),
        actions: [
          IconButton(
              onPressed: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ListTile(
                        tileColor: Colors.grey[800],
                        leading: new Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                        title: new Text(
                          'Save as pdf',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          SnackBar(content: Text('pdf saved'));
                        },
                      );
                    });
              },
              icon: Icon(Icons.more_vert))
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
                  onPressed: _clearSignature, icon: Icon(Icons.delete_outline)),
              // IconButton(onPressed:(){
              //     setState(() {
              //       pen=Colors.transparent;
              //     });
              // }, icon: Icon(Icons.cleaning_services_sharp)),
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
                            ));
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
                  )),
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
                            ));
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
                  ))
            ],
          )),
    );
  }
}
