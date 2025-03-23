import 'package:dio/dio.dart';
import 'package:movies/models/movie.dart';

class WishlistApiService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://ecommerce.routemisr.com/api/v1";
  final String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ZGFlMzcxN2E2NjQxZDY0Yzg3ZjQ4NiIsIm5hbWUiOiJtYWhtb3VkIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDIzOTgzNzcsImV4cCI6MTc1MDE3NDM3N30.r03U7bGIoSd0lfIKU1J7KfvDxb-VD9x_2SH765ctYxY"; // Replace with actual token

  WishlistApiService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }

  /// Get Wishlist
  Future<List<Movie>> getWishlist() async {
    try {
      final response = await _dio.get("$_baseUrl/wishlist");
      return response.data['data'];
    } catch (e) {
      print("Error fetching wishlist: $e");
      throw Exception("Failed to load wishlist");
    }
  }

  /// Add Product to Wishlist
  Future<void> addToWishlist(String productId) async {
    try {
      await _dio.post("$_baseUrl/wishlist", data: {'productId': productId});
    } catch (e) {
      print("Error adding to wishlist: $e");
      throw Exception("Failed to add to wishlist");
    }
  }

  /// Remove Product from Wishlist
  Future<void> removeFromWishlist(String productId) async {
    try {
      await _dio.delete("$_baseUrl/wishlist/$productId");
    } catch (e) {
      print("Error removing from wishlist: $e");
      throw Exception("Failed to remove from wishlist");
    }
  }
}



