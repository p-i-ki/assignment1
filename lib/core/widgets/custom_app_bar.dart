import 'package:flutter/material.dart';

PreferredSize customAppbar({String text = "App bar"}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
