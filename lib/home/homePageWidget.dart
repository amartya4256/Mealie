import 'package:Mealie/cart/cartScreen.dart';
import 'package:Mealie/drawer/drawerWidget.dart';
import 'package:Mealie/favourite/favouriteScreen.dart';
import 'package:Mealie/home/categoriesWidget.dart';
import 'package:Mealie/newFood/addFoodScreen.dart';
import 'package:Mealie/profile/profileScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // AppBar appBar = AppBar(
  //   title: Text(_pages[_selectedPageIndex]['title']),
  // );
  final List<Map<String, Object>> _pages = [
    {'page': Categories(), 'title': 'Mealie'},
    {'page': FavouriteScreen(), 'title': 'Favourites'},
    {'page': ProfileScreen(), 'title': 'Me'},
  ];
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddFoodScreen.route);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.route);
            },
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(""),
          ),
        ],
      ),
    );
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }
}
