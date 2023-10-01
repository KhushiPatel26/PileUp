import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class viewnote extends StatefulWidget {
  const viewnote({Key? key}) : super(key: key);

  @override
  State<viewnote> createState() => _viewnoteState();
}

class _viewnoteState extends State<viewnote> {
  late QuillEditorController controller;

  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');

  Color _backgroundColor = Color(0xFF212121);

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    // controller.onEditorLoaded(() {
    //   debugPrint('Editor Loaded :)');
    // });
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            //download...
            //snackbar....Pdf saved
          },
              icon: Icon(Icons.download_for_offline)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title",style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
            QuillHtmlEditor(
              text: "<h1>Hello</h1>This is a <b>quill</b> html editor <u>example</u> 😊",
              hintText: 'Type something',
              controller: controller,
              isEnabled: true,
              //ensureVisible: false,
              minHeight: 500,
              //autoFocus: false,
              textStyle: _editorTextStyle,
              hintTextStyle: TextStyle(
                  fontSize: 18, color: _backgroundColor == Colors.black ||
                  _backgroundColor == Color(0xFF212121)
                  ? Colors.white30
                  : Colors.black38, fontWeight: FontWeight.normal),
              hintTextAlign: TextAlign.start,
              padding: const EdgeInsets.only(top: 10),
              backgroundColor:_backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
