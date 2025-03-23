import 'package:flutter/material.dart';
import 'package:movies/firebase/firebse_functions.dart';
import 'package:movies/models/movie.dart';

class MovieItem extends StatelessWidget {
  Movie movie;
   MovieItem({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Image.network("https://image.tmdb.org/t/p/w500/${movie.posterPath}",fit: BoxFit.cover,),
      title: Row(
        children: [
          Expanded(
            child: Text(movie.title,overflow: TextOverflow.ellipsis,style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
            ),),
          ),
          Spacer(),
          IconButton(onPressed: (){
            FirebaseFunctions.deleteMovie(movie.id as String);
          },
              icon: Icon(Icons.delete,color: Colors.red,))
        ],
      ),
      subtitle: Text(movie.overview,textAlign: TextAlign.justify,maxLines: 4,
        style: TextStyle(
          fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey
      ),),

    ) ;
  }
}
