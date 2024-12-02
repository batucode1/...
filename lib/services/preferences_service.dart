import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});

  void storeCharacters(List<String> characters) async {
    await prefs.setStringList('characters', characters);
  }

  void saveCharacters(int id) async {
    final characterList = prefs.getStringList('characters') ?? [];
    characterList.add(id.toString());
    storeCharacters(characterList);
  }

  void removeCharacters(int id) async {
    final characterList = prefs.getStringList('characters') ?? [];
    characterList.remove(id.toString());
    storeCharacters(characterList);
  }

  List<int> getSavedCharacters() {
    final characterList = prefs.getStringList('characters') ?? [];
    return characterList.map((e) => int.parse(e)).toList();
  }
}
