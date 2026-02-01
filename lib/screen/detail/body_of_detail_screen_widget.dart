import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final foods = restaurant.menus?.foods ?? [];
    final drinks = restaurant.menus?.drinks ?? [];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
              fit: BoxFit.cover,
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox.square(dimension: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Text('Foods'),
            Column(
              children: [
                ...foods.map(
                  (food) => ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: Text(food),
                  ),
                ),
              ],
            ),
            const Text('Drinks'),
            Column(
              children: [
                ...drinks.map(
                  (drink) => ListTile(
                    leading: const Icon(Icons.local_drink),
                    title: Text(drink),
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
