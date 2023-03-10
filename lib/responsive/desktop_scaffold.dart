import 'package:flutter/material.dart';
import '/constants.dart';
class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: Row(
        children: [
          myDrawer,
          Expanded(
            child: Center(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  3,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    addRepaintBoundaries: true,
                    addAutomaticKeepAlives: true,
                    itemCount: items.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (BuildContext context, int index) {
                      return myContainer(context,false,index);
                    })),
          ),
        ],
      ),
    );
  }
}
