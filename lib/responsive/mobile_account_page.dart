import 'package:flutter/material.dart';

import '../constants.dart';

class MobileAccountPage extends StatefulWidget {
  const MobileAccountPage({Key? key}) : super(key: key);

  @override
  State<MobileAccountPage> createState() => _MobileAccountPageState();
}

class _MobileAccountPageState extends State<MobileAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ACCOUNT'),
      drawer: myDrawer(context, 3),
      body: Text('account'),

    ) ;
  }
}
