import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
String mode = 'worker';

class DesktopAccountPage extends StatefulWidget {
  const DesktopAccountPage({Key? key}) : super(key: key);

  @override
  State<DesktopAccountPage> createState() => _DesktopAccountPageState();
}

class _DesktopAccountPageState extends State<DesktopAccountPage> {
  List<DropdownMenuItem> acc = const [
    DropdownMenuItem(
      value: 'worker',
      child: Text('worker'),
    ),
    DropdownMenuItem(value: 'admin', child: Text('admin')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(mode.toUpperCase()),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 3)),
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DropdownButton(
                    items: acc,
                    onChanged: (item) {
                      mode = item;
                      setState(() {
                      });
                    },
                    value: mode,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
