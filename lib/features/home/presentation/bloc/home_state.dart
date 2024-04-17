part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class DataLoading extends HomeState {}

class DataLoaded extends HomeState {
  final List<Result> movieList;
  final String imagePath = 'https://image.tmdb.org/t/p/w500';

  const DataLoaded({required this.movieList});
}

class DataError extends HomeState {
  final String message;

  const DataError({required this.message});
}
