import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_beauties/application/home/repository/categories_repository.dart';
import 'package:wonder_beauties/core/data/new_remote/network_service.dart';

import 'core/app_store/app_store.dart';
import 'core/data/local_data/local_data_source.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  /// data sources
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final AppStore appStore = AppStore();

  ///core
  ///  getIt
      getIt.registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImpl(getIt()));

  getIt.registerLazySingleton<NetworkService>(() => DioNetworkService());

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceSharedPreferences(getIt()));

  getIt.registerLazySingleton<AppStore>(() => appStore);
}
