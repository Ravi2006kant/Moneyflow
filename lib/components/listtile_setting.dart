import 'package:flutter/material.dart';

class ListtileSetting extends StatelessWidget {
  ListtileSetting({
    super.key,
    required this.ico,
    required this.txt,
    required this.ontap,
  });
  Function() ontap;
  IconData ico;
  String txt;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(ico),
      title: Text(txt),
      trailing: IconButton(
        onPressed: ontap,
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
