import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/models/movie.dart';

class FirebaseFunctions{
  static CollectionReference<Movie> getTaskCollection(){
    return FirebaseFirestore.instance.collection("Tasks")
        .withConverter<Movie>(
      fromFirestore: (snapshot, options) => Movie.fromJson(snapshot.data()!),
      toFirestore: (movie, options) => movie.toJson(),);
  }

  static Future<void> addMovieToFireStore(Movie movie){
    var collection =getTaskCollection();
    var docRef = collection.doc();
    movie.id!=docRef.id;
    return docRef.set(movie);
  }

  Stream<QuerySnapshot<Movie>> getMovies(){
    var collection = getTaskCollection();
    return collection.snapshots();
  }

  static Future<void> deleteMovie(String id){
    return getTaskCollection().doc(id).delete();
  }


}