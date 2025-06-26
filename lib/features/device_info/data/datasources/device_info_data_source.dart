import 'package:flutter/services.dart';
import '../models/device_info_model.dart';

abstract class DeviceInfoDataSource {
  Future<DeviceInfoModel> getDeviceInfo();
}

class DeviceInfoDataSourceImpl implements DeviceInfoDataSource {
  static const MethodChannel _channel = MethodChannel(
    'com.np.shishirrijal/device_info',
  );

  @override
  Future<DeviceInfoModel> getDeviceInfo() async {
    try {
      final info = await _channel.invokeMethod<Map>('getDeviceInfo');
      return DeviceInfoModel.fromNative(Map<String, dynamic>.from(info ?? {}));
    } catch (e) {
      // Return default info if platform channel fails
      throw Exception(
        'Failed to get device info. Please check the platform channel implementation.',
      );
    }
  }
}
