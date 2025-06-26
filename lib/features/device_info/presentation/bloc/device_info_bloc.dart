import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/device_info.dart';
import '../../domain/usecases/get_device_info.dart';

part 'device_info_event.dart';
part 'device_info_state.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final GetDeviceInfo getDeviceInfo;

  DeviceInfoBloc({required this.getDeviceInfo}) : super(DeviceInfoInitial()) {
    on<LoadDeviceInfoEvent>(_onLoadDeviceInfo);
  }

  Future<void> _onLoadDeviceInfo(
    LoadDeviceInfoEvent event,
    Emitter<DeviceInfoState> emit,
  ) async {
    emit(DeviceInfoLoading());

    /// I am simulating a delay here to
    /// show loading state
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading delay
    try {
      final deviceInfo = await getDeviceInfo();
      emit(DeviceInfoSuccess(deviceInfo));
    } catch (e) {
      emit(DeviceInfoFailure(e.toString()));
    }
  }
}
