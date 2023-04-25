import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

import '../helper.dart';

class DesktopOrderPage extends StatefulWidget {
  const DesktopOrderPage({Key? key}) : super(key: key);

  @override
  State<DesktopOrderPage> createState() => _DesktopOrderPageState();
}

class _DesktopOrderPageState extends State<DesktopOrderPage> {
  late Future<List> items;

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    items = HttpHelper().fetchOrder();
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppBar('ORDERS'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 2)),
          Expanded(
              flex: 6,
              child: FutureBuilder(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.blueGrey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '  Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'continuity',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'edit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'complete',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map data = snapshot.data![index];
                                  DateTime dateTime = DateTime.parse(data['timestamp']);
                                  String day = dateTime.day.toString();
                                  String month = dateTime.month.toString();
                                  String year = dateTime.year.toString();

                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          child: Text('name'),
                                          onTap: () {},
                                        ),
                                        Text('$day/$month/$year'),
                                        Text('${data['numbers']}'),
                                        Icon(Icons.edit),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.done))
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(Icons.done),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.greenAccent)),
                                        )
                                        // TextButton(
                                        //     onPressed: () {}, child: Icon(Icons.done))
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
