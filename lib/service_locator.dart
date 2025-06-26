import 'package:get_it/get_it.dart';
import 'features/color_analysis/data/datasources/color_analysis_data_source.dart';
import 'features/color_analysis/data/repositories/color_analysis_repository_impl.dart';
import 'features/color_analysis/domain/repositories/color_analysis_repository.dart';
import 'features/color_analysis/domain/usecases/analyze_image_colors.dart';
import 'features/color_analysis/presentation/bloc/color_analysis_bloc.dart';
import 'features/device_info/data/datasources/device_info_data_source.dart';
import 'features/device_info/data/repositories/device_info_repository_impl.dart';
import 'features/device_info/domain/repositories/device_info_repository.dart';
import 'features/device_info/domain/usecases/get_device_info.dart';
import 'features/device_info/presentation/bloc/device_info_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Color Analysis Feature
  // Data
  sl.registerLazySingleton<ColorAnalysisDataSource>(
    () => ColorAnalysisDataSourceImpl(),
  );

  // Domain
  sl.registerLazySingleton<ColorAnalysisRepository>(
    () => ColorAnalysisRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<AnalyzeImageColors>(() => AnalyzeImageColors(sl()));

  // Presentation
  sl.registerFactory(() => ColorAnalysisBloc(analyzeImageColors: sl()));

  // Device Info Feature
  // Data
  sl.registerLazySingleton<DeviceInfoDataSource>(
    () => DeviceInfoDataSourceImpl(),
  );

  // Domain
  sl.registerLazySingleton<DeviceInfoRepository>(
    () => DeviceInfoRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<GetDeviceInfo>(() => GetDeviceInfo(sl()));

  // Presentation
  sl.registerFactory(() => DeviceInfoBloc(getDeviceInfo: sl()));
}
