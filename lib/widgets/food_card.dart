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
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: Image.asset(
              food.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

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

                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      food.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  food.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 18),

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

                    food.quantity == 0

                        ? ElevatedButton.icon(
                            onPressed: onAdd,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8DD3F3),
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                            ),
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )

                        : Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: const [

                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  "Added",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}