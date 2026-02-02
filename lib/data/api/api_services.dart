import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class ApiServices {
  static const _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http
          .get(Uri.parse("$_baseUrl/list"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal memuat daftar restoran");
      }
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    } on HttpException {
      throw Exception("Gagal terhubung ke server");
    } on FormatException {
      throw Exception("Format data tidak valid");
    } catch (e) {
      throw Exception("Terjadi kesalahan: ${e.toString()}");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final response = await http
          .get(Uri.parse("$_baseUrl/detail/$id"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal memuat detail restoran");
      }
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    } on HttpException {
      throw Exception("Gagal terhubung ke server");
    } on FormatException {
      throw Exception("Format data tidak valid");
    } catch (e) {
      throw Exception("Terjadi kesalahan: ${e.toString()}");
    }
  }
}
