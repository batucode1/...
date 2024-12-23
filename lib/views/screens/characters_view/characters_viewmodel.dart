import 'package:flutter/material.dart';
import 'package:rickandmorty/app/getit.dart';
import '../../../services/api_service.dart';
import '../../../models/characters_model.dart';

enum CharacterType { all, alive, dead, unknown }

class CharactersViewModel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();

  CharacterType characterType = CharacterType.all;

  CharactersModel? charactersModel;
  CharactersModel? get characters => charactersModel;
  void getCharacters() async {
    charactersModel = await _apiServices.getCharacters();
    notifyListeners();
    print('geldi');
  }

  bool isLoading = false;
  int currentPageIndex = 1;

  void getCharactersMore() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    if (charactersModel!.info.pages == currentPageIndex) return;

    final data =
        await _apiServices.getCharacters(url: charactersModel?.info.next);
    isLoading = false;
    currentPageIndex++;
    charactersModel!.info = data.info;
    charactersModel!.characters.addAll(data.characters);
    notifyListeners();
  }

  void charactersClear() {
    charactersModel = null;
    notifyListeners();
    currentPageIndex = 0;
  }

  void getCharactersByName(String name) async {
    charactersClear();
    charactersModel = await _apiServices.getCharacters(args: {'name': name});
    notifyListeners();
  }

  void getCharactersByStatus(CharacterType status) async {
    characterType = status;
    charactersClear();
    Map<String, dynamic>? args = {};
    if (status != CharacterType.all) {
      args = {'status': status.name};
    }
    charactersModel = await _apiServices.getCharacters(args: args);
    notifyListeners();
  }
}
