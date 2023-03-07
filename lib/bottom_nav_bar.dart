import 'package:flutter/material.dart';

Widget BottomNavbBar(double w) => BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: '',
        ),
        w < 600
            ? const BottomNavigationBarItem(
                icon: Icon(Icons.build), label: 'builds')
            : const BottomNavigationBarItem(
                icon: Icon(Icons.public), label: 'public'),
        const BottomNavigationBarItem(icon: Icon(Icons.public), label: 'public')
      ],
    );
