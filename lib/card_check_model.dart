import 'package:freezed_annotation/freezed_annotation.dart';
part 'card_check_model.freezed.dart';
part 'card_check_model.g.dart';

@freezed
class CardCheckModel with _$CardCheckModel {
  factory CardCheckModel(
      {required int id,
      required String cardName,
      required bool isCheck}) = _CardCheckModel;

  factory CardCheckModel.fromJson(Map<String, dynamic> json) =>
      _$CardCheckModelFromJson(json);
}
