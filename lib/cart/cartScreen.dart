import 'package:Mealie/FoodCategory/foodTileWidget.dart';
import 'package:Mealie/order/orderCompletedScreen.dart';
import 'package:Mealie/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static final String route = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final AppBar appBar = AppBar(
    title: Text('Cart'),
  );

  var isOrdering = false;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: appBar,
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Text(
                "No Item in cart.",
                style: Theme.of(context).textTheme.headline2,
              ),
            )
          : Container(
              child: Column(
              children: <Widget>[
                Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.9
                          : (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.80,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.white,
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          Provider.of<Cart>(context, listen: false)
                              .addRemItem(cartProvider.cartItems[index]);
                        },
                        confirmDismiss: (direction) {
                          return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Are you sure?"),
                              content: Text("Do you want to remove the item?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: FoodTileWidget(cartProvider.cartItems[index])),
                    itemCount: cartProvider.cartItems.length,
                  ),
                ),
                Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.1
                          : (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.20,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total : ${cartProvider.totalAmount()}",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: isOrdering
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        isOrdering = true;
                                      });
                                      cartProvider.checkOut().then((value) {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                OrderCompletedScreen.route);
                                      });
                                    },
                                    child: Text(
                                      'Checkout',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      // bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }
}
