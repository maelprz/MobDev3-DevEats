import 'package:flutter/material.dart';
import '../models/food_item_model.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onAdd;

  const FoodCard({
    super.key,
    required this.food,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                food.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Icon(Icons.star, color: Colors.amber),

                Text(food.rating.toString()),
              ],
            ),

            const SizedBox(height: 5),

            Text(
              food.description,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Text(
                  "₱${food.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF0B7FAB),
                  ),
                ),

                const Spacer(),

                ElevatedButton.icon(
                  onPressed: onAdd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8DD3F3),
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text(
                    "Add",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}