import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/device_info_bloc.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
          builder: (context, state) {
            if (state is DeviceInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DeviceInfoFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DeviceInfoBloc>().add(
                          LoadDeviceInfoEvent(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is DeviceInfoSuccess) {
              final info = state.deviceInfo;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoTile(context, 'Platform', info.platform),
                  _buildInfoTile(context, 'Model', info.model),
                  _buildInfoTile(context, 'OS Version', info.osVersion),
                ],
              );
            }

            // DeviceInfoInitial state
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<DeviceInfoBloc>().add(LoadDeviceInfoEvent());
                },
                child: const Text('Load Device Info'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
