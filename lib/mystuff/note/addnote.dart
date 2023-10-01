import 'package:flutter/material.dart';
import 'package:pup/colors.dart';
import 'package:pup/mystuff/note/sketch.dart';
import 'package:pup/mystuff/note/viewnote.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import 'notes.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  ///[controller] create a QuillEditorController to access the editor methods
  late QuillEditorController controller;

  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
    //s ToolBarStyle.size
  ];

  final texteditingTools=[
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.strike,
    ToolBarStyle.underline,
    ToolBarStyle.color,
    ToolBarStyle.background,
  ];
  final alignTools=[
    ToolBarStyle.align,
    ToolBarStyle.directionLtr,
    ToolBarStyle.directionRtl,
    ToolBarStyle.indentAdd,
    ToolBarStyle.indentMinus,
  ];
  final formatTools=[
    ToolBarStyle.blockQuote,
    ToolBarStyle.codeBlock
  ];
  final sizeTools=[
    ToolBarStyle.size,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo
  ];
  final unreTools=[
    ToolBarStyle.undo,
    ToolBarStyle.redo
  ];
  final strucTools=[
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];
  final cleanTools=[
    ToolBarStyle.clean,
    ToolBarStyle.clearHistory
  ];
  final fileTools=[
    ToolBarStyle.image,
    ToolBarStyle.video,
    ToolBarStyle.link
  ];
  final _toolbarColor = Colors.black; //grey.shade200;
  //final _backgroundColor = Colors.black.withOpacity(0.5);
  final _toolbarIconColor = Colors.white30;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;
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

  TextEditingController title = TextEditingController();
  TextEditingController hinttxt = TextEditingController();
  TextEditingController tag = TextEditingController();
  bool isPinned = false;
  TextEditingController notepwController = TextEditingController();
  List<Color> bgcolorlist = [
    Colors.black,
    Color(0xFF212121),
    Colors.white,
    pink,
    red,
    orange,
    brown,
    yellow,
    green,
    blue,
    purple
  ];
  Color _backgroundColor = Color(0xFF212121);
  bool maintoolbox=true;
  List<ToolBarStyle> toolList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, //Colors.grey[900],
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          onPressed: () async {
            SnackBar(content: Text('note saved'));
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isPinned = !isPinned;
              });
            },
            icon:
                isPinned ? Icon(Icons.push_pin) : Icon(Icons.push_pin_outlined),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            title: new Text(
                              'Note Lock',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () async {
                              await showDialog<void>(
                                  context: context,
                                  builder: (context) => Container(
                                        height: 600,
                                        width: 720,
                                        child: AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: <Widget>[
                                              Positioned(
                                                left: -40,
                                                top: -40,
                                                child: InkResponse(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Icon(Icons.close),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            left: 20,
                                                            bottom: 10),
                                                    child: Text(
                                                      'Set a Note-Lock',
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF101213),
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0, bottom: 5),
                                                    child: Text(
                                                      'Secure Your Note',
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF101213),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    "lib/assets/share_code.png",
                                                    width: 130,
                                                    height: 120,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 10, 16),
                                                    child: Container(
                                                      width: 370,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 15,
                                                            spreadRadius: 1,
                                                            offset:
                                                                Offset(0, 7),
                                                          ),
                                                        ],
                                                      ),
                                                      child: TextFormField(
                                                          controller:
                                                              notepwController,
                                                          autofocus: true,
                                                          autofillHints: [
                                                            AutofillHints.email
                                                          ],
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Password',
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              color: Color(
                                                                  0xFF57636C),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFF1F4F8),
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFFF5963),
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFFF5963),
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            filled: true,
                                                            fillColor: Color(
                                                                0xFFF1F4F8),
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            color: Color(
                                                                0xFF101213),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      content:
                                                                          Text(
                                                                        'Note-Lock is Set',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      )));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5.0,
                                                                  bottom: 5.0,
                                                                  left: 3.0,
                                                                  right: 3.0),
                                                          child: Text(
                                                            "Set Password",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            title: new Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(
                              Icons.picture_as_pdf,
                              color: Colors.white,
                            ),
                            title: new Text(
                              'Save as pdf',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => viewnote()));
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            title: new Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Colors.grey[900],
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 0, right: 250, top: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Select Tags",
                        style: TextStyle(
                            fontSize: 12,
                            color: _backgroundColor == Colors.black ||
                                    _backgroundColor == Color(0xFF212121)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: _backgroundColor == Colors.black ||
                                _backgroundColor == Color(0xFF212121)
                            ? Colors.white.withOpacity(0.3)
                            : Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: _backgroundColor == Colors.black ||
                                    _backgroundColor == Color(0xFF212121)
                                ? Colors.white
                                : Colors.black,
                            width: 0.5)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  cursorColor: Colors.white,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontSize: 30.0,
                        color: _backgroundColor == Colors.black ||
                                _backgroundColor == Color(0xFF212121)
                            ? Colors.white30
                            : Colors.black38),
                  ),
                ),
              ),
              // ToolBar(
              //   toolBarColor: _toolbarColor,
              //   padding: const EdgeInsets.all(8),
              //   iconSize: 25,
              //   iconColor: _toolbarIconColor,
              //   activeIconColor: Colors.white,//greenAccent.shade100,
              //   controller: controller,
              //   crossAxisAlignment: WrapCrossAlignment.start,
              //   direction: Axis.horizontal,
              //   //toolBarConfig: texteditingTools,
              //   customButtons: [
              //     Container(
              //       width: 5,
              //       height: 5,
              //       decoration: BoxDecoration(
              //           color: _hasFocus ? Colors.green : Colors.grey,
              //           borderRadius: BorderRadius.circular(15)),
              //     ),
              //     // InkWell(
              //     //     onTap: () => unFocusEditor(),
              //     //     child: const Icon(
              //     //       Icons.favorite,
              //     //       color: Colors.black,
              //     //     )),
              //     // InkWell(
              //     //     onTap: () async {
              //     //       var selectedText = await controller.getSelectedText();
              //     //       debugPrint('selectedText $selectedText');
              //     //       var selectedHtmlText =
              //     //       await controller.getSelectedHtmlText();
              //     //       debugPrint('selectedHtmlText $selectedHtmlText');
              //     //     },
              //     //     child: const Icon(
              //     //       Icons.add_circle,
              //     //       color: Colors.black,
              //     //     )),
              //   ],
              // ),
              Container(
                color: _backgroundColor,
                child: QuillHtmlEditor(
                //  text: "<h1>Hello</h1>This is a <b>quill</b> html editor example 😊",
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
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  hintTextPadding: const EdgeInsets.only(left: 20),
                  backgroundColor:_backgroundColor,
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
                  onTextChanged: (text) => debugPrint('widget text change $text'),
                  onEditorCreated: () {
                    debugPrint('Editor has been loaded');
                    //setHtmlText('Testing text on load');
                  },
                  onEditorResized: (height) =>
                      debugPrint('Editor resized $height'),
                  onSelectionChanged: (sel) =>
                      debugPrint('index ${sel.index}, range ${sel.length}'),
                ),
              ),

              // Container(
              //   color: Colors.grey[900],
              //   //height:500,
              //   child:Padding(
              //     padding: const EdgeInsets.only(left: 20.0),
              //     child: TextField(
              //       controller: hinttxt,
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //       keyboardType: TextInputType.multiline,
              //       maxLines: null,
              //       cursorColor: Colors.white,
              //       decoration: new InputDecoration(
              //         border: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorBorder: InputBorder.none,
              //         disabledBorder: InputBorder.none,
              //         hintText: "Type something....",
              //         hintStyle: TextStyle(fontSize: 20.0, color: Colors.white30),
              //       ),
              //     ),
              //   ),
              // ),
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
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0; i < bgcolorlist.length; i++)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: bgcolorlist[i],
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: _backgroundColor ==
                                                              bgcolorlist[i]
                                                          ? Colors.white
                                                          : Colors.black,
                                                      width: _backgroundColor ==
                                                              bgcolorlist[i]
                                                          ? 3
                                                          : 5)),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _backgroundColor = bgcolorlist[i];
                                              });
                                            },
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.palette_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sketch()));
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
//       bottomNavigationBar: Container(
// margin: EdgeInsets.all(7),
//         child: Row(
//           children: [
//             IconButton(onPressed: (){
//               showModalBottomSheet(
//
//                   context: context,
//                   builder: (context) {
//                     return SingleChildScrollView(
//                       child: Column(
//
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           ListTile(
//                             tileColor: Colors.grey[800],
//                             leading: new Icon(Icons.check_box_outlined, color: Colors.white,),
//                             title: new Text('Checkboxes', style: TextStyle(color: Colors.white),),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             }, icon: Icon(Icons.add_box_outlined, color: Colors.white,),),
//             IconButton(onPressed: (){}, icon: Icon(Icons.text_format, color: Colors.white,),),
//             IconButton(onPressed: (){}, icon: Icon(Icons.palette_outlined, color: Colors.white,),),
//             SizedBox(width: 150),
//             IconButton(onPressed: (){
//               showModalBottomSheet(
//
//                   context: context,
//                   builder: (context) {
//                     return SingleChildScrollView(
//                       child: Column(
//
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           ListTile(
//                             tileColor: Colors.grey[800],
//                             leading: new Icon(Icons.delete_outline, color: Colors.white,),
//                             title: new Text('Delete', style: TextStyle(color: Colors.white),),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           ListTile(
//                             tileColor: Colors.grey[800],
//                             leading: new Icon(Icons.copy, color: Colors.white,),
//                             title: new Text('Make a copy', style: TextStyle(color: Colors.white),),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           ListTile(
//                             tileColor: Colors.grey[800],
//                             leading: new Icon(Icons.share, color: Colors.white,),
//                             title: new Text('Share', style: TextStyle(color: Colors.white),),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           ListTile(
//                             tileColor: Colors.grey[800],
//                             leading: new Icon(Icons.label_outline, color: Colors.white,),
//                             title: new Text('Label', style: TextStyle(color: Colors.white),),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             }, icon: Icon(Icons.more_vert, color: Colors.white,),),
//           ],
//         ),
// decoration: BoxDecoration(
//   color: Colors.black.withOpacity(0.4),
// borderRadius: BorderRadius.circular(10)
// ),
//       ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
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
