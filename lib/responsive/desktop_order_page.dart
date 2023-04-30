import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory/constants.dart';
import 'package:go_router/go_router.dart';
import '../helper.dart';

class DesktopOrderPage extends StatefulWidget {
  const DesktopOrderPage({Key? key}) : super(key: key);

  @override
  State<DesktopOrderPage> createState() => _DesktopOrderPageState();
}

class _DesktopOrderPageState extends State<DesktopOrderPage> {
  late Future<List> items;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _continuityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                                  DateTime dateTime =
                                      DateTime.parse(data['timestamp']);
                                  String day = dateTime.day.toString();
                                  String month = dateTime.month.toString();
                                  String year = dateTime.year.toString();
                                  String pid = data['pid'];
                                  String numbers = data['numbers'].toString();
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
                                        SizedBox(
                                          width: 150,
                                          child: InkWell(
                                            child: FutureBuilder(
                                                future: HttpHelper()
                                                    .fetchItemName(pid),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        '${snapshot.data['dname']}');
                                                  } else {
                                                    return Text('name');
                                                  }
                                                }),
                                            onTap: () {
                                              GoRouter.of(context)
                                                  .push('/product/$pid');
                                            },
                                          ),
                                        ),
                                        Text('$day/$month/$year'),
                                        Text(numbers),
                                        InkWell(
                                          child: Icon(Icons.edit),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  _dateController.text =
                                                      '$day/$month/$year';
                                                  _continuityController.text =
                                                      numbers;
                                                  return AlertDialog(
                                                    title: Text('Edit'),
                                                    content: Form(
                                                      key: formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                _dateController,
                                                            onTap: () {
                                                              showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    dateTime,
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100),
                                                              ).then((value) {
                                                                setState(() {
                                                                  dateTime =
                                                                      value!;
                                                                });
                                                                _dateController
                                                                        .text =
                                                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                                                                print(
                                                                    'setting state');
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: "Date",
                                                            ),
                                                          ),
                                                          TextFormField(
                                                            onTap: () {},
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <
                                                                TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9]')),
                                                            ],
                                                            controller:
                                                                _continuityController,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "continuity",
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Please enter a username";
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: Text('Delete'),
                                                        style: TextButton
                                                            .styleFrom(
                                                                foregroundColor:
                                                                    Colors.red),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {}
                                                          },
                                                          child: Text('Save'))
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.done))
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('complete Order'),
                                                    content: TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'continuity',
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(onPressed: (){}, child: Text('cancel')),
                                                      TextButton(onPressed: (){}, child: Text('complete'))
                                                    ],
                                                  );
                                                });
                                          },
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
