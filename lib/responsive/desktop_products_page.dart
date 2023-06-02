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
  String selectedCategory = 'All';
  late Future<List> categories;
  late List categoryItemss;
  TextEditingController editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    // Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchItems();
    // var category =  HttpHelper().fetchCategory();
    // print('${category.then((value) => value[0]['id'])}');
    // print('${category}');
    categories = HttpHelper().fetchCategory();
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
                            child: FutureBuilder(
                                future: categories,
                                builder: (context, snapshot2) {
                                  if (snapshot2.hasData) {
                                    categoryItemss = snapshot2.data!;
                                    print('-------------------->$categoryItemss');
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryItemss.length,
                                        itemBuilder: (context, index) {
                                          String category = categoryItemss[index]['category'].toString();
                                          return InkWell(
                                            onLongPress: () {
                                              editController.text = '$category';
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Edit'),
                                                      content: TextFormField(
                                                        controller: editController,
                                                        decoration: InputDecoration(hintText: 'name'),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: Text('remove'),
                                                          style: TextButton.styleFrom(foregroundColor: Colors.red),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: Text('ok'),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            onTap: () {
                                              selectedCategory = category;
                                              print('$category');
                                              setState(() {
                                                items = HttpHelper().fetchCategoryItems('$category');
                                              });
                                            },
                                            child: Container(
                                                margin: EdgeInsets.all(12),
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.all(Radius.circular(6))),
                                                child: Text('${categoryItemss[index]['category']}')),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Text('categories'),
                                    );
                                  }
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
