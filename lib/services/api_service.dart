import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episodes_model.dart';
import 'dart:developer'; // Debugging için

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

  Future<List<EpisodesModel>> getMultipleEpisodes(List<String> list) async {
    try {
      // URL'den bölüm numaralarını alıyoruz
      final List<String> episodeNumber =
          list.map((e) => e.split('/').last).toList();

      // API'ye istek yapıyoruz
      final response = await _dio.get('/episode/${episodeNumber.join(',')}');

      // API yanıtını logluyoruz
      log('Response data: ${response.data}');

      // Yanıtın tipini kontrol ediyoruz: Liste mi, tek bir bölüm mü?
      if (response.data is List) {
        // Eğer yanıt bir List ise, her bir öğeyi EpisodesModel'e dönüştürüyoruz
        return (response.data as List)
            .map((e) => EpisodesModel.fromMap(
                e as Map<String, dynamic>)) // Burada Map yapısına cast ediyoruz
            .toList();
      } else if (response.data is Map) {
        // Eğer yanıt tek bir Map ise, sadece bir bölüm döndü demektir
        return [EpisodesModel.fromMap(response.data as Map<String, dynamic>)];
      } else {
        throw Exception(
            'Unexpected response type: ${response.data.runtimeType}');
      }
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
      throw Exception(e.toString());
    }
  }
}
