import 'package:flutter/material.dart';
import '/constants.dart';

class DesktopScaffold extends StatefulWidget {
  final Widget body;

  const DesktopScaffold({Key? key, required this.body}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('home'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer),
          Expanded(flex: 6, child: widget.body),
        ],
      ),
    );
  }
}
