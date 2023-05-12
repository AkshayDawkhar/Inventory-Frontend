import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory/routes.dart';
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
    // Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchItems();
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar('PRODUCTS'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: myDrawer(context, 4)),
          Expanded(

              flex: 6,
              child: FutureBuilder(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 1000,
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryItems.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(12),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey, borderRadius: BorderRadius.all(Radius.circular(6))),
                                      child: Text('${categoryItems[index]}'));
                                }),
                          ),
                          Container(padding: EdgeInsets.all(15),child: Text('Power Amplifiers',style: TextStyle(fontSize: 40),)),
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: width < 1200
                                    ? width < 900
                                        ? 2
                                        : 3
                                    : 4,
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                              ),
                              addRepaintBoundaries: true,
                              addAutomaticKeepAlives: true,
                              itemCount: snapshot.data!.length,
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                Map a = snapshot.data!.elementAt(index);
                                // return cen(snapshot.data!.elementAt(index)['pid'].toString());
                                return myContainer1(context, a['dname'], a['pid']);
                                // return myContainer(context, false, index,snapshot.data!.elementAt(index)['pid'].toString(),snapshot.data!.elementAt(index)['dname'].toString());
                              }),
                        ],
                      ));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }))
        ],
      ),
    );
  }
}
