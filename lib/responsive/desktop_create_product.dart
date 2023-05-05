import 'dart:convert';
import 'dart:io';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/helper.dart';

class DesktopCreateProductPage extends StatefulWidget {
  const DesktopCreateProductPage({super.key, required this.title});

  final String title;

  @override
  State<DesktopCreateProductPage> createState() => _DesktopCreateProductPageState();
}

class _DesktopCreateProductPageState extends State<DesktopCreateProductPage> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  // List<int> selected = [];
  // List<int> select = [11,12,44,333,23,22, 21, 31, 41, 51, 61];
  List<int> selectedNumber = [];
  Future<List> items = HttpHelper().fetchItems();
  List<Map> selected = [];
  List select = [];
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final colorController = TextEditingController();

  final selectedController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  int count = 8;

  @override
  Widget build(BuildContext context) {
    if (colorController.text.isEmpty) {
      colorController.text = 'black';
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    void remove() {
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: myAppBar('CREATE NEW PRODUCT'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // setState(() {});
            if (formKey.currentState!.validate()) {
              int aa = await HttpHelper()
                  .createItem(nameController.text, categoryController.text, colorController.text, selected, selectedNumber);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
            }
          },
          backgroundColor: Colors.blueGrey,
          icon: Icon(
            Icons.arrow_forward,
            size: 30,
          ),
          label: Text('Submit'),
        ),
        body: Row(
          children: [
            Expanded(flex: 1, child: myDrawer(context, 4)),
            Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    //update UI
                                  });
                                },
                                child: Container(
                                  color: Colors.blueGrey,
                                  width: width / 9,
                                  height: width / 9,
                                  child: Center(child: image == null ? Text('Select Image') : Text(image!.name)),
                                ),
                              ),

                              Flexible(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        child: TextFormField(
                                          controller: nameController,
                                          decoration: InputDecoration(labelText: 'Product Name'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter name';
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        child: TextFormField(
                                          controller: categoryController,
                                          decoration: InputDecoration(labelText: 'Category'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Category';
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        child: TextFormField(
                                          controller: colorController,
                                          // initialValue: "black",
                                          decoration: InputDecoration(labelText: 'Color'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter name';
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Image.network('https://static.wixstatic.com/media/256076_689c3b907b5441248756c0b36f553cc4~mv2.jpeg/v1/fill/w_1276,h_727,al_c,q_85,usm_1.20_1.00_0.01,enc_auto/8100.jpeg')
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 30, 0, 12),
                            child: Text(
                              'required',
                              textAlign: TextAlign.right,
                              // style: TextStyle(fontSize: width / 80
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    height: height / 1.7,
                                    color: Colors.blueGrey[100],
                                    child: selected.isNotEmpty
                                        ? GridView.builder(
                                            itemCount: selected.length,
                                            shrinkWrap: true,
                                            physics: AlwaysScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 1000 ? 2 : 4),
                                            itemBuilder: (BuildContext context, int index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(index);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          selectedController.text = selectedNumber[index].toString();
                                                          return AlertDialog(
                                                            title: Text('${selected[index]['dname']}'),
                                                            // icon: const Icon(Icons.),
                                                            content: TextFormField(
                                                              autofocus: true,

                                                              inputFormatters: <TextInputFormatter>[
                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                TextInputFormatter.withFunction((oldValue, newValue) {
                                                                  // Disallow values that start with 0
                                                                  if (newValue.text.startsWith('0')) {
                                                                    return oldValue;
                                                                  }

                                                                  try {
                                                                    final int parsed = int.parse(newValue.text);
                                                                    if (parsed < 1) {
                                                                      return oldValue;
                                                                    }
                                                                    return newValue.copyWith(text: parsed.toString());
                                                                  } on FormatException catch (exe) {
                                                                    print(exe);
                                                                    return newValue;
                                                                  } catch (exe) {
                                                                    print(exe);
                                                                    return oldValue;
                                                                  }
                                                                }),
                                                              ],
                                                              // initialValue:
                                                              //     '${selectedNumber[index]}',
                                                              controller: selectedController,
                                                              keyboardType: TextInputType.number,
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    select.add(selected.removeAt(index));
                                                                    selectedNumber.removeAt(index);
                                                                    remove();
                                                                    setState(() {});
                                                                  },
                                                                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                                                                  child: Text(
                                                                    'Remove',
                                                                    // style: TextStyle(
                                                                    //     // color: Colors.red
                                                                    //     ),
                                                                  )),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    print(selectedController.text);
                                                                    selectedNumber[index] = int.parse(selectedController.text);
                                                                    remove();
                                                                    setState(() {});
                                                                  },
                                                                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                                                                  child: Text('OK')),
                                                            ],
                                                          );
                                                        });
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(width: 3, color: Colors.blueGrey),
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        image: const DecorationImage(
                                                            image: NetworkImage(
                                                                'https://static.wixstatic.com/media/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.png/v1/fill/w_520,h_420,al_c,lg_1,q_90/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.webp'),
                                                            fit: BoxFit.fill)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            '${selectedNumber[index]}',
                                                            softWrap: false,
                                                            overflow: TextOverflow.fade,
                                                            style: TextStyle(
                                                                color: Colors.green, fontSize: 50, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                                              color: Colors.blueGrey.withOpacity(0.5),
                                                            ),
                                                            child: Center(child: Text('${selected[index]['dname']}'))),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : const Center(child: Text('No item selected')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    height: height / 1.7,
                                    color: Colors.blueGrey[50],
                                    child: FutureBuilder(
                                        future: items,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            select = snapshot.data!;
                                            return GridView.builder(
                                                itemCount: select.length,
                                                shrinkWrap: true,
                                                physics: AlwaysScrollableScrollPhysics(),
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: width < 1000 ? 3 : 5),
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        print(index);
                                                        selected.add(select.removeAt(index));
                                                        // selected.add(snapshot.data![index]);
                                                        print(selected);
                                                        selectedNumber.add(1);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 3, colors: Colors.red),
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            image: const DecorationImage(
                                                                image: NetworkImage(
                                                                    'https://static.wixstatic.com/media/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.png/v1/fill/w_520,h_420,al_c,lg_1,q_90/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.webp'),
                                                                fit: BoxFit.fill)),
                                                        child: Text('${snapshot.data![index]['dname']}'),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                          return Center(child: CircularProgressIndicator());
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                )),
          ],
        ));
  }
}
// GridView.builder(
// itemCount: select.length,
// shrinkWrap: true,
// physics:
// AlwaysScrollableScrollPhysics(),
// gridDelegate:
// SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 5),
// itemBuilder:
// (BuildContext context, int index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: InkWell(
// onTap: () {
// print(index);
// selected.add(select.removeAt(index));
// selectedNumber.add(1);
// setState(() {});
// },
// child: Container(
// decoration: BoxDecoration(
// border: Border.all(
// width: 3,
// color: index == 3
// ? Colors.blue
//     : Colors.red),
// borderRadius:
// BorderRadius.all(
// Radius.circular(
// 12)),
// image: const DecorationImage(
// image: NetworkImage(
// 'https://static.wixstatic.com/media/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.png/v1/fill/w_520,h_420,al_c,lg_1,q_90/256076_a805139bd88749a8a2fe5dfcb954dc3c~mv2.webp'),
// fit: BoxFit.fill)),
// child: Text('data ${select[index]}'),
// ),
// ),
// );
// })
