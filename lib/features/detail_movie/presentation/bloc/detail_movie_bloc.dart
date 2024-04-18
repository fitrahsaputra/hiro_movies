import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final DetailMovieRemoteDataSource detailMovieRemoteDataSource;
  DetailMovieBloc({required this.detailMovieRemoteDataSource})
      : super(DetailMovieInitial()) {
    on<GetDataMovieById>((event, emit) async {
      emit(DetailMovieLoading());
      try {
        final data =
            await detailMovieRemoteDataSource.getDataMovieById(event.id);
        emit(DetailMovieLoaded(listMovieDetail: data));
      } on Exception catch (e) {
        emit(DetailMovieError(message: e.toString()));
      }
    });
  }
}
