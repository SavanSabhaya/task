import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/storage_key_constants.dart';
import 'package:task/common/widgets/wrap_screen_utils.dart';
import 'package:task/reponseModel/login_model.dart';
import 'package:task/utils/cubit/ConnectionCheckerCubit.dart';
import 'package:task/utils/cubit/internet_cubit.dart';
import 'package:task/utils/routes.dart';
import 'package:task/utils/shared_preferences.dart';

final sl = GetIt.instance;
final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

void main(main) {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

  configLoading();
  Bloc.observer = AppBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var preferences = MySharedPref();
  LoginModel? loginModel;

  @override
  void initState() {
    super.initState();
    ischeckLogin();
  }

 void ischeckLogin() async {
  var result = await preferences.getLoginModel(StorageKeyConstants.cKeyIsToken);
  setState(() {
    loginModel = result;
  });
}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: const Color(0x66005975).withOpacity(0.15),
        statusBarBrightness:
            Platform.isAndroid ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCheckerCubit>(
          create: (_) => ConnectionCheckerCubit(
              internetConnectionChecker: InternetConnectionChecker()),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: Connectivity()),
        ),
      ],
      child: FutureBuilder(
          future: sl.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MaterialApp(
                theme: ThemeData(
                  pageTransitionsTheme: const PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  }),
                ),
                debugShowCheckedModeBanner: false,
                navigatorKey: navState,
                themeMode: ThemeMode.light,
                initialRoute: loginModel == null ? routeLogin : routeHome,
                onGenerateRoute: Routes.onGenerateRoute,
                showPerformanceOverlay: false,
                scrollBehavior:
                    const ScrollBehavior().copyWith(scrollbars: false),
                builder: (context, widget) {
                  widget = WrapScreenUtils(child: widget ?? const Offstage());
                  widget = EasyLoading.init()(context, widget);
                  return widget;
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget =
        CircularProgressIndicator(color: ColorConstants.primaryColor)
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorConstants.whiteColor
    ..backgroundColor = ColorConstants.backgroundColor
    ..indicatorColor = ColorConstants.whiteColor
    ..textColor = ColorConstants.whiteColor
    ..maskColor = Colors.deepOrange.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = true;
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    /* if (change.nextState is InternetConnectionDisconnected) {
      showErrorSnackBar(navState.currentContext!, msgCheckConnection);
    } else if(change.nextState is InternetConnectionConnected){
      showSuccessSnackBar(navState.currentContext!, msgInternetConnected);
    }*/

    log('onChange: ${bloc.runtimeType}, ${bloc.state} \nCurrent state: ${change.currentState}\nNext state: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, ${bloc.state}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('onEvent(${bloc.state}, ${bloc.runtimeType}, $event)');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition(${bloc.state}, ${bloc.runtimeType}, ${transition.currentState}, ${transition.nextState})');
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate(${bloc.state}, ${bloc.runtimeType})');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log('onTransition(${bloc.state}, ${bloc.runtimeType})');
    super.onClose(bloc);
  }
}
