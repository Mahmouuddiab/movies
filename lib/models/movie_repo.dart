import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;
class MovieRepository {
  final Dio dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3/movie/";
  final String apiKey = "c8fe33fcd132b7a45bfed9113b9ba103";
  final String accountId="2147483648";
  final String sessionId="movie";

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get("$baseUrl$movieId", queryParameters: {
        "api_key": apiKey,
        "language": "en-US",
      });

      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception("Failed to load movie details");
      }
    } catch (e) {
      throw Exception("Error fetching movie: $e");
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = 'https://api.themoviedb.org/3/search/movie';

    try {
      final response = await dio.get(url, queryParameters: {
        'api_key': apiKey,
        'query': query,
      });

      if (response.statusCode == 200) {
        List results = response.data['results'];
        return results.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> fetchWatchlist() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/account/$accountId/watchlist/movies?api_key=$apiKey&session_id=$sessionId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Movie> movies = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception("Failed to load watchlist");
    }
  }

  Future<void> updateWatchlist(int movieId, bool watchlist) async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/account/$accountId/watchlist?api_key=$apiKey&session_id=$sessionId");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "media_type": "movie",
        "media_id": movieId,
        "watchlist": watchlist,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to update watchlist");
    }
  }
}
