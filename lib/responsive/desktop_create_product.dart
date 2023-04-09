import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';
import 'package:image_picker/image_picker.dart';

class DesktopCreateProductPage extends StatefulWidget {
  const DesktopCreateProductPage({super.key, required this.title});

  final String title;

  @override
  State<DesktopCreateProductPage> createState() =>
      _DesktopCreateProductPageState();
}

class _DesktopCreateProductPageState extends State<DesktopCreateProductPage> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: myAppBar('CREATE NEW PRODUCT'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')));
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
                child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    alignment: Alignment.topCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    InkWell(
                      onTap: () async {
                        image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        setState(() {
                          //update UI
                        });
                      },
                      child: Container(
                        color: Colors.blueGrey,
                        width: width/9,
                        height: width/9,
                        child: Center(child: image == null ? Text('Select Image'):Text(image!.name)),
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
                                    decoration:
                                    InputDecoration(labelText: 'Product Name'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter name';
                                      }
                                    },
                                  ),
                                ),Container(
                                  padding: EdgeInsets.all(12),
                                  child: TextFormField(
                                    decoration:
                                    InputDecoration(labelText: 'Category'),
                                    validator: (value) {
                                      if (value!.isEmpty ) {
                                        return 'Enter Category';
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: TextFormField(
                                    initialValue: "black",
                                    decoration: InputDecoration(
                                        labelText: 'Color'),
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
                    ))),
          ],
        ));
  }
}
