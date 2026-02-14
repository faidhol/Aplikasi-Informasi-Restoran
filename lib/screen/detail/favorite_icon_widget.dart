import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final localDatabaseProvider = context.read<LocalDatabaseProvider>();
      final favoriteIconProvider = context.read<FavoriteIconProvider>();

      final id = widget.restaurant.id;

      await localDatabaseProvider.loadRestaurantValueById(id);

      final isFavorited = localDatabaseProvider.checkItemFavorite(id);

      favoriteIconProvider.isFavorited = isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIconProvider = context.watch<FavoriteIconProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();

    return IconButton(
      onPressed: () async {
        final id = widget.restaurant.id;

        if (favoriteIconProvider.isFavorited) {
          await localDatabaseProvider.removeRestaurantValueById(id);
        } else {
          await localDatabaseProvider.saveRestaurantValue(widget.restaurant);
        }

        favoriteIconProvider.isFavorited = !favoriteIconProvider.isFavorited;

        await localDatabaseProvider.loadAllRestaurantValue();
      },
      icon: Icon(
        favoriteIconProvider.isFavorited
            ? Icons.favorite
            : Icons.favorite_border,
      ),
    );
  }
}
