import 'package:nested/nested.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core.dart';

List<SingleChildWidget> get myProviders {
  return [
    BlocProvider(
      create: (context) =>
          HomeBloc(moviesRemoteDataSource: MoviesRemoteDataSource())
            ..add(GetData()),
    ),
    BlocProvider(
      create: (context) => DetailMovieBloc(
          detailMovieRemoteDataSource: DetailMovieRemoteDataSource()),
    )
  ];
}
