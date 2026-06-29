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
      description: "Refreshing Lemon Tea",
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

  List<FoodItem> get foods => filteredFoods;

  List<FoodItem> get cartItems =>
      _foods.where((food) => food.quantity > 0).toList();

  int get cartCount =>
      cartItems.fold(0, (sum, food) => sum + food.quantity);

  double get subtotal =>
      cartItems.fold(0, (sum, food) => sum + (food.price * food.quantity));

  double get deliveryFee => cartItems.isEmpty ? 0 : 50;

  double get total => subtotal + deliveryFee;

  void search(String value) {
    searchText = value;
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<FoodItem> get searchedFoods {
    if (searchText.isEmpty) return _foods;

    return _foods.where((food) {
      return food.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  List<FoodItem> get filteredFoods {
    if (selectedCategory == "All") return searchedFoods;

    return searchedFoods.where((food) {
      return food.category == selectedCategory;
    }).toList();
  }

  void addToCart(int id) {
    final food = _foods.firstWhere((f) => f.id == id);

    food.quantity++;

    notifyListeners();
  }

  void increaseQuantity(int id) {
    final food = _foods.firstWhere((f) => f.id == id);

    food.quantity++;

    notifyListeners();
  }

  void decreaseQuantity(int id) {
    final food = _foods.firstWhere((f) => f.id == id);

    if (food.quantity > 1) {
      food.quantity--;
    } else {
      food.quantity = 0;
    }

    notifyListeners();
  }

  void removeFromCart(int id) {
    final food = _foods.firstWhere((f) => f.id == id);

    food.quantity = 0;

    notifyListeners();
  }
}