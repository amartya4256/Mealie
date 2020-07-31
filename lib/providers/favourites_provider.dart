import 'package:Mealie/providers/foodMenuList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavFoods with ChangeNotifier {
  List<Food> _foodList = [
    Food("Butter Chicken", "Indian", 200),
    Food("Pizza", "Italian", 400),
    Food("Pasta", "Italian", 100),
    Food("Noodles", "Chinese", 70),
    Food("Indian Thali", "Indian", 500),
    Food("Biryani", "Indian", 450),
  ];
  List<Food> get foodList {
    return _foodList;
  }

  // void listenChangeAndUpdate() async {
  //   print("Run hua re");
  //   Firestore.instance.collection('food').snapshots().listen((event) {
  //     event.documents.forEach((element) {
  //       _foodList = [];
  //       Food food = Food(element["name"], element["type"], element["price"],
  //           element["favourite"]);
  //       if (!_foodList.contains(food)) {
  //         _foodList.add(food);
  //       }
  //     });
  //   });
  // }

  void addItem(Food food) {
    Firestore.instance.collection('food').add({
      "name": food.name,
      "price": food.price,
      "type": food.type,
      "favourite": food.favourite,
    }).then((value) {
      _foodList.add(food);
      notifyListeners();
    });
  }

  void addOrRemoveFavourite(Food food) {
    food.favourite = !food.favourite;
    notifyListeners();
  }
}
