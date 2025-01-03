import 'package:assignment_app/features/fetch_data/bloc/photo_bloc.dart';
import 'package:assignment_app/features/home/bloc/home_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

class Global {
  static Future<void> init() async {
    _initHttpClient();
    _initFetchPhoto();
    _initHomePage();
  }
}

void _initHttpClient() {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
}

void _initFetchPhoto() {
  getIt.registerLazySingleton(() => PhotoBloc());
}

void _initHomePage() {
  getIt.registerLazySingleton(() => HomePageBloc());
}
