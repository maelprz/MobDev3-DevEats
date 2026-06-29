import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/food_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("DevEats"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              label: Text(vm.cartCount.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: vm.search,
              decoration: InputDecoration(
                hintText: "Search our menu...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length,
              itemBuilder: (_, index) {
                return CategoryChip(
                  title: vm.categories[index],
                  selected: vm.selectedCategory == vm.categories[index],
                  onTap: () {
                    vm.selectCategory(vm.categories[index]);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: vm.foods.length,
              itemBuilder: (_, index) {
                final food = vm.foods[index];

                return FoodCard(
                  food: food,
                  onAdd: () => vm.addToCart(food.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}