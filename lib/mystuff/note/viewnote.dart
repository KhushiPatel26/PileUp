import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:pup/DB/models.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../DB/ApiService3.dart';

class viewnote extends StatefulWidget {
  NotebookPage? nbpgid;
  QuillEditorController? controller1;
  String? title;
  Color? bgcolor;
  viewnote({Key? key, this.controller1, this.title, this.bgcolor,  this.nbpgid}) : super(key: key);

  @override
  State<viewnote> createState() => _viewnoteState();
}

class _viewnoteState extends State<viewnote> {
  late QuillEditorController controller;
  final _editorTextStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black, // Adjust the color as needed
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );

  Color _backgroundColor = Colors.white; // Adjust the background color as needed

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    super.initState();
    print('note book pg: ${widget.nbpgid}');

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Future<void> convertToPdf() async {
    String? htmlContent = await widget.controller1?.getText();
print("html................."+htmlContent!);
    final pdf = pdfWidgets.Document();

    // Add content to the PDF
    pdf.addPage(
      pdfWidgets.Page(
        pageTheme: pdfWidgets.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: pdfWidgets.EdgeInsets.all(32),

        ),
        build: (context) =>
            pdfWidgets.Container(

              width: double.infinity,
              height: double.infinity,
              color: PdfColor.fromInt(widget.nbpgid==null? widget.bgcolor!.value: int.parse(widget.nbpgid!.pgbgcolor!)),
              //color: PdfColor(red, green, blue),
              //color: PdfColor(widget.bgcolor.red.toDouble(), widget.bgcolor.green.toDouble(), widget.bgcolor.blue.toDouble(),widget.bgcolor.alpha.toDouble()),
              child:pdfWidgets.Column(

              crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
              children: <pdfWidgets.Widget>[
                pdfWidgets.Text(
                 widget.nbpgid==null? widget.title! : widget.nbpgid!.pgtitle!,
                  style: pdfWidgets.TextStyle(
                    fontSize: 30,
                    fontWeight: pdfWidgets.FontWeight.bold,
                  ),
                ),
                pdfWidgets.SizedBox(height: 20),
                pdfWidgets.Container(
                  child: pdfWidgets.Text(
                    htmlContent,
                    style: pdfWidgets.TextStyle(
                      fontSize: 18,
                      color: PdfColors.white, // Adjust text color if needed
                    ),
                  )
                ),
              ],
            ),
            ),
      ),
    );

    final directory = await getExternalStorageDirectory();

    if (directory != null) {
      final file = File('${directory.path}/document.pdf');
      await file.writeAsBytes(await pdf.save());

      print("PDF saved at: ${file.path}");
    } else {
      print("Directory is null or not accessible.");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved successfully'),
      ),
    );
  }
  void getHtmlText() async {
    String? htmlText = await widget.controller1?.getText();
    debugPrint(htmlText);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgcolor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: convertToPdf,
            icon: Icon(Icons.download_for_offline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nbpgid==null? widget.title! : widget.nbpgid!.pgtitle!,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black, // Adjust title color if needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              if(widget.nbpgid==null)
              FutureBuilder<String>(
                future: widget.controller1?.getText(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return QuillHtmlEditor(
                      text: snapshot.data ?? "",
                      hintText: 'Type something',
                      controller: controller,
                      isEnabled: false,
                      minHeight: 500,
                      textStyle: _editorTextStyle,
                      hintTextStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                        fontWeight: FontWeight.normal,
                      ),
                      hintTextAlign: TextAlign.start,
                      padding: const EdgeInsets.only(top: 10),
                      backgroundColor: widget.bgcolor!,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              if(widget.nbpgid!=null)
                Html(
                  data: widget.nbpgid?.pgcontent!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}