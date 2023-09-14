// //import '/flutter_flow/flutter_flow_icon_button.dart';
// //import '/flutter_flow/flutter_flow_theme.dart';
// //import '/flutter_flow/flutter_flow_util.dart';
// import 'dart:ffi';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// //import 'progviewmodel.dart';
// //export 'progviewmodel.dart';
//
// class projviewWidget extends StatefulWidget {
//   const projviewWidget({Key? key}) : super(key: key);
//
//   @override
//   _projviewWidgetState createState() => _projviewWidgetState();
// }
//
// class _projviewWidgetState extends State<projviewWidget> {
//   //   with TickerProviderStateMixin {
//      @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
// //late projviewModel _model;
//   //
//    final scaffoldKey = GlobalKey<ScaffoldState>();
//   //
//    @override
//    void initState() {
//   //   super.initState();
//   //   _model = createModel(context, () => projviewModel());
//   //
//     TabController tabBarController = TabController(
//       length: 3,
//       initialIndex: 0,
//       vsync: nullptr,
//     );
//     TextEditingController textController = TextEditingController();
//   }
//
//   // @override
//   // void dispose() {
//   //   _model.dispose();
//   //
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.white,//FlutterFlowTheme.of(context).primaryBackground,
//         body: NestedScrollView(
//           floatHeaderSlivers: true,
//           headerSliverBuilder: (context, _) => [
//             SliverAppBar(
//               expandedHeight: 200,
//               pinned: false,
//               floating: false,
//               backgroundColor: Colors.white70,//FlutterFlowTheme.of(context).secondaryBackground,
//               automaticallyImplyLeading: false,
//               title: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Stack(
//                           children: [
//                             Opacity(
//                               opacity: 0.1,
//                               child: Container(
//                                 width: 142,
//                                 height: 34,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey,
//                                   //FlutterFlowTheme.of(context).primaryText,
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(
//                                     color: Colors.black26,//FlutterFlowTheme.of(context)
//                                        // .primaryText,
//                                     width: 2,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                               EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
//                               child: RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: 'Team:',
//                                       style: /*FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override*/
//                                       TextStyle
//                                         (
//                                         fontFamily: 'Linle',
//                                         color: Colors.grey,//FlutterFlowTheme.of(context)
//                                            // .secondaryText,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: ' Proj Desing',
//                                       style: TextStyle(
//                                         color: Colors.black,//FlutterFlowTheme.of(context)
//                                             //.primaryText,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     )
//                                   ],
//
//                                   //FlutterFlowTheme.of(context).bodyMedium,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Flexible(
//                           child: Opacity(
//                             opacity: 0.4,
//                             child: Align(
//                               alignment: AlignmentDirectional(-1, 0),
//                               child: IconButton(
//                                 icon: Icon(
//                                     Icons.mode_edit_outline_sharp,
//                                     color: Colors.grey,
//                                     //FlutterFlowTheme.of(context).primaryText,
//                                     size: 24,
//                                   ),
//                                 onPressed: () {
//                                   print('IconButton pressed ...');
//                                 },
//                               ),
//
//                               ),
//                             ),
//
//                         ),
//                         Opacity(
//                           opacity: 0.2,
//                           child: Align(
//                             alignment: AlignmentDirectional(1, 0),
//                             child: IconButton(
//                               // borderColor: Colors.black,
//                               // borderRadius: 20,
//                               // borderWidth: 1,
//                               // buttonSize: 30,
//                               // fillColor: Color(0x8157636C),
//                               icon: Icon(
//                                 Icons.close_rounded,
//                                 color: Colors.grey,//FlutterFlowTheme.of(context).primaryText,
//                                 size: 15,
//                               ),
//                               onPressed: () async {
//                                 //context.safePop();
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [],
//               centerTitle: false,
//               elevation: 2,
//             )
//           ],
//           body: Builder(
//             builder: (context) {
//               return SafeArea(
//                 top: false,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Stack(
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Container(
//                             height: 200,
//                             decoration: BoxDecoration(),
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment(0, 0),
//                                       child: TabBar(
//                                         labelColor: Colors.black54,
//                                         unselectedLabelColor: Colors.black26,
//                                         labelPadding:
//                                         EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 25, 0),
//                                         // labelStyle: FlutterFlowTheme.of(context)
//                                         //     .titleMedium
//                                         //     .override(
//                                         //   fontFamily: 'Readex Pro',
//                                         //   fontSize: 12,
//                                         // ),
//                                         unselectedLabelStyle: TextStyle(),
//                                         indicatorColor: Colors.black,
//                                        // FlutterFlowTheme.of(context)
//                                         //    .primaryText,
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             2, 2, 2, 2),
//                                         tabs: [
//                                           Tab(
//                                             text: 'Thread Tasks',
//                                           ),
//                                           Tab(
//                                             text: 'Activities',
//                                           ),
//                                           Tab(
//                                             text: 'Files',
//                                           ),
//                                         ],
//                                         controller: _model.tabBarController,
//                                         onTap: (value) => setState(() {}),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: TabBarView(
//                                         controller: _model.tabBarController,
//                                         children: [
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(8, 0, 8, 0),
//                                                 child: TextFormField(
//                                                   controller:
//                                                   _model.textController,
//                                                   autofocus: true,
//                                                   obscureText: false,
//                                                   decoration: InputDecoration(
//                                                     labelText:
//                                                     'Search for task, number or performer',
//
//                                                     enabledBorder:
//                                                     UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                         Colors.black26,
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                     ),
//                                                     focusedBorder:
//                                                     UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                        Colors.black87,
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                     ),
//                                                     errorBorder:
//                                                     UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                        Colors.redAccent,
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                     ),
//                                                     focusedErrorBorder:
//                                                     UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                         Colors.red,
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                     ),
//                                                     prefixIcon: Icon(
//                                                       Icons.search,
//                                                       size: 15,
//                                                     ),
//                                                   ),
//                                                   validator: _model
//                                                       .textControllerValidator
//                                                       .asValidator(context),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Tab View 2',
//                                             style: TextStyle(
//                                               //fontFamily: 'Readex Pro',
//                                               fontSize: 32,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Tab View 3',
//                                             style: TextStyle(
//                                               //fontFamily: 'Readex Pro',
//                                               fontSize: 32,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Align(
//                                   alignment: AlignmentDirectional(-0.47, -0.87),
//                                   child: Container(
//                                     width: 40,
//                                     height: 25,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black38,//FlutterFlowTheme.of(context).alternate,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0, 0),
//                                       child: Text(
//                                         '12',
//                                         style: TextStyle(
//                                           //fontFamily: 'Readex Pro',
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: AlignmentDirectional(0.89, -0.87),
//                                   child: Container(
//                                     width: 40,
//                                     height: 25,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black54,//FlutterFlowTheme.of(context).alternate,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0, 0),
//                                       child: Text(
//                                         '8',
//                                         style: TextStyle(
//                                           //fontFamily: 'Readex Pro',
//                                           color: Colors.black26,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: AlignmentDirectional(0.22, -0.87),
//                                   child: Container(
//                                     width: 40,
//                                     height: 25,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black26,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0, 0),
//                                       child: Text(
//                                         '20',
//                                         style: TextStyle(
//                                           //fontFamily: 'Readex Pro',
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
