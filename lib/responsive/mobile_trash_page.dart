import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

import '../helper.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
class MobileTrash extends StatefulWidget {
  const MobileTrash({Key? key}) : super(key: key);

  @override
  State<MobileTrash> createState() => _MobileTrashState();
}

class _MobileTrashState extends State<MobileTrash> {
  late Future<List> items;

  Future<int> deleteTrash(String pid) async {
    int a = await HttpHelper().deleteTrash(pid);
    setState(() {
      print('setting state');
      items = HttpHelper().fetchTrashProduct();
    });
    return a;
  }
  Future<int> restoreTrash(String pid) async {
    int a = await HttpHelper().restoreTrash(pid);
    setState(() {
      print('setting state');
      items = HttpHelper().fetchTrashProduct();
    });
    return a;
  }
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    // Future.delayed(Duration(seconds: 10));
    items = HttpHelper().fetchTrashProduct();
    print('object');
  }
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.blueGrey[300],
      height: 150,
      backgroundColor: Colors.blueGrey,
      springAnimationDurationInMilliseconds: 500,
      onRefresh: ()async{
        print('refrash');
        await Future.delayed(Duration(seconds: 1));
        GoRouter.of(context).refresh();
      },
      child: Scaffold(
        appBar: myAppBar('TRASH'),
        drawer: myDrawer(context, 5),
        body: FutureBuilder(
            future: items,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          final pid = a['pid'];
                          final ttl = a['ttl(dname)'];
                          final name = a['dname'];
                          final days = (ttl / 86400).toInt();
                          // return cen(snapshot.data!.elementAt(index)['pid'].toString());
                          // return myTrashContainer(context,a['dname'],a['pid'],a['ttl(dname)']);
                          // return myContainer(context, false, index,snapshot.data!.elementAt(index)['pid'].toString(),snapshot.data!.elementAt(index)['dname'].toString());
                          return Container(
                            // padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        image:  DecorationImage(
                                          image: NetworkImage(
                                              '${HttpHelper.HOSTNAME}/static/$pid.png'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0),
                                          Text(
                                            name,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            // "${Numeral(instock).format()} InStock  ",
                                            "$days days ",
                                            style: TextStyle(
                                                color: days > 10
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      child: Icon(Icons.repeat,color: Colors.green,),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    '$name will be Restore'),
                                                title: Text('Restore'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        remove(context);
                                                      },
                                                      child:
                                                      Text('cancel')),
                                                  TextButton(
                                                    onPressed: () {
                                                      restoreTrash(pid);
                                                      remove(context);
                                                    },
                                                    child: Text('ok'),
                                                    style: TextButton
                                                        .styleFrom(
                                                        foregroundColor:
                                                        Colors
                                                            .green),
                                                  )
                                                ],
                                              );
                                            });
                                      },
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
                                                    // style: TextButton.styleFrom(
                                                    //     foregroundColor:
                                                    //     Colors
                                                    //         .red),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteTrash(pid);
                                                      remove(context);

                                                      // int a = await HttpHelper().deleteTrash(pid);
                                                      // setState(() {
                                                      //
                                                      // });
                                                      // if (a == 200) {
                                                      //   return showDialog(
                                                      //       context: context,
                                                      //       builder: (context) {
                                                      //         return AlertDialog(
                                                      //           title: Text('Deletes successfully'),
                                                      //         );
                                                      //       });
                                                      // }
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
                              ],
                            ),
                          );
                        }));
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            })),
    );
  }
}
