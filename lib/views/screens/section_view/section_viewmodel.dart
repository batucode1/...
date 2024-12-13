import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episodes_model.dart';

import '../../../app/getit.dart';
import '../../../services/api_service.dart';

class SectionViewmodel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();
  AllEpisodesModel? _allEpisodesModel;
  AllEpisodesModel? get allEpisodesModel => _allEpisodesModel;
  void getAllEpisodes() async {
    _allEpisodesModel = (await _apiServices.getAllEpisodes());
    notifyListeners();
  }
int page=1;
  bool loadMore = false;
  void setLoadMore(bool value) {
    loadMore = !loadMore;
    notifyListeners();
  }

  void getMoreEpisodes() async {
    if (loadMore && page == _allEpisodesModel!.info.pages) return;
    setLoadMore(true);
    final data =
        await _apiServices.getAllEpisodes(url: _allEpisodesModel!.info.next);
    _allEpisodesModel!.info = data.info;
    _allEpisodesModel!.episodes.addAll(data.episodes);
    page++;
    setLoadMore(false);
  }
}
