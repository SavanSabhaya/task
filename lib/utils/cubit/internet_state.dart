
import 'package:task/utils/cubit/internet_cubit.dart';

abstract class InternetConnectionTypeState {}

class InternetConnectionTypeLoading extends InternetConnectionTypeState {}

class InternetConnectionType extends InternetConnectionTypeState {
  final InternetState? connectionType;

  InternetConnectionType({required this.connectionType});
}
