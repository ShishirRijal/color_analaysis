import 'dart:io';
import '../entities/dominant_color.dart';
import '../repositories/color_analysis_repository.dart';

class AnalyzeImageColors {
  final ColorAnalysisRepository repository;

  AnalyzeImageColors(this.repository);

  Future<List<DominantColor>> call(File imageFile) async {
    return await repository.analyzeImageColors(imageFile);
  }
}
