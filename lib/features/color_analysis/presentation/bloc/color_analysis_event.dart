part of 'color_analysis_bloc.dart';

abstract class ColorAnalysisEvent {}

class SelectImageEvent extends ColorAnalysisEvent {
  final File imageFile;

  SelectImageEvent({required this.imageFile});
}

class ClearImageEvent extends ColorAnalysisEvent {}

class AnalyzeImageColorsEvent extends ColorAnalysisEvent {
  final File imageFile;

  AnalyzeImageColorsEvent({required this.imageFile});
}

class ResetColorAnalysisEvent extends ColorAnalysisEvent {}
