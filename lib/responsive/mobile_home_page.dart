import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/helper.dart';

Widget mobileHomepageBody = Center(
    child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        addRepaintBoundaries: true,
        addAutomaticKeepAlives: true,
        itemCount: items.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (BuildContext context, int index) {
          return myContainer(context, true, index, '8a9bcdaa-ba8a-11ed-bdf7-f889d2e645af', 'name');
          // return myContainer(context, true, index, 'name');
        }));

// Widget cen(String pid){
//   print(pid);
//   return FutureBuilder(
//     future: HttpHelper().fetchItem(pid),
//     builder: (builder, snapshot) {
//       if (snapshot.hasData) {
//         return Center(child: Text(snapshot.data.toString()));
//       }
//       return const Center(child: CircularProgressIndicator());
//     });}
