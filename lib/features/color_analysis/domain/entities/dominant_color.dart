import 'package:equatable/equatable.dart';

class DominantColor extends Equatable {
  final String color;
  final double percentage;

  const DominantColor({required this.color, required this.percentage});

  @override
  List<Object?> get props => [color, percentage];
}
