// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum ManpowerModelEnum {
  id('id'),
  min('min'),
  max('max'),
  weight('weight');

  const ManpowerModelEnum(this.value);
  final String value;
}

@immutable
class ManpowerModel {
  final String id;
  final int min;
  final int max;
  final double weight;
  const ManpowerModel({
    required this.id,
    required this.min,
    required this.max,
    required this.weight,
  });

  ManpowerModel copyWith({
    String? id,
    int? min,
    int? max,
    double? weight,
  }) {
    return ManpowerModel(
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

  factory ManpowerModel.fromMap(Map<String, dynamic> map) {
    return ManpowerModel(
      id: map['id'].toString(),
      min: map['min'] as int,
      max: map['max'] as int,
      weight: map['weight'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ManpowerModel.fromJson(String source) =>
      ManpowerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ManpowerModel(id: $id, min: $min, max: $max, weight: $weight)';
  }

  @override
  bool operator ==(covariant ManpowerModel other) {
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
