import 'save_check_list_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'card_check_model.freezed.dart';

@freezed
class CardCheckModel with _$CardCheckModel {
  factory CardCheckModel(
      {required int id,
      required String cardName,
      required bool isCheck}) = _CardCheckModelList;

  static List<CardCheckModel> getUsers() {
    return <CardCheckModel>[
      CardCheckModel(id: 1, cardName: '神碑の穂先', isCheck: false),
      CardCheckModel(id: 2, cardName: '輝く炎の神碑', isCheck: false),
      CardCheckModel(id: 3, cardName: '破壊の神碑', isCheck: false),
      CardCheckModel(id: 4, cardName: '解呪の神碑', isCheck: false),
      CardCheckModel(id: 5, cardName: '凍てつく呪いの神碑', isCheck: false),
      CardCheckModel(id: 6, cardName: 'まどろみ神碑', isCheck: false),
      CardCheckModel(id: 7, cardName: '黄金の雫の神碑', isCheck: false),
      CardCheckModel(id: 8, cardName: '怒れる嵐の神碑', isCheck: false),
    ];
  }

  static List<CardCheckModel> fromStringList(List<String> cardNames) {
    List<CardCheckModel> result = [];
    cardNames.asMap().forEach((index, value) {
      result.add(CardCheckModel(id: index, cardName: value, isCheck: false));
    });
    return result;
  }

  static Set<String> toMap(List<CardCheckModel> item) {
    String cards = '';
    for (var element in item) {
      cards += "'${element.cardName}',";
    }
    return {"cards:[$cards]"};
  }

  static Profile toProfile(
      String profileName, List<CardCheckModel> item, String ulid) {
    List<String> cardstNameList = [];
    for (var element in item) {
      cardstNameList.add(element.cardName);
    }

    return Profile(name: profileName, cards: cardstNameList, ulid: ulid);
  }
}
