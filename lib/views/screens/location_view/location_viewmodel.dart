import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location_model.dart';
import '../../../app/getit.dart';
import '../../../services/api_service.dart';

class LocationViewmodel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();
  LocationModel? _locationModel;
  LocationModel? get locationModel => _locationModel;
  void getLocations() async {
    _locationModel = await _apiServices.getAllLocations();
    notifyListeners();
  }

  bool loadMore = false;
  void setLoading(bool value) {
    loadMore = value;
    notifyListeners();
  }

  int page = 1;
  void getMoreLocations() async {
    if (loadMore && page == _locationModel!.info.pages) return;
    setLoading(true);
    final data =
        await _apiServices.getAllLocations(url: _locationModel!.info.next);
    page++;
    locationModel!.info = data.info;
    locationModel!.locations.addAll(data.locations);
    setLoading(false);
    notifyListeners();
  }
}
