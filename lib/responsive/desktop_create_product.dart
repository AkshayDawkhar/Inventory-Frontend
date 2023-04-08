import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';

class DesktopCreateProductPage extends StatefulWidget {
  const DesktopCreateProductPage({super.key, required this.title});

  final String title;

  @override
  State<DesktopCreateProductPage> createState() => _DesktopCreateProductPageState();
}

class _DesktopCreateProductPageState extends State<DesktopCreateProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.title),);
  }
}
