// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      id: json['id'] as int,
      cardName: json['cardName'] as String,
      isChecks:
          (json['isChecks'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'id': instance.id,
      'cardName': instance.cardName,
      'isChecks': instance.isChecks,
    };
