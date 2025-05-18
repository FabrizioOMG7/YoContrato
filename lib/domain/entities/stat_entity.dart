// lib/domain/entities/stat_entity.dart
import 'package:equatable/equatable.dart';

class StatEntity extends Equatable {
  final String title;
  final int count;
  final String iconName;

  const StatEntity({
    required this.title,
    required this.count,
    required this.iconName,
  });

  @override
  List<Object> get props => [title, count, iconName];
}
