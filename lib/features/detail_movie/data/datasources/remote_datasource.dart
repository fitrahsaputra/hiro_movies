// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core.dart';

class DetailMovieRemoteDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'].toString(),
    headers: {
      'accept': 'application/json',
      'Authorization': dotenv.env['API_KEY'].toString(),
    },
  ));

  Future<DetailMovieModel> getDataMovieById(int id) async {
    final response = await dio.get('/$id');
    try {
      if (response.statusCode == HttpStatus.ok) {
        print('Berhasil get data by id');
        return DetailMovieModel.fromJson(response.data);
      } else {
        print('Gagal get data by id');
        throw Exception(
            'Failed to get data by id. Response status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
