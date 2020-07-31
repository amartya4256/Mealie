import 'package:Mealie/FoodCategory/categoryScreenWidget.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String image;

  CategoryTile(this.title, this.image);

  void selectCategory(BuildContext ctx, String appBarData) {
    Navigator.of(ctx).pushNamed(
      CategoryScreen.route,
      arguments: {
        "appBarName": appBarData,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, this.title),
      splashColor: Theme.of(context).primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                this.image,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  this.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
