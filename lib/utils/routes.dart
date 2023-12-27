import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/pages/connect_device/bloc/connect_device_bloc.dart';
import 'package:task/pages/connect_device/connect_device_screen.dart';
import 'package:task/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:task/pages/dashboard/dashboard_screen.dart';
import 'package:task/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:task/pages/forgot_password/forgot_passwod_screen.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/pages/login/login_screen.dart';
import 'package:task/pages/on_boarding/on_boarding_screen.dart';
import 'package:task/pages/register/bloc/register_bloc.dart';
import 'package:task/pages/register/register_screen.dart';
import 'package:task/pages/reset_password/bloc/reset_password_bloc.dart';
import 'package:task/pages/reset_password/reset_password_screen.dart';
import 'package:task/pages/run_test/bloc/run_test_bloc.dart';
import 'package:task/pages/run_test/run_test_screen.dart';
import 'package:task/pages/scan_qr_code/bloc/scan_qr_code_bloc.dart';
import 'package:task/pages/scan_qr_code/scan_qr_code_screen.dart';
import 'package:task/pages/splash/bloc/splash_bloc.dart';
import 'package:task/pages/splash/splash_screen.dart';

const routeSplash = '/splash';
const routeLogin = '/login';
const routeRegister = '/register';
const routeForgotPassword = '/forgot_password';
const routeResetPassword = '/reset_password';
const routeOnBoarding = '/on_boarding';
const routeScanQRCode = '/scan_qr_code';
const routeConnectDevice = '/connect_device';
const routeDashboard = '/dashboard';
const routeRunTest = '/run_test';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => SplashBloc()..add(const SplashInitEvent()),
                  child: const SplashScreen(),
                ));
      case routeOnBoarding:
        return MaterialPageRoute(settings: settings, builder: (context) => const OnBoardingScreen());
      case routeLogin:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => LoginBloc(),
                  child: LoginScreen(),
                ));
      case routeRegister:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => RegisterBloc(),
                  child: RegisterScreen(),
                ));
      case routeForgotPassword:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => ForgotPasswordBloc(),
                  child: ForgotPasswordScreen(),
                ));
      case routeResetPassword:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => ResetPasswordBloc(),
                  child: ResetPasswordScreen(),
                ));
      case routeScanQRCode:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => ScanQRCodeBloc(),
                  child: const ScanQRCodeScreen(),
                ));
      case routeConnectDevice:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => ConnectDeviceBloc(),
                  child: const ConnectDeviceScreen(),
                ));
      case routeDashboard:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => DashboardBloc(),
                  child: const DashBordScreen(),
                ));
      case routeRunTest:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (create) => RunTestBloc(),
                  child: const RunTestScreen(),
                ));
    }
  }
}
