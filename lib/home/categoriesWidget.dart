import 'package:Mealie/home/categoryTileWidget.dart';
import 'package:Mealie/tempData/dummyGridData.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        children: CATEGORIES_DATA
            .map((e) => CategoryTile(e.title, e.img_url))
            .toList(),
      ),
    );
  }
}
