import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:task/di/injection_container.config.dart';

GetIt getIt = GetIt.instance;

@injectableInit
Future<GetIt> configure() async => getIt.init();
