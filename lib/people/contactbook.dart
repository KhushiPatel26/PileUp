import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class contactBook extends StatefulWidget {
  const contactBook({Key? key}) : super(key: key);
  @override
  State<contactBook> createState() => _contactBookState();
}

class _contactBookState extends State<contactBook> {
  int? _selectedIndex;
  bool all=true;
  bool per=false;
  bool off=false;
  final List<String> _choiceChipsList = [
    "All",
    "Personal",
    "Office",
  ];
  final List<String> _PersonalList = [
   "Pers1",
    "Pers2",
    "Pers3",
    "Pers4",
  ];
  final List<String> _OfficeList = [
    "Off1",
    "Off2",
    "Off3",
    "Off4",
  ];
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
      Padding(
      padding: const EdgeInsets.only(top: 58.0, right: 10, left: 10),

      /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
      /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
      child: AnimSearchBar(
        width: 400,
        color: Colors.white70,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        }, onSubmitted: (String ) {  },
      ),

    ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    label: Text('ALL'),
                    selected: all,
                    selectedColor: all?Colors.black:Colors.black12,
                    backgroundColor: Colors.white70,
                    onSelected:(bool value) { setState(() {
                      all=true;
                      per=false;
                      off=false;
                    });}
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                      label: Text('PERSONAL'),
                      selected: per,
                      selectedColor: per?Colors.black:Colors.black12,
                      backgroundColor: Colors.white70,
                      onSelected:(bool value) { setState(() {
                        all=false;
                        per=true;
                        off=false;
                      });}
                  ),
                ),
                if(per)
                  Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Wrap(
                    spacing: 1,
                    direction: Axis.horizontal,
                    children: choiceChips(_PersonalList),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                      label: Text('OFFICE'),
                      selected: off,
                      selectedColor: per?Colors.black:Colors.black12,
                      backgroundColor: Colors.white70,
                      onSelected:(bool value) { setState(() {
                        all=false;
                        per=false;
                        off=true;
                      });}
                  ),
                ),
                if(off)
                  Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Wrap(
                    spacing: 1,
                    direction: Axis.horizontal,
                    children: choiceChips(_OfficeList),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> choiceChips(_choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(_choiceChipsList[i]),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.white70,
          selected: _selectedIndex == i,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}


