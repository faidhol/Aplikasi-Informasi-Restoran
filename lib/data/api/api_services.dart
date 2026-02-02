import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class ApiServices {
  static const _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/list"));

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal memuat daftar restoran");
      }
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    } catch (_) {
      throw Exception("Terjadi kesalahan. Silakan coba lagi.");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal memuat detail restoran");
      }
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    } catch (_) {
      throw Exception("Terjadi kesalahan. Silakan coba lagi.");
    }
  }
}
