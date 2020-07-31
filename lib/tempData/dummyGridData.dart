class FoodCategories {
  final String title;
  final String img_url;

  const FoodCategories(this.title, this.img_url);
}

const CATEGORIES_DATA = [
  FoodCategories("Italian", "assets/images/italian.jpg"),
  FoodCategories("Chinese", 'assets/images/chinese.jpg'),
  FoodCategories("Indian", 'assets/images/indian.jpg'),
  FoodCategories("Snacks", 'assets/images/italian.jpg'),
  FoodCategories("Beverages", 'assets/images/indian.jpg'),
  FoodCategories("Mexican", 'assets/images/chinese.jpg'),
  FoodCategories("Sweets", 'assets/images/indian.jpg'),
  FoodCategories("Veggies", 'assets/images/indian.jpg'),
  FoodCategories("Non-Veg", 'assets/images/chinese.jpg')
];
