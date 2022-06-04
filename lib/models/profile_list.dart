import 'package:flutter/material.dart';
import 'package:turnchecker/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_list.g.dart';

@JsonSerializable()
@immutable
class ProfileList {
  const ProfileList({required this.profiles});

  final List<Profile> profiles;

  @override
  String toString() {
    String checks = '￤';
    for (var element in profiles) {
      checks += '$element￤';
    }
    return 'profiles.length:${profiles.length} profiles:$checks';
  }

  factory ProfileList.fromJson(Map<String, dynamic> json) =>
      _$ProfileListFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileListToJson(this);
}
