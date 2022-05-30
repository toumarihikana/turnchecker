// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileList _$ProfileListFromJson(Map<String, dynamic> json) => ProfileList(
      profiles: (json['profiles'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileListToJson(ProfileList instance) =>
    <String, dynamic>{
      'profiles': instance.profiles,
    };
