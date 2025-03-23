import 'package:movies/models/movie.dart';

class LayoutStates{}
class InitialStateOfMovies extends LayoutStates{}
class ChangeBottomNavIndexSuccessState extends LayoutStates{}

class GetUpComingMoviesSuccessState extends LayoutStates{}
class GetUpComingMoviesLoadingState extends LayoutStates{}
class GetUpComingMoviesErrorState extends LayoutStates{}

class GetUpTopMoviesSuccessState extends LayoutStates{}
class GetUpTopMoviesLoadingState extends LayoutStates{}
class GetUpTopMoviesErrorState extends LayoutStates{}

class GetPopularMoviesSuccessState extends LayoutStates{}
class GetPopularMoviesLoadingState extends LayoutStates{}
class GetPopularMoviesErrorState extends LayoutStates{}

class GetMoviesDetailsSuccessState extends LayoutStates{}
class GetMoviesDetailsLoadingState extends LayoutStates{}
class GetMoviesDetailsErrorState extends LayoutStates{}

class WishlistInitial extends LayoutStates {}

class WishlistLoading extends LayoutStates {}

class WishlistLoaded extends LayoutStates {
List<Movie>movies;
WishlistLoaded({required this.movies});
}

class WishlistError extends LayoutStates {

}