import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRemoteDataSource moviesRemoteDataSource;

  HomeBloc({required this.moviesRemoteDataSource}) : super(HomeInitial()) {
    on<GetData>((event, emit) async {
      emit(DataLoading());
      try {
        final data = await moviesRemoteDataSource.getDataMovies();
        emit(DataLoaded(movieList: data.results));
      } on Exception catch (e) {
        emit(DataError(message: e.toString()));
      }
    });
  }
}
