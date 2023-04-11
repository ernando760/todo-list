// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part "task_model.g.dart";

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0, defaultValue: 1)
  final int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  bool isSelected;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isSelected = false,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isSelected,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isSelected': isSelected,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }
  set setSelected(bool selected) => isSelected = selected;
  @HiveField(4)
  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @HiveField(5)
  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, isSelected: $isSelected)';
  }

  @HiveField(6)
  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isSelected == isSelected;
  }

  @HiveField(7)
  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isSelected.hashCode;
  }
}
