import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
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
        child: Text("Contacts Page"),
      ),
    );
  }
}
