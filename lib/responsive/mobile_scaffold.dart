import 'package:flutter/material.dart';
import '../helper.dart';
import '/constants.dart';
import 'package:go_router/go_router.dart';

class MobileScaffold extends StatefulWidget {
  final Widget body;
  const MobileScaffold({Key? key,required this.body}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int _currentIndex = 0;
  late Future<List> items;
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    // Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchItems();
    print('object');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context,0),
      appBar: myAppBar('HOME'),
      body: Center(
          child: FutureBuilder(
              future: items,
              builder: (context,snapshot)  {
                if(snapshot.hasData){
                  return Center(
                      child: GridView.builder(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
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
              })

      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey[700],
        child: Icon(Icons.add),
      ),
    bottomNavigationBar: myBottomNavigationBar(context,0)
    );
  }
}
