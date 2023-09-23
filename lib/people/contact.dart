

import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class contact extends StatefulWidget {
  const contact({Key? key}) : super(key: key);

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  void _incrementCounter() {}
  List<Contact> contacts = [];

  Future<void> fetchContacts() async {
    // Request permission to access contacts
    PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus == PermissionStatus.granted) {
      List<Contact> _contacts =
      (await ContactsService.getContacts(withThumbnails: false)).toList();

      setState(() {
         contacts = _contacts;
      });
    } else {
      print('Permission denied');
    }
  }

  List<String> list = [
    'angel',
    'bubbles',
    'shimmer',
    'angelic',
    'bubbly',
    'glimmer',
    'baby',
    'pink',
    'little',
    'butterfly',
    'sparkly',
    'doll',
    'sweet',
    'sparkles',
    'dolly',
    'sweetie',
    'sprinkles',
    'lolly',
    'princess',
    'fairy',
    'honey',
    'snowflake',
    'pretty',
    'sugar',
    'cherub',
    'lovely',
    'blossom',
    'Ecophobia',
    'Hippophobia',
    'Scolionophobia',
    'Ergophobia',
    'Musophobia',
    'Zemmiphobia',
    'Geliophobia',
    'Tachophobia',
    'Hadephobia',
    'Radiophobia',
    'Turbo Slayer',
    'Cryptic Hatter',
    'Crash TV',
    'Blue Defender',
    'Toxic Headshot',
    'Iron Merc',
    'Steel Titan',
    'Stealthed Defender',
    'Blaze Assault',
    'Venom Fate',
    'Dark Carnage',
    'Fatal Destiny',
    'Ultimate Beast',
    'Masked Titan',
    'Frozen Gunner',
    'Bandalls',
    'Wattlexp',
    'Sweetiele',
    'HyperYauFarer',
    'Editussion',
    'Experthead',
    'Flamesbria',
    'HeroAnhart',
    'Liveltekah',
    'Linguss',
    'Interestec',
    'FuzzySpuffy',
    'Monsterup',
    'MilkA1Baby',
    'LovesBoost',
    'Edgymnerch',
    'Ortspoon',
    'Oranolio',
    'OneMama',
    'Dravenfact',
    'Reallychel',
    'Reakefit',
    'Popularkiya',
    'Breacche',
    'Blikimore',
    'StoneWellForever',
    'Simmson',
    'BrightHulk',
    'Bootecia',
    'Spuffyffet',
    'Rozalthiric',
    'Bookman'
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AlphabetScrollView(
              list: contacts
                  .map((contact) => AlphaModel(contact.displayName ?? 'Unknown'))
                  .toList(),
              // isAlphabetsFiltered: false,
              alignment: LetterAlignment.right,
              itemExtent: 50,
              unselectedTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black
              ),
              selectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              ),
              overlayWidget: (value) => Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$value'.toUpperCase(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              itemBuilder: (_, k, id) {
                Contact contact = contacts[k];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListTile(
                    title: Text('$id'),
                    subtitle: Text('Secondary text'),
                    leading: Icon(Icons.person),
                    trailing: Radio<bool>(
                      value: false,
                      groupValue: selectedIndex != k,
                      onChanged: (value) {
                        setState(() {
                          selectedIndex = k;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
