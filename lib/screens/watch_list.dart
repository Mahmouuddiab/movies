import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/firebase/firebse_functions.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movie_item.dart';
class WishlistScreen extends StatelessWidget {
  List<Movie>movies=[];
  @override
  Widget build(BuildContext context) {
    if(movies.isEmpty){
      getMovies();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieItem(movie: movies[index]) ;
                  },
              ),
          ),
        ],
      ),
    );
  }
 void getMovies()async{
    QuerySnapshot<Movie> querySnapshot= await FirebaseFunctions.getTaskCollection().get();
    movies=querySnapshot.docs.map((doc){
      return doc.data() ;
    }).toList();
  }
}

