// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core.dart';

class MoviesRemoteDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'].toString(),
    headers: {
      'accept': 'application/json',
      'Authorization': dotenv.env['API_KEY'].toString(),
    },
  ));

  Future<MoviesModel> getDataMovies() async {
    final response = await dio.get('/now_playing');
    try {
      if (response.statusCode == HttpStatus.ok) {
        print('Berhasil get data movie now playing');
        return MoviesModel.fromJson(response.data);
      } else {
        print('Gagal get data movie now playing');
        throw Exception(
            'Failed to get data. Response status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<MoviesModel> getDataMoviesUpComing() async {
    final response = await dio.get('/upcoming');
    try {
      if (response.statusCode == HttpStatus.ok) {
        print('Berhasil get data movie upcoming');
        return MoviesModel.fromJson(response.data);
      } else {
        print('Gagal get data movie upcoming');
        throw Exception(
            'Failed to get data. Response status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
