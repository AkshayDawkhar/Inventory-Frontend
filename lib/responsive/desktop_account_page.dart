import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

import '../helper.dart';

String mode = 'worker';

class DesktopAccountPage extends StatefulWidget {
  const DesktopAccountPage({Key? key}) : super(key: key);

  @override
  State<DesktopAccountPage> createState() => _DesktopAccountPageState();
}

class _DesktopAccountPageState extends State<DesktopAccountPage> {
  late Future<List> items;

  List<DropdownMenuItem> acc = const [
    DropdownMenuItem(
      value: 'worker',
      child: Text('worker'),
    ),
    DropdownMenuItem(value: 'admin', child: Text('admin')),
  ];

  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchAccount();
    print('object');
  }

  // Future<int> deleteTrash(String pid) async {
  //   int a = await HttpHelper().deleteTrash(pid);
  //   setState(() {
  //     print('setting state');
  //     items = HttpHelper().fetchTrashProduct();
  //   });
  //   return a;
  // }

  // Future<int> restoreTrash(String pid) async {
  //   int a = await HttpHelper().restoreTrash(pid);
  //   setState(() {
  //     print('setting state');
  //     items = HttpHelper().fetchTrashProduct();
  //   });
  //   return a;
  // }

  // Future<list>
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppBar(mode.toUpperCase()),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              onPressed: () {
                items = HttpHelper().fetchAccount();
                mode = mode == 'admin' ? 'worker' : 'admin';
                if (mode == 'admin') {
                  print('getting admins');
                  items = HttpHelper().fetchAdmin();
                } else {
                  items = HttpHelper().fetchAccount();
                }
                setState(() {});
              },
              backgroundColor: Colors.blueGrey,
              label: Text(mode),
              icon: Icon(Icons.repeat),
            ),
          ), // button third
          Container(
              margin: EdgeInsets.all(5),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return UserInfoDialog(mode: mode);
                      });
                  //action code for button 1
                },
                child: Icon(Icons.add),
              )), //button first
          // button second
          // Add more buttons here
        ],
      ),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 3)),
          Expanded(
              flex: 6,
              child: FutureBuilder(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: width < 1500
                                    ? width < 1200
                                        ? 2
                                        : 3
                                    : 4,
                                childAspectRatio: 19 / 4.8,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                              ),
                              addRepaintBoundaries: true,
                              addAutomaticKeepAlives: true,
                              itemCount: snapshot.data!.length,
                              padding: const EdgeInsets.all(12),
                              itemBuilder: (BuildContext context, int index) {
                                Map a = snapshot.data!.elementAt(index);
                                final name = a['fname'];
                                final lname = a['lname'];
                                final mail = a['mail'];
                                final username = a['username'];
                                // final pid = a['pid'];
                                // final ttl = a['ttl(dname)'];
                                // final name = a['dname'];
                                // final days = (ttl / 86400).toInt();

                                // return cen(snapshot.data!.elementAt(index)['pid'].toString());
                                // return myTrashContainer(context,a['dname'],a['pid'],a['ttl(dname)']);
                                // return myContainer(context, false, index,snapshot.data!.elementAt(index)['pid'].toString(),snapshot.data!.elementAt(index)['dname'].toString());
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Expanded(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.blueGrey,
                                    //         borderRadius:
                                    //             BorderRadius.circular(12),
                                    //         image: const DecorationImage(
                                    //           image: NetworkImage(
                                    //               'https://static.wixstatic.com/media/256076_689c3b907b5441248756c0b36f553cc4~mv2.jpeg/v1/fill/w_1276,h_727,al_c,q_85,usm_1.20_1.00_0.01,enc_auto/8100.jpeg'),
                                    //           fit: BoxFit.cover,
                                    //         )),
                                    //   ),
                                    // ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blueGrey,width: 2),
                                          color: Colors.blueGrey[50],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      // color: Colors.blueGrey[50],
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '$name $lname',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      // "${Numeral(instock).format()} InStock  ",
                                                      "username: ",
                                                      style: TextStyle(
                                                          // color: Colors.blueGrey
                                                          ),
                                                    ),
                                                    Text(
                                                      // "${Numeral(instock).format()} InStock  ",
                                                      "$username",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text("mail: "),
                                                    Text(
                                                      // "${Numeral(instock).format()} InStock  ",
                                                      "$mail",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // InkWell(
                                          //   child: Icon(
                                          //     Icons.repeat,
                                          //     color: Colors.green,
                                          //   ),
                                          //   onTap: () {
                                          //     showDialog(
                                          //         context: context,
                                          //         builder: (context) {
                                          //           return AlertDialog(
                                          //             content: Text(
                                          //                 '$name will be Restore'),
                                          //             title: Text('Restore'),
                                          //             actions: [
                                          //               TextButton(
                                          //                   onPressed: () {
                                          //                     remove(context);
                                          //                   },
                                          //                   child:
                                          //                       Text('cancel')),
                                          //               TextButton(
                                          //                 onPressed: () {
                                          //                   restoreTrash(pid);
                                          //                   remove(context);
                                          //                 },
                                          //                 child: Text('ok'),
                                          //                 style: TextButton
                                          //                     .styleFrom(
                                          //                         foregroundColor:
                                          //                             Colors
                                          //                                 .green),
                                          //               )
                                          //             ],
                                          //           );
                                          //         });
                                          //   },
                                          // ),
                                          InkWell(
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                            onTap: () {
                                              // showDialog(
                                              //     context: context,
                                              //     builder: (context) {
                                              //       return AlertDialog(
                                              //         content: Text(
                                              //             '$name will be deleted permanently'),
                                              //         title: Text('Delete'),
                                              //         actions: [
                                              //           TextButton(
                                              //             onPressed: () {
                                              //               remove(context);
                                              //             },
                                              //             child:
                                              //                 Text('cancel'),
                                              //             // style: TextButton.styleFrom(
                                              //             //     foregroundColor:
                                              //             //     Colors
                                              //             //         .red),
                                              //           ),
                                              //           TextButton(
                                              //             onPressed: () async{
                                              //               // deleteTrash(pid);
                                              //
                                              //               remove(context);
                                              //               await deleteAdmin(username);
                                              //               setState(() {
                                              //
                                              //               });
                                              //               // int a = await HttpHelper().deleteTrash(pid);
                                              //               // setState(() {
                                              //               //
                                              //               // });
                                              //               // if (a == 200) {
                                              //               //   return showDialog(
                                              //               //       context: context,
                                              //               //       builder: (context) {
                                              //               //         return AlertDialog(
                                              //               //           title: Text('Deletes successfully'),
                                              //               //         );
                                              //               //       });
                                              //               // }
                                              //             },
                                              //             child:
                                              //                 Text('delete'),
                                              //             style: TextButton
                                              //                 .styleFrom(
                                              //                     foregroundColor:
                                              //                         Colors
                                              //                             .red),
                                              //           )
                                              //         ],
                                              //       );
                                              //     });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red[400],
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          '$name will be deleted permanently'),
                                                      title: Text('Delete'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            remove(context);
                                                          },
                                                          child: Text('cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            // deleteTrash(pid);

                                                            remove(context);
                                                            await deleteUser(
                                                                mode, username);
                                                            setState(() {});
                                                          },
                                                          child: Text('delete'),
                                                          style: TextButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .red),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }));
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }

  deleteUser(mode, username) async {
    print('deleting------------------------');
    int a = await HttpHelper().deleteAccount(mode, username);
    if (a == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return deletedSuccessfully;
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return somethingWentWrong;
          });
    }

    setState(() {
      if (mode == 'admin') {
        items = HttpHelper().fetchAdmin();
      } else {
        items = HttpHelper().fetchAccount();
      }
      print('setting state');
      // items = ;
    });
    return a;
  }
}
