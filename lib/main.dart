import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shrig_app/core/theme/theme.dart';
import 'package:shrig_app/service_locator.dart';

import 'features/color_analysis/presentation/bloc/color_analysis_bloc.dart';
import 'features/color_analysis/presentation/pages/color_analysis_page.dart';
import 'features/device_info/presentation/bloc/device_info_bloc.dart';
import 'features/device_info/presentation/pages/device_info_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ColorAnalysisBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Color Analysis App',
        theme: AppTheme.lightTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: const ColorAnalysisPage(),
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.info_outline),
              label: const Text('Device Info'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    /// For better scoping and memory efficiency,
                    /// I am using DeviceInfoBloc here
                    builder: (_) => BlocProvider(
                      create: (context) =>
                          sl<DeviceInfoBloc>()..add(LoadDeviceInfoEvent()),
                      child: const DeviceInfoPage(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
