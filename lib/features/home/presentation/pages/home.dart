import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hiro Movies"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.movieList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final image = state.imagePath;
                  final data = state.movieList[index];
                  return GridTile(
                    child: Image.network(
                      image + data.posterPath,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            } else if (state is DataError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No Data!'),
              );
            }
          },
        ));
  }
}
