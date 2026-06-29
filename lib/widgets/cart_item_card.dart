import 'package:flutter/material.dart';
import '../models/food_item_model.dart';

class CartItemCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.food,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                food.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    food.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    food.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "₱${food.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color(0xFF0B7FAB),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            Colors.grey.shade300,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          icon: const Icon(Icons.remove),
                          onPressed: onDecrease,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12),
                        child: Text(
                          food.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            const Color(0xFF8DD3F3),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          color: Colors.white,
                          icon: const Icon(Icons.add),
                          onPressed: onIncrease,
                        ),
                      ),

                      const Spacer(),

                      TextButton.icon(
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        label: const Text(
                          "Remove",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}