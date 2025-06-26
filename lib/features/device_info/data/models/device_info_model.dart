import '../../domain/entities/device_info.dart';

class DeviceInfoModel extends DeviceInfo {
  const DeviceInfoModel({
    required super.platform,
    required super.model,
    required super.osVersion,
  });

  factory DeviceInfoModel.fromNative(Map<String, dynamic> data) {
    return DeviceInfoModel(
      platform: data['platform'] as String? ?? 'Unknown',
      model: data['model'] as String? ?? 'Unknown',
      osVersion: data['osVersion'] as String? ?? 'Unknown',
    );
  }
}
