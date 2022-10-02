import 'package:flutter/material.dart';
import 'package:scan_create_codebarre_qr/Views/create_qrcode.dart';
import 'package:scan_create_codebarre_qr/Views/create_barrecode.dart';
import 'package:scan_create_codebarre_qr/Views/privacy_policy.dart';
import 'package:scan_create_codebarre_qr/Views/scan.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan_create_codebarre_qr/Views/contacts.dart';
import 'package:scan_create_codebarre_qr/Views/drawer_header.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.scan;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.scan) {
      container = ScanScreen();
    } else if (currentPage == DrawerSections.qrcode) {
      container = CreatePage();
    } else if (currentPage == DrawerSections.barrecode) {
      container = CreateBarreCodePage();
    } else if (currentPage == DrawerSections.contants) {
      container = ContactsPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = PrivacyPolicyPage();
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFFFF835F),
                Color(0xFFFC663C),
                Color(0xFFFF3F1A),
              ],
            ),
          ),
        ),
        title: Text(""),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Scanner", Icons.qr_code_scanner,
              currentPage == DrawerSections.scan ? true : false),
          menuItem(2, "Create QrCode", FontAwesomeIcons.qrcode,
              currentPage == DrawerSections.qrcode ? true : false),
          menuItem(3, "Create BarreCode", FontAwesomeIcons.barcode,
              currentPage == DrawerSections.barrecode ? true : false),
          Divider(),
          menuItem(4, "Contacts", FontAwesomeIcons.paperPlane,
              currentPage == DrawerSections.contants ? true : false),
          menuItem(5, "Privacy Policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Container(
      child: Material(
        color: selected ? Colors.grey[300] : Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (id == 1) {
                currentPage = DrawerSections.scan;
              } else if (id == 2) {
                currentPage = DrawerSections.qrcode;
              } else if (id == 3) {
                currentPage = DrawerSections.barrecode;
              } else if (id == 4) {
                currentPage = DrawerSections.contants;
              } else if (id == 5) {
                currentPage = DrawerSections.privacy_policy;
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  scan,
  qrcode,
  barrecode,
  privacy_policy,
  contants,
}
