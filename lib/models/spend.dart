// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Spend {
  int? id;
  int idSpenType;
  int idSpenDate;
  String spendNote;
  int spendAmount;
  Spend({
    this.id,
    required this.idSpenType,
    required this.idSpenDate,
    required this.spendNote,
    required this.spendAmount,
  });

  Spend copyWith({
    int? id,
    int? idSpenType,
    int? idSpenDate,
    String? spendNote,
    int? spendAmount,
  }) {
    return Spend(
      id: id ?? this.id,
      idSpenType: idSpenType ?? this.idSpenType,
      idSpenDate: idSpenDate ?? this.idSpenDate,
      spendNote: spendNote ?? this.spendNote,
      spendAmount: spendAmount ?? this.spendAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idSpenType': idSpenType,
      'idSpenDate': idSpenDate,
      'spendNote': spendNote,
      'spendAmount': spendAmount,
    };
  }

  factory Spend.fromMap(Map<String, dynamic> map) {
    return Spend(
      id: map['id'] != null ? map['id'] as int : null,
      idSpenType: map['idSpenType'] as int,
      idSpenDate: map['idSpenDate'] as int,
      spendNote: map['spendNote'] as String,
      spendAmount: map['spendAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Spend.fromJson(String source) =>
      Spend.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Spend(id: $id, idSpenType: $idSpenType, idSpenDate: $idSpenDate, spendNote: $spendNote, spendAmount: $spendAmount)';
  }

  @override
  bool operator ==(covariant Spend other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idSpenType == idSpenType &&
        other.idSpenDate == idSpenDate &&
        other.spendNote == spendNote &&
        other.spendAmount == spendAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idSpenType.hashCode ^
        idSpenDate.hashCode ^
        spendNote.hashCode ^
        spendAmount.hashCode;
  }
}
