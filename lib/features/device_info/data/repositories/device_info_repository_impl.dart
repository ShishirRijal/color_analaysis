import '../../domain/repositories/device_info_repository.dart';
import '../datasources/device_info_data_source.dart';
import '../models/device_info_model.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoDataSource dataSource;

  DeviceInfoRepositoryImpl({required this.dataSource});

  @override
  Future<DeviceInfoModel> getDeviceInfo() async {
    return await dataSource.getDeviceInfo();
  }
}
