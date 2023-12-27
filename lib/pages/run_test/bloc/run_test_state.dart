part of 'run_test_bloc.dart';

List<Zones> zoneList = [
  Zones(title: "Zone 1", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 2", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 3", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 4", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 5", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 6", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 7", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 8", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 9", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
  Zones(title: "Zone 10", subTitle: "High Shade", image: "https://picsum.photos/200/300")
];

class RunTestState extends Equatable {
  const RunTestState({this.message = '', this.status = LoadStatus.initial, this.isCheckAll = false, this.isRunning = false, this.zoneList = const []});

  final String message;
  final LoadStatus status;
  final bool isCheckAll;
  final bool isRunning;
  final List<Zones> zoneList;

  RunTestState copyWith({
    LoadStatus? status,
    String? message,
    bool? isCheckAll,
    bool? isRunning,
    List<Zones>? zoneList,
  }) {
    return RunTestState(
      status: status ?? this.status,
      message: message ?? this.message,
      isCheckAll: isCheckAll ?? this.isCheckAll,
      isRunning: isRunning ?? this.isRunning,
      zoneList: zoneList ?? this.zoneList,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        isCheckAll,
        isRunning,
        zoneList,
      ];
}
