part of 'color_analysis_bloc.dart';

abstract class ColorAnalysisState {}

class ColorAnalysisInitial extends ColorAnalysisState {
  final File? selectedImage;

  ColorAnalysisInitial({this.selectedImage});
}

class ColorAnalysisLoading extends ColorAnalysisState {
  final File? selectedImage;

  ColorAnalysisLoading({this.selectedImage});
}

class ColorAnalysisSuccess extends ColorAnalysisState {
  final List<DominantColor> colors;
  final File? selectedImage;

  ColorAnalysisSuccess(this.colors, {this.selectedImage});
}

class ColorAnalysisFailure extends ColorAnalysisState {
  final String message;
  final File? selectedImage;

  ColorAnalysisFailure(this.message, {this.selectedImage});
}
