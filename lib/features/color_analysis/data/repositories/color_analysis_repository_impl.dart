import 'dart:io';
import '../../domain/entities/dominant_color.dart';
import '../../domain/repositories/color_analysis_repository.dart';
import '../datasources/color_analysis_data_source.dart';

class ColorAnalysisRepositoryImpl implements ColorAnalysisRepository {
  final ColorAnalysisDataSource dataSource;

  ColorAnalysisRepositoryImpl({required this.dataSource});

  @override
  Future<List<DominantColor>> analyzeImageColors(File imageFile) async {
    return await dataSource.analyzeImageColors(imageFile);
  }
}
