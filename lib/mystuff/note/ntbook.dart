import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pup/mystuff/note/notepgs.dart';

class ntbook extends StatefulWidget {
  const ntbook({Key? key}) : super(key: key);

  @override
  State<ntbook> createState() => _ntbookState();
}

class _ntbookState extends State<ntbook> {
  TextEditingController nbnameController = TextEditingController();
  Color nbcolor=Colors.black.withOpacity(0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          "Make a NoteBook",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            nbnameController=nbnameController;
          });
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    height: 250,
                    width: 200,
                    color: Colors.grey.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Pick a color"),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: Color(0xff443a49),
                                        paletteType: PaletteType.hueWheel,
                                        onColorChanged: (Color value) {
                                          setState(() {
                                            nbcolor=value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: nbcolor,//Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 30, right: 30, bottom: 140),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  nbnameController.text==""?"NoteBook Name":nbnameController.text,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Tap to change colour of NoteBook",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 16),
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: TextFormField(
                        controller: nbnameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'NoteBook Name',
                          labelStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF1F4F8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F4F8),
                        ),
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.text),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 16),
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: TextFormField(
                        controller: nbnameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF1F4F8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F4F8),
                        ),
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.text),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 16),
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: TextFormField(
                        controller: nbnameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Labels',
                          labelStyle: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF1F4F8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5963),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F4F8),
                        ),
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.text),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              'NoteBook Added',
                              style: TextStyle(color: Colors.white),
                            )));
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => notepgs()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 3.0, right: 3.0),
                        child: Text(
                          "Make New NoteBook",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        //primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0.0,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
