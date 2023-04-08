import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

import '../helper.dart';

class DesktopProductsPage extends StatefulWidget {
  const DesktopProductsPage({Key? key}) : super(key: key);

  @override
  State<DesktopProductsPage> createState() => _DesktopProductsPageState();
}

class _DesktopProductsPageState extends State<DesktopProductsPage> {
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
      appBar: myAppBar('PRODUCTS'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            List a = await HttpHelper().fetchItems();
            // sleep(const Duration(seconds: 3));
          },
          backgroundColor: Colors.blueGrey,
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: Text('NEW'),
        ),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 4)),
          Expanded(flex: 6, child: FutureBuilder(
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
              }))
        ],
      ),
    );
  }
}
