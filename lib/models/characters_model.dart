class CharactersModel {
  final CharacterInfo info;
  final List<CharacterModel> characters;
  CharactersModel(
      {required this.info, required this.characters}); //I combined other models

  factory CharactersModel.fromJson(
      Map<String, dynamic> json) //if constructor return itself . it's factory
  {
    final info = CharacterInfo.fromJson(json['info']);
    final characters = (json['results'] as List)
        .map((char) => CharacterModel.fromJson(char))
        .toList();
    return CharactersModel(info: info, characters: characters);
  }
}

class CharacterInfo {
  final String count;
  final String pages;
  final String? next;
  final String? prev;

  CharacterInfo(
      {required this.count,
      required this.pages,
      required this.next,
      required this.prev});

  CharacterInfo.fromJson(Map<String, dynamic> json) //json to dart
      : count = json['count'],
        pages = json['pages'],
        next = json['next'],
        prev = json['prev'];
}

class CharacterModel {
  final String id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location location;
  final List<String> episode;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.episode,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) //json to dart
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        species = json['species'],
        gender = json['gender'],
        image = json['image'],
        location = Location.fromJson(json['location']),
        episode = List<String>.from(json['episode']);
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  Location.fromJson(Map<String, dynamic> json) //json to dart
      : name = json['name'],
        url = json['url'];
}
