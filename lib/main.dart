import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Bloc/layout_cubit.dart';
import 'package:movies/Bloc/movie_cubit.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/models/movie_repo.dart';
import 'package:movies/screens/layout.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()..getUpComingMovies()..getTopRatedMovies()..getPopularMovies(),),
        BlocProvider(create: (context) => MovieCubit(MovieRepository()),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold
          ),
          type: BottomNavigationBarType.fixed
      )
      ),
        home: Layout(),
      ),
    );
  }
}
