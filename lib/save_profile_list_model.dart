import 'package:flutter/material.dart';

@immutable
class SaveProfileListModel {
  late final List<Profile>? profiles;

  SaveProfileListModel({this.profiles});

  SaveProfileListModel.fromJson(Map<String, dynamic> json) {
    if (json['Profiles'] != null) {
      profiles = <Profile>[];
      json['Profiles'].forEach((v) {
        profiles!.add(Profile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profiles != null) {
      data['Profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SaveProfileListModel copyWith({List<Profile>? profiles}) {
    return SaveProfileListModel(profiles: profiles ?? this.profiles);
  }
}

@immutable
class Profile {
  late final String? name;
  late final List<CardData>? cards;
  late final String? ulid;

  Profile({this.name, this.cards, this.ulid});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['cards'] != null) {
      cards = <CardData>[];
      json['cards'].forEach((v) {
        cards!.add(CardData.fromJson(v));
      });
    }
    ulid = json[' ulid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toJson()).toList();
    }
    data[' ulid'] = ulid;
    return data;
  }

  Profile copyWith({String? name, List<CardData>? cards, String? ulid}) {
    return Profile(
      name: name ?? this.name,
      cards: cards ?? this.cards,
      ulid: ulid ?? this.ulid,
    );
  }
}

@immutable
class CardData {
  late final int id;
  late final String cardName;
  late final bool isCheck;

  CardData({required this.id, required this.cardName, required this.isCheck});

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardName = json['cardName'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cardName'] = cardName;
    data['isCheck'] = isCheck;
    return data;
  }

  CardData copyWith({int? id, String? cardName, bool? isCheck}) {
    return CardData(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
