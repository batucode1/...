import 'package:flutter/material.dart';
import 'package:rickandmorty/app/getit.dart';
import 'package:rickandmorty/models/characters_model.dart';

import '../../../services/api_service.dart';

class ResidentViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiServices>();
  List<CharacterModel> _residents = [];
  List<CharacterModel> get residents => _residents;

  void getAllResidents(List residentsUrlList) async {
    _residents = await _apiService
        .getCharactersFromUrlList(residentsUrlList.map((e) => e.toString()).toList());
    notifyListeners();
  }
}
