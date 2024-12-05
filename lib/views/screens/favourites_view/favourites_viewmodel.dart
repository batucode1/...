import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characters_model.dart';

import '../../../app/getit.dart';
import '../../../services/api_service.dart';
import '../../../services/preferences_service.dart';

class FavouritesViewmodel extends ChangeNotifier {
  final _preferencesService = locator<PreferencesService>();
  final _apiServices = locator<ApiServices>();
  List<CharacterModel>? charactersList;
  List<CharacterModel>? get charactersModel => charactersList;
  List<int> _favoritedList = [];
  void getFavourites() {
    _favoritedList = _preferencesService.getSavedCharacters();
    _getCharacters();
  }

  void _getCharacters() async {
    charactersList = await _apiServices.getMultipleCharacters(_favoritedList);
    notifyListeners();
  }
}
