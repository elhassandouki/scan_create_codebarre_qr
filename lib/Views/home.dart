import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan_create_codebarre_qr/Views/create_qrcode.dart';
import 'package:scan_create_codebarre_qr/Views/scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int index = 0;
  final screen = [CreatePage(), ScanScreen()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.green[700],
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: Color(0xFFf1f5fb),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: index,
            animationDuration: Duration(seconds: 3),
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.qr_code),
                label: 'label',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_rounded),
                label: "label2",
              ),
            ],
          ),
        ),
      );
}
