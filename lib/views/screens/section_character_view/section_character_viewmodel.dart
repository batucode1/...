import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episodes_model.dart';

import '../../../app/getit.dart';
import '../../../models/characters_model.dart';
import '../../../services/api_service.dart';

class SectionCharacterViewmodel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();
  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  void getCharacters(EpisodesModel episode) async {
    _characters =
        await _apiServices.getCharactersFromUrlList(episode.characters);
    notifyListeners();
  }
}
