import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

class ApiServices {
  final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  Future<CharactersModel> getCharacters(
      {String? url, Map<String, dynamic>? args}) async {
    try {
      final response = await _dio.get(
        url ?? '/character',
        queryParameters: args,
      );
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CharacterModel>> getMultipleCharacters(List<int> ids) async {
    try {
      final response = await _dio.get('/character/${ids.join(',')}');
      return (response.data as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
