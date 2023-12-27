import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/pages/home/home_screen.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/pages/login/login_screen.dart';
import 'package:task/pages/splash/bloc/splash_bloc.dart';
import 'package:task/pages/splash/splash_screen.dart';

const routeSplash = '/splash';
const routeLogin = '/login';
const routeHome = '/home';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) =>
                      SplashBloc()..add(const SplashInitEvent()),
                  child: const SplashScreen(),
                ));
      case routeLogin:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => LoginBloc(),
                  child: LoginScreen(),
                ));
      case routeHome:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => HomeBloc(),
                  child: HomeScreen(),
                ));
    }
  }
}
