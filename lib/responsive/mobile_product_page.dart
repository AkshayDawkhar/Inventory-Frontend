import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';

import '/constants.dart';

class MobileProductPage extends StatefulWidget {
  final String title;

  const MobileProductPage({Key? key, required this.title}) : super(key: key);

  @override
  State<MobileProductPage> createState() => _MobileProductPageState();
}

class _MobileProductPageState extends State<MobileProductPage> {
  late Future building;
  late Future<List> required;
  late Future data;
  late Future Needed;
  late Future Max;
  String _message = '';

  Text blackText(String value) => Text(
        '$value',
        style: TextStyle(color: Colors.black),
      );

  Future<void> deleteProduct(String pid) async {
    final response = await http.delete(
      Uri.parse('${HttpHelper.HOSTNAME}/product/$pid'),
    );
    // final response = HttpHelper().deleteproduct(pid);
    if (response.statusCode == 202) {
      setState(() {
        _message = 'Product deleted successfully.';
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Product deleted successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).go('/product');
                },
              ),
            ],
          );
        },
      );
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('product NOT found'),
            content: Text('Product deleted successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Some ting went wrong'),
            content: Text('Product deleted successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    HttpHelper Http = HttpHelper();
    // TODO: implement initState
    super.initState();
    data = Http.fetchItemName(widget.title);
    building = Http.fetchItem(widget.title);
    required = Http.fetchRequired(widget.title);
    Needed = Http.fetchNeeded(widget.title);
    Max = Http.fetchMax(widget.title);
  }

  int values = 10;
  int max = 10000;
  int recommended = 0;
  int buildingNumber = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    void remove() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: myAppBar('product'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${snapshot.data['dname']}',
                                style: TextStyle(fontSize: width / 30, fontWeight: FontWeight.bold),
                              ),
                              PopupMenuButton(
                                  // add icon, by default "3 dot" icon
                                  // icon: Icon(Icons.book)
                                  itemBuilder: (context) {
                                return [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    value: 2,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.add,
                                        color: Colors.greenAccent,
                                      ),
                                      title: Text('Order'),
                                    ),
                                  ),
                                ];
                              }, onSelected: (value) {
                                if (value == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Sure ?'),
                                          content: Text('move to trash'),
                                          actions: [
                                            TextButton(
                                              autofocus: true,
                                              onPressed: () async {
                                                deleteProduct(widget.title);
                                                remove();

                                                // int status = await HttpHelper().deleteproduct(widget.title);
                                                // showDialog(context: context, builder: (context){
                                                //   return AlertDialog(title: Text('$status'),);
                                                // });
                                              },
                                              child: Text('delete'),
                                              style: TextButton.styleFrom(foregroundColor: Colors.red),
                                            )
                                          ],
                                        );
                                      });
                                  // GoRouter.of(context)
                                  //     .push('/product');

                                  print("My account menu is selected.");
                                } else if (value == 1) {
                                  print("Settings menu is selected.");
                                } else if (value == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialogForOrder(pid: widget.title);
                                      });
                                }
                              }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${snapshot.data['category']}',
                              ),
                              Text(
                                '${snapshot.data['color']}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: width / 1.2,
                height: width / 1.5,
                child: Container(
                  width: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('${HttpHelper.HOSTNAME}/static/${widget.title}.png'),
                      )),
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey[50],
              padding: EdgeInsets.all(26.0),
              child: FutureBuilder(
                  future: building,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      buildingNumber = snapshot.data['building'];
                      recommended = snapshot.data['recommended'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              blackText('InStock:'),
                              blackText('${snapshot.data['instock']}'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              blackText('Building:'),
                              blackText('${snapshot.data['building']}'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              blackText('Needed:'),
                              blackText('${snapshot.data['needed']}'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              blackText('Recommended:'),
                              blackText('${snapshot.data['recommended']}'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              blackText('MAX build:'),
                              FutureBuilder(
                                  future: Max,
                                  builder: (context, snapshot) {
                                    print('----------> ${snapshot.data.toString()}');
                                    if (snapshot.hasData) {
                                      max = int.parse(snapshot.data.toString());
                                      return blackText(
                                        '${snapshot.data.toString()}',
                                      );
                                    } else {
                                      return blackText('-');
                                    }
                                  })
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const Text(
              'Required',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
                future: required,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int length = snapshot.data!.length;
                    if (length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          color: Colors.blueGrey[100],
                          child: const Center(child: Text('No Raw Required')),
                        ),
                      );
                    }
                    return GridView.builder(
                        itemCount: length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          Map a = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                GoRouter.of(context).push('/product/${a['rid']}');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 3, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage('${HttpHelper.HOSTNAME}/static/${a['rid']}.png'), fit: BoxFit.fill)),
                                child: FutureBuilder(
                                    future: HttpHelper().fetchItem1(a['rid']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map b = snapshot.data;
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  '${b['dname']}',
                                                  style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 1.0, // shadow blur
                                                        color: Colors.blueGrey, // shadow color
                                                        offset: Offset(1.0, 2.0), // how much shadow will be shown
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${a['numbers']}',
                                                    style: TextStyle(
                                                        // color: Color.fromARGB(223, 28, 255, 0),
                                                        shadows: [
                                                          Shadow(
                                                            blurRadius: 2.0, // shadow blur
                                                            color: Colors.blueGrey, // shadow color
                                                            offset: Offset(3.0, 3.0), // how much shadow will be shown
                                                          ),
                                                        ],
                                                        fontSize: width / 7,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                            FutureBuilder(
                                                future: HttpHelper().fetchItem(b['pid']),
                                                builder: (context, snapshot) {
                                                  // print('------------->${a['pid']}');
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        '${snapshot.data['instock']}',
                                                        style: TextStyle(
                                                          shadows: [
                                                            Shadow(
                                                              blurRadius: 1.0, // shadow blur
                                                              color: Colors.blueGrey, // shadow color
                                                              offset: Offset(1.0, 2.0), // how much shadow will be shown
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Text('Instock');
                                                  }
                                                })
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
            Divider(),
            const Text(
              'Needed For',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
                future: Needed,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int length = snapshot.data!.length;
                    if (length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          color: Colors.blueGrey[100],
                          child: const Center(child: Text('Not Needed for any Product')),
                        ),
                      );
                    }
                    return GridView.builder(
                        itemCount: length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          Map a = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                GoRouter.of(context).push('/product/${a['pid']}');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 3, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: NetworkImage('${HttpHelper.HOSTNAME}/static/${a['pid']}.png'), fit: BoxFit.fill)),
                                child: FutureBuilder(
                                    future: HttpHelper().fetchItem1(a['pid']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map b = snapshot.data;
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text('${b['dname']}'),
                                                Center(
                                                  child: Text(
                                                    '${a['numbers']}',
                                                    softWrap: false,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color: Colors.green, fontSize: width / 25, fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                            FutureBuilder(
                                                future: HttpHelper().fetchItem(a['pid']),
                                                builder: (context, snapshot) {
                                                  // print('------------->${a['pid']}');
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Text('${snapshot.data['instock']}'),
                                                    );
                                                  } else {
                                                    return Text('Instock');
                                                  }
                                                })
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),

            // GridView.builder(
            //   itemCount: 20,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemBuilder: (BuildContext context, int index){
            //       return Text('data');
            //     })
            // GridView.builder(
            //     itemCount: 20,
            //     gridDelegate:
            //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container(
            //         child: Text('my name $index'),
            //         color: Colors.red,
            //       );
            //     }),
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Inventory Status',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 18.0,
            //         ),
            //       ),
            //       SizedBox(height: 10.0),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text('InStock:'),
            //           Text('10'),
            //         ],
            //       ),
            //       SizedBox(height: 5.0),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text('Building:'),
            //           Text('5'),
            //         ],
            //       ),
            //       SizedBox(height: 5.0),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text('Needed:'),
            //           Text('7'),
            //         ],
            //       ),
            //       SizedBox(height: 5.0),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text('Recommended:'),
            //           Text('12'),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                heroTag: 'f1',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return mySlider(
                          name: 'Build',
                          pid: widget.title,
                          max: max,
                          recommended: recommended,
                        );
                      });
                },
                backgroundColor: Colors.blueGrey,
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                label: Text('Build'),
              )), // button third
          Container(
              margin: EdgeInsets.all(5),
              child: FloatingActionButton.extended(
                heroTag: 'f2',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return mySlider(
                          name: 'Stock',
                          pid: widget.title,
                          max: buildingNumber,
                          recommended: recommended,
                        );
                      });
                },
                // backgroundColor: Colors.,
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                label: Text('Stock'),
              )), //button first
          // button second
          // Add more buttons here
        ],
      ),
    );
  }
}
