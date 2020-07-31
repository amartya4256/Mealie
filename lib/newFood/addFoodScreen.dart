import 'package:Mealie/providers/favourites_provider.dart';
import 'package:Mealie/providers/foodMenuList.dart';
import 'package:Mealie/tempData/dummyGridData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFoodScreen extends StatefulWidget {
  static final String route = "/add-item";

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  String _name;
  int _price;
  String dropdownValue = "Italian";

  FocusNode _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    Food food = Food(_name, dropdownValue, _price);
    var foodListProvider = Provider.of<FavFoods>(context, listen: false);
    foodListProvider.addItem(food);

    // print(food.name + " " + food.price.toString() + food.favourite.toString());
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = [];
    CATEGORIES_DATA.forEach((element) {
      categoryList.add(element.title);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Item name",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.replaceAll(" ", "").isEmpty) {
                      return "Please enter the item name.";
                    }
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  keyboardType: TextInputType.number,
                  // textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if (value.isEmpty || int.parse(value).isNaN) {
                      return "Please enter price in numbers.";
                    }
                  },
                  onSaved: (value) {
                    if (value.isNotEmpty) {
                      _price = int.parse(value);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: categoryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _saveForm();
                  },
                  child: Text(
                    "Add item",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                )
              ],
            )),
      ),
    );
  }
}
