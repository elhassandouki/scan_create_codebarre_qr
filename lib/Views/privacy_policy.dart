import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFFF835F),
          Color(0xFFFC663C),
          Color(0xFFFF3F1A),
        ]),
      ),
      child: Center(
        child: Text("Privacy Policy Page"),
      ),
    );
  }
}
