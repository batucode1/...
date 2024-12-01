import 'package:flutter/material.dart';
import 'package:rickandmorty/app/getit.dart';
import '../../../services/api_services.dart';
import '../../../models/characters_model.dart';

class CharactersViewModel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();

  CharactersModel? charactersModel;
  CharactersModel? get characters => charactersModel;
  void getCharacters() async {
    charactersModel = await _apiServices.getCharacters();
    notifyListeners();
    print('geldi');
  }
}
