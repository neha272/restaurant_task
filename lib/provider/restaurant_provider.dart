import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_task/model/restaurant_model.dart';


final restaurantProvider = Provider<List<Restaurant>>((ref) {
  const jsonData = [
    {"id": 1, "name": "The Smokehouse", "cuisine": "Barbecue"},
    {"id": 2, "name": "Pinocchio's Pizza", "cuisine": "Italian"},
    {"id": 3, "name": "Felipe's Taqueria", "cuisine": "Mexican"},
    {"id": 4, "name": "Tasty Burger", "cuisine": "American"},
  ];

  return jsonData.map((data) => Restaurant.fromJson(data)).toList();
});

final filteredRestaurantProvider =
StateProvider<List<Restaurant>>((ref) => ref.watch(restaurantProvider));
