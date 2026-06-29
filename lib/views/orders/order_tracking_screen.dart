import 'package:flutter/material.dart';
import '../../models/food_item_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final List<FoodItem> orderedItems;

  const OrderTrackingScreen({
    super.key,
    required this.orderedItems,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F8FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Color(0xFF0B7FAB),
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: const Text(
          "Track Order",
          style: TextStyle(
            color: Color(0xFF0B7FAB),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Center(
              child: SizedBox(
                width: 50,
                child: Divider(
                  thickness: 4,
                  color: Colors.black12,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Order Status",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "#123456",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _buildTimeline(),

            const SizedBox(height: 25),

            _buildRiderCard(),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Order Items",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "View Receipt",
                  style: TextStyle(
                    color: Color(0xFF0B7FAB),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            ...orderedItems.map<Widget>(
              (food) => _buildOrderItem(
                food.name,
                food.description,
                food.price * food.quantity,
                food.imageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = [
      ["Order Confirmed", "Your order has been received by DevEats"],
      ["Preparing your meal", "DevEats is adding final touches"],
      ["Out for Delivery", "Rider is on his way"],
      ["Arrived", "Enjoy your meal!"],
    ];

    return Column(
      children: List.generate(
        steps.length,
        (index) {
          final active = index < 3;

          return Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: active
                        ? const Color(0xFF0B7FAB)
                        : Colors.grey.shade300,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  if (index != steps.length - 1)
                    Container(
                      width: 2,
                      height: 45,
                      color: Colors.grey.shade300,
                    ),
                ],
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index][0],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: active
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        steps[index][1],
                        style: TextStyle(
                          color: active
                              ? Colors.black54
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRiderCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage:
                    AssetImage("assets/rider.jpg"),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aiden Carter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text("⭐ 4.9 (2.4k deliveries)"),
                  ],
                ),
              ),

              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {},
                ),
              ),

              const SizedBox(width: 10),

              CircleAvatar(
                backgroundColor: const Color(0xFF0B7FAB),
                child: IconButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "I'm riding a green e-bike, see you soon!",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(
    String name,
    String desc,
    double price,
    String image,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name),
        subtitle: Text(desc),
        trailing: Text(
          "₱${price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}