import 'package:flutter/material.dart';
import 'package:inventory/responsive/desktop_home_page.dart';
import '../helper.dart';
import '/constants.dart';
import 'mobile_home_page.dart';

class DesktopScaffold extends StatefulWidget {

  DesktopScaffold({Key? key}) : super(key: key);


  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  late Future<List> items;
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchItems();
    print('object');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('home'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context)),
          Expanded(flex: 6, child: Center(
              child: FutureBuilder(
                  future: items,
                  builder: (context,snapshot)  {
                if(snapshot.hasData){
                  return Center(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 4 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                          ),
                          addRepaintBoundaries: true,
                          addAutomaticKeepAlives: true,
                          itemCount: snapshot.data!.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (BuildContext context, int index) {
                            // return cen(snapshot.data!.elementAt(index)['pid'].toString());
                            return myContainer(context, false, index,snapshot.data!.elementAt(index)['pid'].toString(),snapshot.data!.elementAt(index)['dname'].toString());
                          })
                  )
                  ;
                }
                else{
                  return const CircularProgressIndicator();

                }
              })

          ) ),
        ],
      ),
    );
  }
}
