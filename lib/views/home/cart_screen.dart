import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: vm.cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.cartItems.length,
                    itemBuilder: (context, index) {
                      final food = vm.cartItems[index];

                      return CartItemCard(
                        food: food,

                        onIncrease: () {
                          vm.increaseQuantity(food.id);
                        },

                        onDecrease: () {
                          vm.decreaseQuantity(food.id);
                        },

                        onRemove: () {
                          vm.removeFromCart(food.id);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black12,
                      )
                    ],
                  ),

                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subtotal",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "₱${vm.subtotal.toStringAsFixed(2)}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Fee",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "₱${vm.deliveryFee.toStringAsFixed(2)}",
                          ),
                        ],
                      ),

                      const Divider(height: 30),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₱${vm.total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B7FAB),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8DD3F3),
                          ),

                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}