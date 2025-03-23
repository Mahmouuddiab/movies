import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Bloc/movie_cubit.dart';
import 'package:movies/Bloc/movie_states.dart';
import 'package:movies/models/movie_repo.dart';
import 'package:movies/screens/home_screen.dart';

class MovieScreen extends StatelessWidget {
  final int movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(MovieRepository())..fetchMovie(movieId),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Movie Details",style: TextStyle(
              fontWeight: FontWeight.bold,color: Colors.white
            ),),
            centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
              icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        ),
        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is MovieLoaded) {
              final movie = state.movie;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}"),
                    SizedBox(height: 16),
                    Text(movie.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rating: ${movie.voteAverage}", style: TextStyle(fontSize: 18,color: Colors.white)),
                        Icon(Icons.star,color: Colors.orange,)
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(movie.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.white
                    ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("Search for a movie"));
          },
        ),
      ),
    );
  }
}
