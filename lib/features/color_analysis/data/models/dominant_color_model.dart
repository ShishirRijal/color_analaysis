import '../../domain/entities/dominant_color.dart';

class DominantColorModel extends DominantColor {
  const DominantColorModel({required super.color, required super.percentage});

  factory DominantColorModel.fromJson(Map<String, dynamic> json) {
    return DominantColorModel(
      color: json['color'] as String,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'color': color, 'percentage': percentage};
  }
}
