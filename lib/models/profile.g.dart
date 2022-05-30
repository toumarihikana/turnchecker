// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      ulid: json['ulid'] as String,
      profileName: json['profileName'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'ulid': instance.ulid,
      'profileName': instance.profileName,
      'cards': instance.cards,
    };
