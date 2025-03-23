import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Bloc/layout_cubit.dart';
import 'package:movies/Bloc/layout_states.dart';


class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text("Movies",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.selectedIndex,
                onTap: (index) {
                  cubit.changeBottomNavIndex(index: index);
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
                  BottomNavigationBarItem(icon: Icon(Icons.movie),label: "Watchlist")
                ]
            ),
            body: cubit.pages[cubit.selectedIndex],
          ) ;
        },
        listener: (context, state) {

        },
    );
  }
}
