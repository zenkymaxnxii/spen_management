// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SpendType {
  int? id;
  String spendName;
  String icon;
  int type;
  bool selected = false;
  SpendType({
    this.id,
    required this.spendName,
    required this.icon,
    required this.type,
  });

  SpendType copyWith({
    int? id,
    String? spendName,
    String? icon,
    int? type,
  }) {
    return SpendType(
      id: id ?? this.id,
      spendName: spendName ?? this.spendName,
      icon: icon ?? this.icon,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'spendName': spendName,
      'icon': icon,
      'type': type,
    };
  }

  factory SpendType.fromMap(Map<String, dynamic> map) {
    return SpendType(
      id: map['id'] as int,
      spendName: map['spendName'] as String,
      icon: map['icon'] as String,
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpendType.fromJson(String source) =>
      SpendType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpendType(id: $id, ipendName: $spendName, icon: $icon, type: $type)';
  }

  @override
  bool operator ==(covariant SpendType other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.spendName == spendName &&
        other.icon == icon &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ spendName.hashCode ^ icon.hashCode ^ type.hashCode;
  }
}
