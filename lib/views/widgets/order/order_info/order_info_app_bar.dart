import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderInfoAppBar extends AppBar {
  OrderInfoAppBar({
    Icon leadingIcon = const Icon(Icons.close, color: Colors.black),
    String title = '',
    TabBar bottom
  }) : super (
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text('$title', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)),
    elevation: 0.0,
    bottom: bottom
  );
}