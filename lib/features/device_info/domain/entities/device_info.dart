import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  final String platform;
  final String model;
  final String osVersion;

  const DeviceInfo({
    required this.platform,
    required this.model,
    required this.osVersion,
  });

  @override
  List<Object?> get props => [platform, model, osVersion];
}
