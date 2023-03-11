import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

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
          return myContainer(context, true, index);
        })
);