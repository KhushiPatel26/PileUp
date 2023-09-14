import 'package:flutter/material.dart';
import 'package:pup/mystuff/task/addtask.dart';
import 'package:pup/mystuff/mystuff.dart';


class taskpg extends StatefulWidget {
  const taskpg({Key? key}) : super(key: key);

  @override
  State<taskpg> createState() => _taskpgState();
}

class _taskpgState extends State<taskpg> {
  // @override
  // void initState() {
  //   super.initState();
  //   _model = createModel(context, () => ProjpgModel());
  //
  //   // On page load action.
  //   SchedulerBinding.instance.addPostFrameCallback((_) async {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0,right: 90),
              child: Text("My Tasks",style: TextStyle(fontSize: 50,color: Colors.black),),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: visible? 200:250),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>addtask()));
                  }, icon:Icon(Icons.add, color: Colors.black),),
                  IconButton(onPressed: (){}, icon:Icon(Icons.menu, color: Colors.black),)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
              Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(
              5, 2, 5, 2),
              child: Theme(
                data: ThemeData(
                  checkboxTheme:
                  CheckboxThemeData(
                    visualDensity:
                    VisualDensity.compact,
                    materialTapTargetSize:
                    MaterialTapTargetSize
                        .shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          25),
                    ),
                  ),
                  unselectedWidgetColor:
                  Color(0xFF81EF39),
                ),
                child: ListTile(
                  title: Text(
                    'Title',

                  ),
                  subtitle: Text(
                    'Subtitle goes here...',

                  ),
                  tileColor: Colors.pinkAccent,
                 // activeColor: Color(0xFF81EF39),
                  //checkColor:FlutterFlowTheme.of(context).info,
                  dense: false,
                  // controlAffinity:
                  // ListTileControlAffinity
                  //     .leading,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(
                          5, 2, 5, 2),
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme:
                          CheckboxThemeData(
                            visualDensity:
                            VisualDensity.compact,
                            materialTapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  25),
                            ),
                          ),
                          unselectedWidgetColor:
                          Color(0xFF81EF39),
                        ),
                        child: ListTile(
                          title: Text(
                            'Title',

                          ),
                          subtitle: Text(
                            'Subtitle goes here...',

                          ),
                          tileColor: Colors.pinkAccent,
                          // activeColor: Color(0xFF81EF39),
                          //checkColor:FlutterFlowTheme.of(context).info,
                          dense: false,
                          // controlAffinity:
                          // ListTileControlAffinity
                          //     .leading,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(
                          5, 2, 5, 2),
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme:
                          CheckboxThemeData(
                            visualDensity:
                            VisualDensity.compact,
                            materialTapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  25),
                            ),
                          ),
                          unselectedWidgetColor:
                          Color(0xFF81EF39),
                        ),
                        child: ListTile(
                          title: Text(
                            'Title',

                          ),
                          subtitle: Text(
                            'Subtitle goes here...',

                          ),
                          tileColor: Colors.pinkAccent,
                          // activeColor: Color(0xFF81EF39),
                          //checkColor:FlutterFlowTheme.of(context).info,
                          dense: false,
                          // controlAffinity:
                          // ListTileControlAffinity
                          //     .leading,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                      ),
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
