import 'package:flutter/material.dart';
import '../models/food_item_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<FoodItem> _foods = [
    FoodItem(
      id: 1,
      name: "Foundry Signature Pizza",
      description: "Double Mozzarella, Basil",
      price: 450,
      imageUrl: "assets/foods/pizza.jpg",
      category: "Pizza",
      rating: 4.8,
    ),
    FoodItem(
      id: 2,
      name: "Dev Burger XL",
      description: "Double Patty, Cheese",
      price: 350,
      imageUrl: "assets/foods/burger.jpg",
      category: "Burger",
      rating: 4.7,
    ),
    FoodItem(
      id: 3,
      name: "Chicken Alfredo",
      description: "Creamy Alfredo Pasta",
      price: 280,
      imageUrl: "assets/foods/pasta.jpg",
      category: "Pasta",
      rating: 4.6,
    ),
    FoodItem(
      id: 4,
      name: "Iced Lemon Tea",
      description: "Refreshing Citrus Drink",
      price: 120,
      imageUrl: "assets/foods/drink.jpg",
      category: "Drinks",
      rating: 4.5,
    ),
    FoodItem(
      id: 5,
      name: "Chocolate Cake",
      description: "Rich Chocolate Dessert",
      price: 180,
      imageUrl: "assets/foods/cake.jpg",
      category: "Desserts",
      rating: 4.9,
    ),
  ];

  List<FoodItem> get foods => filteredFoods;

  final List<String> categories = [
    "All",
    "Pizza",
    "Burger",
    "Pasta",
    "Drinks",
    "Desserts",
  ];

  String selectedCategory = "All";
  String searchText = "";

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void search(String value) {
    searchText = value;
    notifyListeners();
  }

  List<FoodItem> get searchedFoods {
    if (searchText.isEmpty) return _foods;

    return _foods.where((food) {
      return food.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  List<FoodItem> get filteredFoods {
    if (selectedCategory == "All") {
      return searchedFoods;
    }

    return searchedFoods.where((food) {
      return food.category == selectedCategory;
    }).toList();
  }

  void addToCart(int id) {
    final food = _foods.firstWhere((food) => food.id == id);
    food.quantity++;
    notifyListeners();
  }

  int get cartCount {
    int total = 0;

    for (final food in _foods) {
      total += food.quantity;
    }

    return total;
  }
}