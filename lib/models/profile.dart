import 'package:flutter/material.dart';
import 'package:turnchecker/models/card_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';

@JsonSerializable()
@immutable
class Profile {
  const Profile(
      {required this.ulid, required this.profileName, required this.cards});

  final String ulid;
  final String profileName;
  final List<CardData> cards;

  @override
  String toString() {
    String checks = '┃';
    for (var element in cards) {
      checks += '$element┃';
    }
    return 'ulid:$ulid profileName:$profileName cards.length:${cards.length} cards:$checks';
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
