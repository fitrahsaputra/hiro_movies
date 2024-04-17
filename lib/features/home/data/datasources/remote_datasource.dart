// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

import '../../../../core.dart';

class MoviesRemoteDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/movie',
    headers: {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkY2JmOWI0MDRlOWI4NmViNDA0ODA2ZjhhZTU0M2FmOSIsInN1YiI6IjY1ODI1MDE5MmY4ZDA5MDhmNGE4ZTAwYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.z6kVMiG2tqeaRwvmzYar8QSXImLCi_8IM_b5hB-DIvg',
    },
  ));

  Future<MoviesModel> getDataMovies() async {
    final response = await dio.get('/now_playing');
    try {
      if (response.statusCode == HttpStatus.ok) {
        print('Berhasil get data');
        return MoviesModel.fromJson(response.data);
      } else {
        print('Gagal get data');
        throw Exception('Failed to get data ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
