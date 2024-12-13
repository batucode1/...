// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rickandmorty/models/info_model.dart';

class AllEpisodesModel {
  InfoModel info;
  List<EpisodesModel> episodes;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'episode': episodes.map((x) => x.toMap()).toList(),
    };
  }

  factory AllEpisodesModel.fromMap(Map<String, dynamic> map) {
    return AllEpisodesModel(
      info: InfoModel.fromMap(map['info'] as Map<String, dynamic>),
      // 'results' alanını kullan
      episodes: List<EpisodesModel>.from(
        (map['results'] as List).map<EpisodesModel>(
          (x) => EpisodesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllEpisodesModel.fromJson(String source) =>
      AllEpisodesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AllEpisodesModel({required this.info, required this.episodes});
}

class EpisodesModel {
  final int id;
  final String name;
  final String episode;
  final List<String> characters;
  final String url;

  EpisodesModel({
    required this.id,
    required this.name,
    required this.episode,
    required this.characters,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'episode': episode,
      'characters': characters,
      'url': url,
    };
  }

  factory EpisodesModel.fromMap(Map<String, dynamic> map) {
    final episodeString = map['episode'] as String;
    final episodeList = episodeString.replaceAll('S', '').split('E');
    return EpisodesModel(
      id: map['id'] as int,
      name: map['name'] as String,
      episode:
          'Sezon ${int.parse(episodeList.first)} Bölüm ${episodeList.last}',
      characters: List<String>.from(
        (map['characters'] as List),
      ),
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodesModel.fromJson(String source) =>
      EpisodesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
