// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum MoneyEstimateModelEnum {
  id('id'),
  min('min'),
  max('max'),
  weight('weight');

  const MoneyEstimateModelEnum(this.value);
  final String value;
}

@immutable
class MoneyEstimateModel {
  final String id;
  final double min;
  final double max;
  final double weight;
  const MoneyEstimateModel({
    required this.id,
    required this.min,
    required this.max,
    required this.weight,
  });

  MoneyEstimateModel copyWith({
    String? id,
    double? min,
    double? max,
    double? weight,
  }) {
    return MoneyEstimateModel(
      id: id ?? this.id,
      min: min ?? this.min,
      max: max ?? this.max,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'min': min,
      'max': max,
      'weight': weight,
    };
  }

  factory MoneyEstimateModel.fromMap(Map<String, dynamic> map) {
    return MoneyEstimateModel(
      id: map['id'].toString(),
      min: map['min'].toDouble(),
      max: map['max'].toDouble(),
      weight: map['weight'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoneyEstimateModel.fromJson(String source) =>
      MoneyEstimateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MoneyEstimateModel(id: $id, min: $min, max: $max, weight: $weight)';
  }

  @override
  bool operator ==(covariant MoneyEstimateModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.min == min &&
        other.max == max &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^ min.hashCode ^ max.hashCode ^ weight.hashCode;
  }
}
