import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class MobileTrash extends StatefulWidget {
  const MobileTrash({Key? key}) : super(key: key);

  @override
  State<MobileTrash> createState() => _MobileTrashState();
}

class _MobileTrashState extends State<MobileTrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('TRASH'),
      drawer: myDrawer(context, 5),
      body: Text('trash'),

    ) ;
  }
}
