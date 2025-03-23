import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Bloc/layout_states.dart';
import 'package:movies/models/ComingMovie.dart';
import 'package:movies/models/PopularMovie.dart';
import 'package:movies/models/TopMovie.dart';
import 'package:movies/models/service.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/watch_list.dart';


class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(InitialStateOfMovies());
  static WishlistApiService ?_apiService;
  static const String apiKey = 'c8fe33fcd132b7a45bfed9113b9ba103';
  static const String baseUrl = 'https://api.themoviedb.org/3/movie';
  int selectedIndex=0;
  void changeBottomNavIndex({required int index}){
    selectedIndex=index;
    emit(ChangeBottomNavIndexSuccessState());
  }
  List<Widget>pages=[HomeScreen(),MovieSearchScreen(),WishlistScreen()];

  List<Comingmovie> upComings=[];
  void getUpComingMovies()async{
    emit(GetUpComingMoviesLoadingState());
    Response response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=c8fe33fcd132b7a45bfed9113b9ba103")
    );
    var responseBody=jsonDecode(response.body);
    if(response.statusCode==200){
      for(var item in responseBody['results']){
        upComings.add(Comingmovie.fromJson(item));
      }
      emit(GetUpComingMoviesSuccessState());
    }
    else{
      emit(GetUpComingMoviesErrorState());
    }
  }

  List<TopMovie> topRatedMovies=[];
  void getTopRatedMovies()async{
    emit(GetUpTopMoviesLoadingState());
    Response response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=c8fe33fcd132b7a45bfed9113b9ba103")
    );
    var responseBody=jsonDecode(response.body);
    if(response.statusCode==200){
      for(var item in responseBody['results']){
        topRatedMovies.add(TopMovie.fromJson(item));
      }
      emit(GetUpTopMoviesSuccessState());
    }
    else{
      emit(GetUpTopMoviesErrorState());
    }
  }

  List<PopularMovie>popularMovies=[];
  void getPopularMovies()async{
    emit(GetPopularMoviesLoadingState());
    Response response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=c8fe33fcd132b7a45bfed9113b9ba103")
    );
    var responseBody=jsonDecode(response.body);
    print("respons body is: $responseBody");
    if(response.statusCode==200){
      for(var item in responseBody['results']){
        popularMovies.add(PopularMovie.fromJson(item));
      }
      emit(GetPopularMoviesSuccessState());
    }
    else{
      emit(GetPopularMoviesErrorState());
    }
  }


}