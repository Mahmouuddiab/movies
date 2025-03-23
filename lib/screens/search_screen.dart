import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Bloc/movie_cubit.dart';
import 'package:movies/Bloc/movie_states.dart';



class MovieSearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
            child: TextField(
        style: TextStyle(
            fontWeight: FontWeight.bold,color: Colors.white
        ),
        controller: controller,
        decoration: InputDecoration(
        labelText: 'Enter movie name',
        suffixIcon: IconButton(
         icon: Icon(Icons.search),
           onPressed: () {
              final cubit = context.read<MovieCubit>();
              cubit.searchMovie(controller.text);
          },
          ),
          floatingLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,color: Colors.white
          )
          ),
          ),
        ),
            Expanded(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if (state is MovieSearchLoaded) {
                    return ListView.builder(
                      itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                        final movie=state.movies[index];
                          return ListTile(
                            leading: movie.posterPath.isNotEmpty
                                ? Image.network(
                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                              width: 50,
                            )
                                : Icon(Icons.movie),
                            title: Text(movie.title,style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),),
                            subtitle: Text(movie.overview,style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),),
                          ) ;
                        },
                    );
                  }
                  else if (state is MovieSearchError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text("Search for a movie",style: TextStyle(
                    fontWeight: FontWeight.bold,color: Colors.white
                  ),));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}