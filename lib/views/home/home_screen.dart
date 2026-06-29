import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/food_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF8DD3F3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "DevEats",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CartScreen(),
                      ),
                    );
                  },
                ),

                if (vm.cartCount > 0)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      vm.cartCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        children: [

          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: vm.search,
              decoration: InputDecoration(
                hintText: "Search food...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryChip(
                    title: vm.categories[index],
                    selected: vm.selectedCategory ==
                        vm.categories[index],
                    onTap: () {
                      vm.selectCategory(
                        vm.categories[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: vm.foods.isEmpty
                ? const Center(
                    child: Text(
                      "No food found.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: vm.foods.length,
                    itemBuilder: (_, index) {
                      final food = vm.foods[index];

                      return FoodCard(
                        food: food,
                        onAdd: () {
                          vm.addToCart(food.id);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              duration:
                                  const Duration(seconds: 1),
                              content: Text(
                                "${food.name} added to cart!",
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}