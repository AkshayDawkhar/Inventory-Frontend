import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  Future<List> fetchItems() async {
    List<Map> items = [{}, {}];
    // Uri url = Uri.parse('http://127.0.0.1:8000/product/');
    // final a = await http.get(url);

    final url = Uri.parse('http://127.0.0.1:8000/product/');
    // await Future.delayed(Duration(seconds: 1));
    final a = await http.get(url);
    print(a.statusCode);
    final json = jsonDecode(a.body);
    return json;
  }

  Future fetchItem(String pid) async {
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('http://127.0.0.1:8000/build/edit/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
  Future fetchItemName(String pid) async {
    await Future.delayed(Duration(seconds: 5));
    final url = Uri.parse('http://127.0.0.1:8000/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
  Future createItem(String name,String category,String color,List requiredItems,List requiredItemsNo) async {
    final url = Uri.parse('http://127.0.0.1:8000/product/');
    final requiredItemsId = requiredItems.map((e) => e['pid']).toList();
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "category": category,
          "dname": name,
          "color":color,
          "required_items": requiredItemsId,
          "required_items_no": requiredItemsNo
        }));
    print(responce.body);
    return 1;
  }
  Future<List> fetchRequired(String pid) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/required/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
  Future fetchItem1(String pid) async {
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('http://127.0.0.1:8000/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('______________-----_____________');
    print(json);
    return json;
  }
  Future<List> fetchNeeded(String pid) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/needed/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
  Future<int> fetchMax(String pid) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
}
