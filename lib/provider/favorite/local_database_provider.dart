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

  Future<void> saveRestaurantValue(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);
      _message =
          result == 0 ? "Failed to save your data" : "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurantValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All of your data is loaded";
    } catch (e) {
      _message = "Failed to load your all data";
    }
    notifyListeners();
  }

  Future<void> loadRestaurantValueById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
    } catch (e) {
      _message = "Failed to load your data";
    }
    notifyListeners();
  }

  Future<void> removeRestaurantValueById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Your data is removed";
    } catch (e) {
      _message = "Failed to remove your data";
    }
    notifyListeners();
  }

  bool checkItemFavorite(String id) {
    return _restaurant?.id == id;
  }
}
