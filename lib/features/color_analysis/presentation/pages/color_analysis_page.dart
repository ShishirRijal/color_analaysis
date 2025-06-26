import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/color_analysis_bloc.dart';
import '../widgets/dominant_color_card.dart';
import '../../../../core/theme/theme.dart';

class ColorAnalysisPage extends StatelessWidget {
  const ColorAnalysisPage({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final bloc = context.read<ColorAnalysisBloc>();
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      bloc.add(SelectImageEvent(imageFile: File(picked.path)));
    }
  }

  void _analyze(BuildContext context, File imageFile) {
    context.read<ColorAnalysisBloc>().add(
      AnalyzeImageColorsEvent(imageFile: imageFile),
    );
  }

  void _showImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ColorAnalysisBloc>().add(ResetColorAnalysisEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<ColorAnalysisBloc, ColorAnalysisState>(
        listener: (context, state) {
          if (state is ColorAnalysisFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          final selectedImage = _getSelectedImage(state);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Image Preview
                GestureDetector(
                  onTap: () => _showImageSourceSheet(context),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 55,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Tap to select an image',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            )
                          : Image.file(
                              selectedImage,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Analyze Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        (state is ColorAnalysisLoading || selectedImage == null)
                        ? null
                        : () => _analyze(context, selectedImage),
                    child: const Text('Analyze Colors'),
                  ),
                ),

                const SizedBox(height: 24),

                // Results
                if (state is ColorAnalysisLoading)
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Processing image...'),
                        ],
                      ),
                    ),
                  )
                else if (state is ColorAnalysisSuccess)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dominant Colors',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.colors.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return DominantColorCard(
                                color: state.colors[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  File? _getSelectedImage(ColorAnalysisState state) {
    if (state is ColorAnalysisInitial) {
      return state.selectedImage;
    } else if (state is ColorAnalysisLoading) {
      return state.selectedImage;
    } else if (state is ColorAnalysisSuccess) {
      return state.selectedImage;
    } else if (state is ColorAnalysisFailure) {
      return state.selectedImage;
    }
    return null;
  }
}
