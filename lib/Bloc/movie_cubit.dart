import 'package:bloc/bloc.dart';
import 'package:movies/Bloc/movie_states.dart';
import 'package:movies/models/movie_repo.dart';


class MovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  MovieCubit(this.movieRepository) : super(MovieInitial());

  void fetchMovie(int movieId) async {
    try {
      emit(MovieLoading());
      final movie = await movieRepository.getMovieDetails(movieId);
      emit(MovieLoaded(movie));
    } catch (e) {
      emit(MovieError("Failed to load movie: ${e.toString()}"));
    }
  }

  void searchMovie(String title)async{
    emit(MovieSearchLoading());
    try{
      final movies= await movieRepository.searchMovies(title);
      emit(MovieSearchLoaded(movies: movies));
    }
    catch(e){
      emit(MovieSearchError(e.toString()));
    }
  }



}
