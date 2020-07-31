import 'dart:async';

import 'package:Mealie/providers/foodMenuList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<Food> cartItems = [];

  addRemItem(Food food) {
    if (!cartItems.contains(food)) {
      cartItems.add(food);
    } else {
      cartItems.remove(food);
    }
    notifyListeners();
  }

  Future<DocumentReference> checkOut() async {
    if (cartItems.isNotEmpty) {
      int total = 0;
      Map<String, int> order = {};
      cartItems.forEach((element) {
        total += element.price;
        order[element.name] = element.price;
      });
      order["total"] = total;
      final user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      Firestore.instance.collection("users/orders/${user.uid}").add(order);
      emptyCart();
      notifyListeners();
    }
  }

  int totalAmount() {
    int total = 0;
    cartItems.forEach((element) {
      total += element.price;
    });
    return total;
  }

  void emptyCart() {
    cartItems = [];
  }
}
