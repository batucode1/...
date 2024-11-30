import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_services.dart';

final locator = GetIt.instance;
void
    setupLocator() //dependency injection //sınıfların içindeki fonksiyonları çağırırken her sınıfı tekrar oluşturmayı engeller ve sadece bir kere oluşturulur
//örnek kullanım: locator<ApiServices>().getCharacters();
//mainde çağırılır//get it paketinin avantajı
{
  locator.registerLazySingleton<ApiServices>(() => ApiServices());
}
