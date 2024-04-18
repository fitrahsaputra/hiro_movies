part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieLoaded extends DetailMovieState {
  final DetailMovieModel listMovieDetail;

  const DetailMovieLoaded({required this.listMovieDetail});
}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError({required this.message});
}
