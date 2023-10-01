import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class addmsg extends StatefulWidget {
  const addmsg({Key? key}) : super(key: key);

  @override
  State<addmsg> createState() => _addmsgState();
}

class _addmsgState extends State<addmsg> {
  late QuillEditorController controller;
  late QuillEditorController printcontroller;
  //TextEditingController msgController=TextEditingController();
    String msgText="";

  Color _backgroundColor = Color(0xFF212121);
  final _toolbarColor = Colors.black; //grey.shade200;
  //final _backgroundColor = Colors.black.withOpacity(0.5);
  final _toolbarIconColor = Colors.white30;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);
  final texteditingTools = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.strike,
    ToolBarStyle.underline,
    ToolBarStyle.color,
    ToolBarStyle.background,
  ];
  final alignTools = [
    ToolBarStyle.align,
    ToolBarStyle.directionLtr,
    ToolBarStyle.directionRtl,
    ToolBarStyle.indentAdd,
    ToolBarStyle.indentMinus,
  ];
  final formatTools = [ToolBarStyle.blockQuote, ToolBarStyle.codeBlock];
  final sizeTools = [
    ToolBarStyle.size,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo
  ];
  final unreTools = [ToolBarStyle.undo, ToolBarStyle.redo];
  final strucTools = [
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];
  final cleanTools = [ToolBarStyle.clean, ToolBarStyle.clearHistory];
  final fileTools = [ToolBarStyle.image, ToolBarStyle.video, ToolBarStyle.link];

  bool _hasFocus = false;
  bool maintoolbox = true;
  List<ToolBarStyle> toolList = [];
  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    // controller.onEditorLoaded(() {
    //   debugPrint('Editor Loaded :)');
    // });
    printcontroller= QuillEditorController();
    printcontroller.onTextChanged((text){
      debugPrint('msg....... $text');
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
        icon: Icon(Icons.cancel_rounded,color: Colors.black,),
        ),
        actions: [
          Padding(
              padding:
              const EdgeInsets.all(
                  8),
              child: ElevatedButton(
                onPressed: () async {

                  ScaffoldMessenger.of(
                      context)
                      .showSnackBar(
                      SnackBar(
                          backgroundColor:
                          Colors
                              .white,
                          content:
                          Text(
                            'Message Posted',
                            style: TextStyle(
                                color:
                                Colors.black),
                          )));
                },
                child: Padding(
                  padding:
                  const EdgeInsets
                      .only(
                      top: 3.0,
                      bottom: 3.0,
                      left: 3.0,
                      right: 3.0),
                  child: Text(
                    "SEND",
                    style: TextStyle(
                      wordSpacing: 2,
                        color: Colors
                            .white,
                        fontWeight:
                        FontWeight
                            .w300,
                        fontSize: 12),
                  ),
                ),
                style: ElevatedButton
                    .styleFrom(
                  backgroundColor:
                  Colors.black,
                  //primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors
                              .black),
                      borderRadius:
                      BorderRadius
                          .circular(
                          30)),
                  elevation: 0.0,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 20,right: 20),
          child: Column(
            children: [
              Container(
                color: Colors.white12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        "Write Your Message here:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10,),
                    QuillHtmlEditor(
                      //  text: "<h1>Hello</h1>This is a <b>quill</b> html editor example 😊",
                      hintText: 'Ask a question or post an update',
                      controller: controller,
                      isEnabled: true,
                      //ensureVisible: false,
                      minHeight: 150,
                      //autoFocus: false,
                      textStyle: _editorTextStyle,
                      hintTextStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black38,
                          fontWeight: FontWeight.normal),
                      hintTextAlign: TextAlign.start,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      hintTextPadding: const EdgeInsets.only(left: 20),
                      backgroundColor: Colors.grey.withOpacity(0.1), //_backgroundColor,
                      //inputAction: InputAction.newline,
                      // onEditingComplete: (s) => debugPrint('Editing completed $s'),
                      //  loadingBuilder: (context) {
                      //    return const Center(
                      //        child: CircularProgressIndicator(
                      //          strokeWidth: 1,
                      //          color: Colors.red,
                      //        ));
                      //  },
                      onFocusChanged: (focus) {
                        debugPrint('has focus $focus');
                        setState(() {
                          _hasFocus = focus;
                        });
                      },
                      onTextChanged: (text) =>
                      {debugPrint('widget text change $text'),
                        msgText=text,
                        print("msgText: $msgText")
                      },
                      onEditorCreated: () {
                        debugPrint('Editor has been loaded');
                        //setHtmlText('Testing text on load');
                      },
                      onEditorResized: (height) =>
                          debugPrint('Editor resized $height'),
                      onSelectionChanged: (sel) =>
                          debugPrint('index ${sel.index}, range ${sel.length}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        "Files:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1)
                      ),
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              IconButton(onPressed: (){},
                                  icon: Icon(Icons.picture_as_pdf,color: Colors.redAccent.withOpacity(0.8),size: 50,)
                              ),
                              Text("data.pdf",style: TextStyle(color: Colors.black))
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    QuillHtmlEditor(
                        text: msgText,
                      controller: printcontroller,
                      minHeight: 50,
                      isEnabled: false,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        margin: EdgeInsets.all(7),
        child: Column(
          children: [
            Visibility(
              visible: !maintoolbox,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 250,
                      child: ToolBar(
                          toolBarColor: _toolbarColor,
                          padding: const EdgeInsets.all(8),
                          iconSize: 25,
                          iconColor: Colors.grey,//_toolbarIconColor,
                          activeIconColor: Colors.white,//greenAccent.shade100,
                          controller: controller,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          toolBarConfig: toolList//fileTools//cleanTools//strucTools//unreTools//sizeTools//formatTools//texteditingTools//alignTools,
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      maintoolbox=true;
                    });

                  },
                      icon: Icon(Icons.cancel_rounded))
                ],
              ),
            ),
            Visibility(
              visible: maintoolbox,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=unreTools;
                        });
                      },
                      icon: Icon(
                        Icons.alt_route_rounded,
                        color: Colors.white,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=texteditingTools;
                        });
                      },
                      icon: Icon(
                        Icons.text_format,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=strucTools;
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=alignTools;
                        });
                      },
                      icon: Icon(
                        Icons.format_align_center,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=sizeTools;
                        });
                      },
                      icon: Icon(
                        Icons.format_size,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=formatTools;
                        });
                      },
                      icon: Icon(
                        Icons.format_quote,
                        color: Colors.white,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) {
                    //           return SingleChildScrollView(
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 ListTile(
                    //                   tileColor: Colors.grey[800],
                    //                   leading: new Icon(
                    //                     Icons.check_box_outlined,
                    //                     color: Colors.white,
                    //                   ),
                    //                   title: new Text(
                    //                     'Checkboxes',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                   onTap: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   icon: Icon(
                    //     Icons.text_snippet,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=cleanTools;
                        });
                      },
                      icon: Icon(
                        Icons.layers_clear_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          maintoolbox=false;
                          toolList=fileTools;
                        });
                      },
                      icon: Icon(
                        Icons.attachment,
                        color: Colors.white,
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.draw_outlined,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(width: 50),
                    // IconButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) {
                    //           return SingleChildScrollView(
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 ListTile(
                    //                   tileColor: Colors.grey[800],
                    //                   leading: new Icon(
                    //                     Icons.delete_outline,
                    //                     color: Colors.white,
                    //                   ),
                    //                   title: new Text(
                    //                     'Delete',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                   onTap: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //                 ListTile(
                    //                   tileColor: Colors.grey[800],
                    //                   leading: new Icon(
                    //                     Icons.copy,
                    //                     color: Colors.white,
                    //                   ),
                    //                   title: new Text(
                    //                     'Make a copy',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                   onTap: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //                 ListTile(
                    //                   tileColor: Colors.grey[800],
                    //                   leading: new Icon(
                    //                     Icons.share,
                    //                     color: Colors.white,
                    //                   ),
                    //                   title: new Text(
                    //                     'Share',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                   onTap: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //                 ListTile(
                    //                   tileColor: Colors.grey[800],
                    //                   leading: new Icon(
                    //                     Icons.label_outline,
                    //                     color: Colors.white,
                    //                   ),
                    //                   title: new Text(
                    //                     'Label',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                   onTap: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   icon: Icon(
                    //     Icons.more_vert,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }


  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
    // setState(() {
    //   msgText=htmlText;
    // });
  }

  Future<String> getHtmlT() async{
    String? htmlt=await controller.getText();
    return htmlt;
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();

}
