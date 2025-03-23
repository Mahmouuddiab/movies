import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Bloc/layout_cubit.dart';
import 'package:movies/firebase/firebse_functions.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<LayoutCubit>(context);
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children:  [
                SizedBox(height: 40,),
                const Row(
                  children:  [
                    Text("UpComing Movies",style:  TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                    Spacer(),
                    Text("View All",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey
                    ),)
                  ],
                ),
                const SizedBox(height: 20),
                cubit.upComings.isEmpty?
                const Center(child: CircularProgressIndicator())
                    :SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:cubit.upComings.length,
                        itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MovieScreen(movieId: cubit.upComings[index].id!),));
                          },
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network("https://image.tmdb.org/t/p/original/${cubit.upComings[index].backdropPath!}",fit: BoxFit.cover,),
                                height: 150,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                              ),
                              Positioned(
                                child:
                                Text(cubit.upComings[index].title!,style: const TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                                left: 10,
                                top: 120,
                              ),
                              Positioned(
                                child: IconButton
                                (
                                  onPressed: (){
                                    Movie movie=Movie(id: cubit.upComings[index].id!,
                                        title: cubit.upComings[index].title!,
                                        overview: cubit.upComings[index].overview!,
                                        posterPath: cubit.upComings[index].posterPath!,
                                        releaseDate: cubit.upComings[index].releaseDate!,
                                        voteAverage: cubit.upComings[index].voteAverage!,
                                        voteCount: cubit.upComings[index].voteCount!);
                                    FirebaseFunctions.addMovieToFireStore(movie).timeout(Duration(seconds: 3),
                                        onTimeout:() {
                                          print("movie add to watchlist");
                                        },
                                    );
                                  },
                                  icon: Icon(Icons.add,color: Colors.white,),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: CircleBorder()
                                ),
                              ),
                                top: 0,
                                right: 4,
                              )
                            ],
                          ),
                        ) ;
                      },
                                    ),
                    ),
                const SizedBox(height: 50,),
                const Row(
                  children:  [
                    Text("TopRated Movies",style:  TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                    Spacer(),
                    Text("View All",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey
                    ),)
                  ],
                ),
                SizedBox(height: 20,),
                cubit.topRatedMovies.isEmpty?
                    const Center(child: CircularProgressIndicator())
                    :SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:cubit.topRatedMovies.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MovieScreen(movieId: cubit.topRatedMovies[index].id!),));
                        },
                        child: Stack(
                          children: [
                            Container(
                              child: Image.network("https://image.tmdb.org/t/p/original/${cubit.topRatedMovies[index].backdropPath!}",fit: BoxFit.cover,),
                              height: 150,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                            ),
                            Positioned(
                              child:
                              Text(cubit.topRatedMovies[index].title!,style: const TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              left: 10,
                              top: 120,
                            ),
                            Positioned(
                              child: IconButton
                                (
                                onPressed: (){
                                  Movie movie=Movie(id: cubit.topRatedMovies[index].id!,
                                      title: cubit.topRatedMovies[index].title!,
                                      overview: cubit.topRatedMovies[index].overview!,
                                      posterPath: cubit.topRatedMovies[index].posterPath!,
                                      releaseDate: cubit.topRatedMovies[index].releaseDate!,
                                      voteAverage: cubit.topRatedMovies[index].voteAverage!,
                                      voteCount: cubit.topRatedMovies[index].voteCount!);
                                  FirebaseFunctions.addMovieToFireStore(movie).timeout(Duration(seconds: 3),
                                    onTimeout:() {
                                      print("movie add to watchlist");
                                    },
                                  );
                                },
                                icon: Icon(Icons.add,color: Colors.white,),
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: CircleBorder()
                                ),
                              ),
                              top: 0,
                              right: 4,
                            )
                          ],
                        ),
                      )  ;
                    },
                  ),
                ),
                SizedBox(height: 50,),
                const Row(
                  children:  [
                    Text("Popular Movies",style:  TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                    Spacer(),
                    Text("View All",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey
                    ),)
                  ],
                ),
                SizedBox(height: 20,),
                cubit.popularMovies.isEmpty?
                const Center(child: CircularProgressIndicator())
                    :SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:cubit.popularMovies.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => MovieScreen(movieId: cubit.popularMovies[index].id!),));
                        },
                        child: Stack(
                          children: [
                            Container(
                              child: Image.network("https://image.tmdb.org/t/p/original/${cubit.popularMovies[index].backdropPath!}",fit: BoxFit.cover,),
                              height: 150,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                            ),
                            Positioned(
                              child:
                              Text(cubit.popularMovies[index].title!,style: const TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              left: 10,
                              top: 120,
                            ),
                            Positioned(
                              child: IconButton
                                (
                                onPressed: (){
                                  Movie movie=Movie(id: cubit.popularMovies[index].id!,
                                      title: cubit.popularMovies[index].title!,
                                      overview: cubit.popularMovies[index].overview!,
                                      posterPath: cubit.popularMovies[index].posterPath!,
                                      releaseDate: cubit.popularMovies[index].releaseDate!,
                                      voteAverage: cubit.popularMovies[index].voteAverage!,
                                      voteCount: cubit.popularMovies[index].voteCount!);
                                  FirebaseFunctions.addMovieToFireStore(movie).timeout(Duration(seconds: 3),
                                    onTimeout:() {
                                      print("movie add to watchlist");
                                    },
                                  );
                                },
                                icon: Icon(Icons.add,color: Colors.white,),
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: CircleBorder()
                                ),
                              ),
                              top: 0,
                              right: 4,
                            )
                          ],
                        ),
                      )  ;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
