part of 'device_info_bloc.dart';

abstract class DeviceInfoState {}

class DeviceInfoInitial extends DeviceInfoState {}

class DeviceInfoLoading extends DeviceInfoState {}

class DeviceInfoSuccess extends DeviceInfoState {
  final DeviceInfo deviceInfo;

  DeviceInfoSuccess(this.deviceInfo);
}

class DeviceInfoFailure extends DeviceInfoState {
  final String message;

  DeviceInfoFailure(this.message);
}
