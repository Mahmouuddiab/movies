

import 'package:movies/models/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}
class MovieLoading extends MovieState {}
class MovieLoaded extends MovieState {
  final Movie movie;
  MovieLoaded(this.movie);
}
class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}


class MovieSearchInitial extends MovieState {}
class MovieSearchLoading extends MovieState {}
class MovieSearchLoaded extends MovieState {
  final List<Movie> movies;
  MovieSearchLoaded({required this.movies});
}
class MovieSearchError extends MovieState {
  final String message;
  MovieSearchError(this.message);
}

class AddMovieToFavoriteSuccessState extends MovieState{
  final List<Movie> movies;
  AddMovieToFavoriteSuccessState({required this.movies});
}
class AddMovieToFavoriteLoadingState extends MovieState{}
class AddMovieToFavoriteErrorState extends MovieState{}

