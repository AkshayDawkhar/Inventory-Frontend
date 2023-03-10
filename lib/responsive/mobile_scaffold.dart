import 'package:flutter/material.dart';
import '/constants.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer,
      appBar: myAppBar,
      body: Center(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (BuildContext context, int index) {
                return myContainer(context,true,index);
              })
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey[700],
        child: Icon(Icons.add),
      ),
    bottomNavigationBar: myBottomNavBar(context),
    );
  }
}
