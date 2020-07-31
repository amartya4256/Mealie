import 'package:Mealie/FoodCategory/foodTileWidget.dart';
import 'package:Mealie/providers/favourites_provider.dart';
import 'package:Mealie/providers/foodMenuList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static const route = '/category';

  @override
  Widget build(BuildContext context) {
    final route =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String appBarData = route['appBarName'];
    final foodData = Provider.of<FavFoods>(context);
    final List<Food> foodList = foodData.foodList
        .where((element) => element.type == appBarData)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarData),
      ),
      body: foodList.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) => FoodTileWidget(foodList[index]),
              itemCount: foodList.length,
            )
          : Center(
              child: Text(
                "No food data available.",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
    );
  }
}
