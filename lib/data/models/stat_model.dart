// lib/data/models/stat_model.dart
import '../../domain/entities/stat_entity.dart';
class StatModel extends StatEntity {
  const StatModel({required super.title, required super.count, required super.iconName});
  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
    title: json['title'], count: json['count'], iconName: json['icon'],
  );
  Map<String, dynamic> toJson() => {'title': title, 'count': count, 'icon': iconName};
}