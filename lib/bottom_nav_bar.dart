import 'package:flutter/material.dart';

Widget BottomNavbBar = BottomNavigationBar(
  items: const [
     BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: '',
    ),  BottomNavigationBarItem(
        icon: Icon(Icons.build), label: 'builds')
     ,BottomNavigationBarItem(icon: Icon(Icons.public), label: 'public')
  ],
);
