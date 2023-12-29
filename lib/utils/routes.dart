import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/api_service/repository.dart';
import 'package:task/pages/detailpage/bloc/detailpage_bloc.dart';
import 'package:task/pages/detailpage/detailpage_view.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/pages/home/home_screen.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/pages/login/login_screen.dart';

const routeLogin = '/login';
const routeHome = '/home';
const routeDetailPage = '/detailpage';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeLogin:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => LoginBloc(apiRepository: ApiRepository()),
                  child: LoginScreen(),
                ));
      case routeHome:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => HomeBloc()..add(HomeInitEvent()),
                  child: HomeScreen(),
                ));
      case routeDetailPage:
       final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) =>
                      DetailpageBloc()..add(DetailPageInitEvent(arg)),
                  child: DetailpageView(),
                ));
    }
  }
}
