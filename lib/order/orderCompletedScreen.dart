import 'package:Mealie/order/orderScreen.dart';
import 'package:flutter/material.dart';

class OrderCompletedScreen extends StatelessWidget {
  static final String route = "/order-completed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order Summary"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_circle,
                    size: 150,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(OrderScreen.route),
                  child: Text(
                    "Go to Orders",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
