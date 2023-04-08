// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:spen_management/helper/format.dart';

class SpendDate {
  int? id;
  DateTime spendDate;
  SpendDate({
    this.id,
    required this.spendDate,
  });

  SpendDate copyWith({
    int? id,
    DateTime? spendDate,
  }) {
    return SpendDate(
      id: id ?? this.id,
      spendDate: spendDate ?? this.spendDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'spendDate': spendDate.getDate(),
    };
  }

  factory SpendDate.fromMap(Map<String, dynamic> map) {
    return SpendDate(
      id: map['id'] != null ? map['id'] as int : null,
      spendDate: DateTime.parse(map['spendDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpendDate.fromJson(String source) =>
      SpendDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SpendDate(id: $id, spendDate: $spendDate)';

  @override
  bool operator ==(covariant SpendDate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.spendDate == spendDate;
  }

  @override
  int get hashCode => id.hashCode ^ spendDate.hashCode;
}
