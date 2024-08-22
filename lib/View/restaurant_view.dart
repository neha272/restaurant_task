import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_task/model/restaurant_model.dart';
import 'package:restaurant_task/provider/restaurant_provider.dart';

class RestaurantListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(filteredRestaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(ref),
            const SizedBox(height: 16),
            _buildRestaurantList(restaurants),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search',
        labelStyle: TextStyle(color: Colors.teal),
        prefixIcon: Icon(Icons.search, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        final allRestaurants = ref.read(restaurantProvider);
        final filteredRestaurants = allRestaurants
            .where((restaurant) => restaurant.name
            .toLowerCase()
            .contains(value.toLowerCase()))
            .toList();
        ref.read(filteredRestaurantProvider.notifier).state =
            filteredRestaurants;
      },
    );
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    return Expanded(
      child: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Icon(
                Icons.restaurant,
                color: Colors.teal,
                size: 40,
              ),
              title: Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                restaurant.cuisine,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}

