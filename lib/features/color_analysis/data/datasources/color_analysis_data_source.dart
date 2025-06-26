import 'dart:io';
import 'dart:isolate';
import '../models/dominant_color_model.dart';

abstract class ColorAnalysisDataSource {
  Future<List<DominantColorModel>> analyzeImageColors(File imageFile);
}

class ColorAnalysisDataSourceImpl implements ColorAnalysisDataSource {
  @override
  Future<List<DominantColorModel>> analyzeImageColors(File imageFile) async {
    // Let's process image in isolate to simulate AI work
    final result = await _processImageInIsolate(imageFile.path);
    return result;
  }

  Future<List<DominantColorModel>> _processImageInIsolate(
    String imagePath,
  ) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_isolateFunction, {
      'sendPort': receivePort.sendPort,
      'imagePath': imagePath,
    });

    final result = await receivePort.first as List<DominantColorModel>;
    return result;
  }

  static void _isolateFunction(Map<String, dynamic> params) {
    final sendPort = params['sendPort'] as SendPort;
    final imagePath = params['imagePath'] as String;

    // We are simulating AI processing with a 2-second delay
    Future.delayed(const Duration(seconds: 2), () {
      // Now, let's return mock dominant colors
      final colors = [
        const DominantColorModel(color: '#FF6B6B', percentage: 35.0),
        const DominantColorModel(color: '#4ECDC4', percentage: 25.0),
        const DominantColorModel(color: '#45B7D1', percentage: 20.0),
        const DominantColorModel(color: '#96CEB4', percentage: 15.0),
        const DominantColorModel(color: '#FFEAA7', percentage: 5.0),
      ];
      sendPort.send(colors);
    });
  }
}
