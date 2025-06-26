import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/dominant_color.dart';
import '../../domain/usecases/analyze_image_colors.dart';

part 'color_analysis_event.dart';
part 'color_analysis_state.dart';

class ColorAnalysisBloc extends Bloc<ColorAnalysisEvent, ColorAnalysisState> {
  final AnalyzeImageColors analyzeImageColors;

  ColorAnalysisBloc({required this.analyzeImageColors})
    : super(ColorAnalysisInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<ClearImageEvent>(_onClearImage);
    on<AnalyzeImageColorsEvent>(_onAnalyzeImageColors);
    on<ResetColorAnalysisEvent>(_onReset);
  }

  void _onSelectImage(
    SelectImageEvent event,
    Emitter<ColorAnalysisState> emit,
  ) {
    emit(ColorAnalysisInitial(selectedImage: event.imageFile));
  }

  void _onClearImage(ClearImageEvent event, Emitter<ColorAnalysisState> emit) {
    emit(ColorAnalysisInitial());
  }

  void _onReset(
    ResetColorAnalysisEvent event,
    Emitter<ColorAnalysisState> emit,
  ) {
    emit(ColorAnalysisInitial());
  }

  Future<void> _onAnalyzeImageColors(
    AnalyzeImageColorsEvent event,
    Emitter<ColorAnalysisState> emit,
  ) async {
    final currentImage = _getCurrentSelectedImage();
    emit(ColorAnalysisLoading(selectedImage: currentImage));
    try {
      final colors = await analyzeImageColors(event.imageFile);
      emit(ColorAnalysisSuccess(colors, selectedImage: currentImage));
    } catch (e) {
      emit(ColorAnalysisFailure(e.toString(), selectedImage: currentImage));
    }
  }

  File? _getCurrentSelectedImage() {
    if (state is ColorAnalysisInitial) {
      return (state as ColorAnalysisInitial).selectedImage;
    } else if (state is ColorAnalysisLoading) {
      return (state as ColorAnalysisLoading).selectedImage;
    } else if (state is ColorAnalysisSuccess) {
      return (state as ColorAnalysisSuccess).selectedImage;
    } else if (state is ColorAnalysisFailure) {
      return (state as ColorAnalysisFailure).selectedImage;
    }
    return null;
  }
}
