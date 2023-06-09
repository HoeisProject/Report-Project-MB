// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum MaterialFeasibilityModelEnum {
  id('id'),
  descripiton('description'),
  weight('weight');

  const MaterialFeasibilityModelEnum(this.value);
  final String value;
}

@immutable
class MaterialFeasibilityModel {
  final String id;
  final String description;
  final double weight;
  const MaterialFeasibilityModel({
    required this.id,
    required this.description,
    required this.weight,
  });

  MaterialFeasibilityModel copyWith({
    String? id,
    String? description,
    double? weight,
  }) {
    return MaterialFeasibilityModel(
      id: id ?? this.id,
      description: description ?? this.description,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'weight': weight,
    };
  }

  factory MaterialFeasibilityModel.fromMap(Map<String, dynamic> map) {
    return MaterialFeasibilityModel(
      id: map['id'].toString(),
      description: map['description'] as String,
      weight: map['weight'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialFeasibilityModel.fromJson(String source) =>
      MaterialFeasibilityModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MaterialFeasibilityModel(id: $id, description: $description, weight: $weight)';

  @override
  bool operator ==(covariant MaterialFeasibilityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.weight == weight;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ weight.hashCode;
}
