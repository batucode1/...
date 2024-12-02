import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_service.dart';
import 'package:rickandmorty/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;
Future<void> setupLocator()
//dependency injection //sınıfların içindeki fonksiyonları çağırırken her sınıfı tekrar oluşturmayı engeller ve sadece bir kere oluşturulur
//örnek kullanım: locator<ApiServices>().getCharacters();
//mainde çağırılır//get it paketinin avantajı
async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesService>(
      () => PreferencesService(prefs: prefs));
  locator.registerLazySingleton<ApiServices>(() => ApiServices());
}
