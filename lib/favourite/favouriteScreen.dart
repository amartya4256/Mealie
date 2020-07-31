import 'package:Mealie/FoodCategory/foodTileWidget.dart';
import 'package:Mealie/providers/favourites_provider.dart';
import 'package:Mealie/providers/foodMenuList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    var foodData = Provider.of<FavFoods>(context);
    List<Food> _foodList =
        foodData.foodList.where((element) => element.favourite).toList();
    return Center(
      child: Container(
        child: _foodList.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) =>
                    FoodTileWidget(_foodList[index]),
                itemCount: _foodList.length,
              )
            : Center(
                child: Text(
                  "No food data available.",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
      ),
    );
  }
}
