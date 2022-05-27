import 'package:freezed_annotation/freezed_annotation.dart';

import 'card_model.dart';
part 'profile_model.freezed.dart';

@freezed
// @JsonSerializable(explicitToJson: true)
class Profile with _$Profile {
  factory Profile(
      {required String name,
      required List<CardModel> cards,
      required String ulid}) = _Profile;
}
