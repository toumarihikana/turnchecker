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

  // ProfileList.fromJson(Map<String, dynamic> json)
  //     : profiles = json['profiles'].cast<List<Profile>>();

  // Map<String, dynamic> toJson() => {
  //       'profiles': profiles,
  //       // final Map<String, dynamic> data = new Map<String, dynamic>();
  //       // if (this.profiles != null) {
  //       //   data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
  //       // }
  //       // return data;
  //     };
}
