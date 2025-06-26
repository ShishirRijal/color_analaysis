import 'dart:io';

import '../entities/dominant_color.dart';

abstract class ColorAnalysisRepository {
  Future<List<DominantColor>> analyzeImageColors(File imageFile);
}
