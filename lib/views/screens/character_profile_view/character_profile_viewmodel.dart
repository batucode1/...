import 'package:flutter/material.dart';
import 'package:rickandmorty/app/getit.dart';
import 'package:rickandmorty/models/episodes_model.dart';

import '../../../services/api_service.dart';

class CharacterProfileViewmodel extends ChangeNotifier {
  final _apiServive = locator<ApiServices>();
  List<EpisodesModel> _episodes = [];
  List<EpisodesModel> get episodes => _episodes;
  void getEpisodes(List<String> urlList) async {
    _episodes = await _apiServive.getMultipleEpisodes(urlList);
    notifyListeners();
  }
}
