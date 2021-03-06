import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'card_data.g.dart';

@JsonSerializable()
@immutable
class CardData {
  const CardData(
      {required this.id, required this.cardName, required this.isChecks});

  final int id;
  final String cardName;
  final List<bool> isChecks;

  @override
  String toString() {
    String checks = '|';
    for (var element in isChecks) {
      checks += '$element|';
    }
    return 'id:$id cardName:$cardName isCkecks.length:${isChecks.length} isChecks:$checks';
  }

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
