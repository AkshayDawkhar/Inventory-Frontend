import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class DesktopTrash extends StatefulWidget {
  const DesktopTrash({Key? key}) : super(key: key);

  @override
  State<DesktopTrash> createState() => _DesktopTrashState();
}

class _DesktopTrashState extends State<DesktopTrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('TRASH'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 5)),
          Expanded(flex: 6, child: Text('trash'))
        ],
      ),
    );
  }
}
