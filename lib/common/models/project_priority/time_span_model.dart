// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum TimeSpanModelEnum {
  id('id'),
  min('min'),
  max('max'),
  weight('weight');

  const TimeSpanModelEnum(this.value);
  final String value;
}

@immutable
class TimeSpanModel {
  final String id;
  final int min;
  final int max;
  final double weight;
  const TimeSpanModel({
    required this.id,
    required this.min,
    required this.max,
    required this.weight,
  });

  TimeSpanModel copyWith({
    String? id,
    int? min,
    int? max,
    double? weight,
  }) {
    return TimeSpanModel(
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

  factory TimeSpanModel.fromMap(Map<String, dynamic> map) {
    return TimeSpanModel(
      id: map['id'].toString(),
      min: map['min'] as int,
      max: map['max'] as int,
      weight: map['weight'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSpanModel.fromJson(String source) =>
      TimeSpanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeSpanModel(id: $id, min: $min, max: $max, weight: $weight)';
  }

  @override
  bool operator ==(covariant TimeSpanModel other) {
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
