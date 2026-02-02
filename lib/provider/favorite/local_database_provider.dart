import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  // Save restaurant to local database
  Future<void> saveRestaurantValue(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);
      _message = result == 0
          ? "Failed to save your data"
          : "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  // Load all restaurant data
  Future<void> loadAllRestaurantValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All of your data is loaded";
    } catch (e) {
      _message = "Failed to load your all data";
    }
    notifyListeners();
  }

  // Load restaurant by id
  Future<void> loadRestaurantValueById(int id) async {
    try {
      _restaurant = await _service.getItemById(id as String);
      _message = "Your data is loaded";
    } catch (e) {
      _message = "Failed to load your data";
    }
    notifyListeners();
  }

  // Remove restaurant by id
  Future<void> removeRestaurantValueById(int id) async {
    try {
      await _service.removeItem(id as String);
      _message = "Your data is removed";
    } catch (e) {
      _message = "Failed to remove your data";
    }
    notifyListeners();
  }

  // Check favorite status (NULL SAFE)
  bool checkItemFavorite(int id) {
  return _restaurant?.id == id.toString();
}
}
