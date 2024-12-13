import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episodes_model.dart';
import 'dart:developer';

import 'package:rickandmorty/models/location_model.dart'; // Debugging için

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
      throw Exception(e);
    }
  }

  Future<AllEpisodesModel> getAllEpisodes({ String? url}) async {
    try {
      final response = await _dio.get(url ?? '/episode');
      //log(response.data.toString());
      return AllEpisodesModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EpisodesModel>> getMultipleEpisodes(List list) async {
    try {
      List episodeNumber = list.map((e) => e.split('/').last).toList();
      String episodes = episodeNumber.join(',');
      if (list.length == 1) episodes = '$episodeNumber,';
      final response = await _dio.get('/episode/${episodeNumber.join(',')}');

      if (response.data is List) {
        return (response.data as List)
            .map((e) => EpisodesModel.fromMap(e as Map<String, dynamic>))
            .toList();
      } else if (response.data is Map) {
        return [EpisodesModel.fromMap(response.data as Map<String, dynamic>)];
      } else {
        throw Exception(
            'Unexpected response type: ${response.data.runtimeType}');
      }
    } catch (e, stacktrace) {
      throw Exception(e.toString());
    }
  }

  Future<LocationModel> getAllLocations({String? url}) async {
    try {
      final response = await _dio.get(url ?? '/location');
      return LocationModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getCharactersFromUrlList(List<String> residentsUrl) async {
    final List<int> idList = residentsUrl.map((e) {
      final lastSegment = e.split('/').last;
      // Null veya boş string durumunu kontrol et
      if (lastSegment.isEmpty) {
        throw Exception("Invalid URL format: $e");
      }
      return int.tryParse(lastSegment) ??
          (throw Exception("Invalid ID in URL: $e"));
    }).toList();
    try {
      return await getMultipleCharacters(idList);
    } catch (e) {
      rethrow;
    }
  }
}
