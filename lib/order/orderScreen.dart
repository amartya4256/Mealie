import 'package:Mealie/drawer/drawerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static final String route = "/orders";

  @override
  Widget build(BuildContext context) {
    var id;
    var user =
        FirebaseAuth.instance.currentUser().then((value) => id = value.uid);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, futureSnapshot) =>
            futureSnapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder(
                    stream: Firestore.instance
                        .collection("users/orders/${futureSnapshot.data.uid}")
                        .snapshots(),
                    builder: (ctx, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var orderList = streamSnapshot.data.documents;
                      print(orderList[0].toString());
                      return orderList.length > 0
                          ? ListView.builder(
                              itemBuilder: (context, index) =>
                                  OrderTileWidget(orderList[index]),
                              itemCount: orderList.length,
                            )
                          : Center(
                              child: Text(
                                "No orders yet",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            );
                    },
                  ),
      ),
    );
  }
}

class OrderTileWidget extends StatelessWidget {
  final DocumentSnapshot data;

  OrderTileWidget(this.data);

  List<Row> _createRowList(BuildContext context) {
    List<Row> rowList = [];

    rowList.add(Row(
      children: <Widget>[
        Text(
          "Order Id : ",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Text(
          "${data.documentID}",
          style: Theme.of(context).textTheme.subtitle2,
        )
      ],
    ));

    data.data.forEach((key, value) {
      if (key != "total") {
        var row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              key,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "Rs. $value",
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        );
        rowList.add(row);
      }
    });
    rowList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            "Rs. ${data.data['total']}",
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: _createRowList(context),
          ),
        ),
      ),
    );
  }
}
