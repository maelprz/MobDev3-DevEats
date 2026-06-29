import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../orders/order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Cash on Delivery";
  bool showSummary = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final total = vm.subtotal + vm.deliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F8FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B7FAB)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Color(0xFF0B7FAB),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
            const SizedBox(height: 10),

            _buildAddressCard(),

            const SizedBox(height: 18),

            _buildOrderSummary(vm),

            const SizedBox(height: 18),

            _buildPaymentCard(),

            const SizedBox(height: 18),

            _buildPriceCard(vm, total),

            const SizedBox(height: 30),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  "Secure SSL Encrypted Checkout",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  final orderedItems = vm.cartItems.map((food) {
                    return food.copyWith();
                  }).toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderTrackingScreen(
                        orderedItems: orderedItems,
                      ),
                    ),
                  );

                  vm.clearCart();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DD3F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place Order",
                      style: TextStyle(
                        color: Color(0xFF3E6B7C),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Color(0xFF3E6B7C)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.location_on, color: Color(0xFF0B7FAB), size: 18),
              SizedBox(width: 8),
              Text(
                "DELIVERY ADDRESS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B7FAB),
                ),
              ),
              Spacer(),
              Text(
                "Edit",
                style: TextStyle(color: Color(0xFF0B7FAB)),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFA6DBE0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.map, color: Colors.white),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unit 1203, Bacayan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("Cebu City, Philippines"),
                    SizedBox(height: 4),
                    Text(
                      "Arrival in 25-35 mins",
                      style: TextStyle(
                        color: Color(0xFF0B7FAB),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(HomeViewModel vm) {
    return Container(
      decoration: _boxStyle(),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        title: const Text(
          "ORDER SUMMARY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B7FAB),
          ),
        ),
        trailing: Text("${vm.cartItems.length} Items"),
        children: vm.cartItems.map((food) {
          return ListTile(
            title: Text(food.name),
            subtitle: Text("x${food.quantity}"),
            trailing: Text(
              "₱${(food.price * food.quantity).toStringAsFixed(2)}",
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _boxStyle(),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.payments, color: Color(0xFF0B7FAB)),
              SizedBox(width: 8),
              Text(
                "PAYMENT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B7FAB),
                ),
              ),
              Spacer(),
              Text(
                "Change",
                style: TextStyle(color: Color(0xFF0B7FAB)),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.wallet),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF0B7FAB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(
    HomeViewModel vm,
    double total,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Column(
        children: [
          _priceRow("Subtotal", vm.subtotal),
          _priceRow("Delivery Fee", vm.deliveryFee),

          const Divider(height: 30),

          _priceRow(
            "Total",
            total,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String label,
    double value, {
    bool free = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
            ),
          ),
          Text(
            free ? "Free" : "₱${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 28 : 15,
              color: isTotal ? const Color(0xFF0B7FAB) : Colors.black,
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black12),
    );
  }
}