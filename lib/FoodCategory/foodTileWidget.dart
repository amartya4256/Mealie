import 'package:Mealie/providers/cart.dart';
import 'package:Mealie/providers/favourites_provider.dart';
import 'package:Mealie/providers/foodMenuList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodTileWidget extends StatefulWidget {
  final Food food;

  FoodTileWidget(this.food);

  @override
  _FoodTileWidgetState createState() => _FoodTileWidgetState();
}

class _FoodTileWidgetState extends State<FoodTileWidget> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.widget.food.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this.widget.food.type,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.symmetric(
                    //     horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        _addOrRemoveFav(this.widget.food);
                      },
                      child: Icon(
                        Icons.star,
                        color: this.widget.food.favourite
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        cartProvider.addRemItem(this.widget.food);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              cartProvider.cartItems.contains(this.widget.food)
                                  ? Text("Added item to cart!")
                                  : Text("Removed item from cart!"),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: cartProvider.cartItems.contains(this.widget.food)
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Text(
                    'Rs. ${this.widget.food.price}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addOrRemoveFav(Food food) {
    setState(() {
      Provider.of<FavFoods>(context, listen: false).addOrRemoveFavourite(food);
    });
  }
}
