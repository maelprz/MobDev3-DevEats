import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F8FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: Color(0xFF0B7FAB),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: vm.cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                const SizedBox(height: 10),

                _buildCartHeader(vm),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    itemCount: vm.cartItems.length,
                    itemBuilder: (context, index) {
                      final food = vm.cartItems[index];

                      return CartItemCard(
                        food: food,
                        onIncrease: () =>
                            vm.increaseQuantity(food.id),
                        onDecrease: () =>
                            vm.decreaseQuantity(food.id),
                        onRemove: () =>
                            vm.removeFromCart(food.id),
                      );
                    },
                  ),
                ),

                _buildBottomSummary(context, vm),
              ],
            ),
    );
  }

  Widget _buildCartHeader(HomeViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            color: Color(0xFF0B7FAB),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${vm.cartCount} Items in Cart",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Estimated delivery: 25-35 mins",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummary(
    BuildContext context,
    HomeViewModel vm,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          _priceRow(
            "Subtotal",
            vm.subtotal,
          ),

          const SizedBox(height: 12),

          _priceRow(
            "Delivery Fee",
            vm.deliveryFee,
          ),

          const Divider(height: 28),

          _priceRow(
            "Total",
            vm.total,
            isTotal: true,
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CheckoutScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8DD3F3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Proceed to Checkout",
                    style: TextStyle(
                      color: Color(0xFF3E6B7C),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF3E6B7C),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "₱${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? const Color(0xFF0B7FAB)
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 60,
              color: Color(0xFF0B7FAB),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Add some delicious food first.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}