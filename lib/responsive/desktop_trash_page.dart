import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/helper.dart';
import 'package:go_router/go_router.dart';
class DesktopTrash extends StatefulWidget {
  const DesktopTrash({Key? key}) : super(key: key);

  @override
  State<DesktopTrash> createState() => _DesktopTrashState();
}

class _DesktopTrashState extends State<DesktopTrash> {
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar('PRODUCTS'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          GoRouter.of(context).go('/product/new');
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
          Expanded(flex: 1, child: myDrawer(context, 5)),
          Expanded(flex: 6, child: FutureBuilder(
              future: items,
              builder: (context,snapshot)  {
                if(snapshot.hasData){
                  return Center(
                      child:GridView.builder(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width < 1200 ? width < 900 ?2:3:4,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                          ),
                          addRepaintBoundaries: true,
                          addAutomaticKeepAlives: true,
                          itemCount: snapshot.data!.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (BuildContext context, int index) {
                            Map a = snapshot.data!.elementAt(index);
                            // return cen(snapshot.data!.elementAt(index)['pid'].toString());
                            return myContainer1(context,a['dname'],a['pid']);
                            // return myContainer(context, false, index,snapshot.data!.elementAt(index)['pid'].toString(),snapshot.data!.elementAt(index)['dname'].toString());
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
