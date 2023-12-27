import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:task/api_service/dio_client.dart';
import 'package:task/utils/shared_preferences.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerLazySingleton<SharePref>(() => SharePref().init());

  getIt.registerLazySingleton<DioClient>(() => DioClient().init());

  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dioClient: getIt()));
}