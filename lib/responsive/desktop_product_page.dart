import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';
import 'package:go_router/go_router.dart';

class DesktopProductPage2 extends StatefulWidget {
  const DesktopProductPage2({Key? key}) : super(key: key);

  @override
  State<DesktopProductPage2> createState() => _DesktopProductPage2State();
}

class _DesktopProductPage2State extends State<DesktopProductPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text('name'),
    ));
  }
}

class DesktopProductPage extends StatefulWidget {
  const DesktopProductPage({super.key, required this.title});

  final String title;

  @override
  State<DesktopProductPage> createState() => _DesktopProductPageState();
}

class _DesktopProductPageState extends State<DesktopProductPage> {
  late Future building;
  late Future<List> required;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    building = HttpHelper().fetchItem(widget.title);
    required = HttpHelper().fetchRequired(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fontsize1 = width * 0.0353;
    double fontsize2 = width * 0.01567;
    return Scaffold(
        appBar: myAppBar('title'),
        body: Row(
          children: [
            Expanded(flex: 1, child: myDrawer(context, 9)),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            'https://static.wixstatic.com/media/256076_689c3b907b5441248756c0b36f553cc4~mv2.jpeg/v1/fill/w_1276,h_727,al_c,q_85,usm_1.20_1.00_0.01,enc_auto/8100.jpeg'))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                                future: building,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'PA Amplifier 250 ',
                                              style: TextStyle(
                                                fontSize: fontsize1,
                                                fontWeight: FontWeight.bold,
                                                wordSpacing: 7,
                                              ),
                                            ),
                                            Text(
                                              'category ',
                                              style: TextStyle(
                                                fontSize: fontsize2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Text(
                                          'InStock  ',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          'Building  ',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          'needed',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          'Recommended  ',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'PA Amplifier 250 ',
                                              style: TextStyle(
                                                fontSize: fontsize1,
                                                fontWeight: FontWeight.bold,
                                                wordSpacing: 7,
                                              ),
                                            ),
                                            Text(
                                              'category ',
                                              style: TextStyle(
                                                fontSize: fontsize2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: fontsize2,
                                            wordSpacing: 10,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
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
                                  child: const Center(
                                      child: Text('No Raw Required')),
                                ),
                              );
                            }
                            return GridView.builder(
                                itemCount: length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  Map a = snapshot.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        GoRouter.of(context)
                                            .push('/product/${a['rid']}');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3,
                                                color: index == 3
                                                    ? Colors.blue
                                                    : Colors.red),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                    'https://static.wixstatic.com/media/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.png/v1/fill/w_520,h_420,al_c,lg_1,q_90/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.webp'),
                                                fit: BoxFit.fill)),
                                        child: FutureBuilder(
                                            future: HttpHelper()
                                                .fetchItem1(a['rid']),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                Map b = snapshot.data;
                                                return Column(
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              '${b['dname']} ${a['numbers']}'),
                                                          Center(
                                                            child: Text(
                                                              '${a['numbers']}',
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow.fade,
                                                              style: TextStyle(
                                                                  color: Colors.green,
                                                                  fontSize: 50,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(child: Text('123'),)
                                                  ],
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            List a = await HttpHelper().fetchItems();
            // sleep(const Duration(seconds: 3));
            print(a);
          },
          backgroundColor: Colors.blueGrey,
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: Text('Build'),
        ));
  }
}
