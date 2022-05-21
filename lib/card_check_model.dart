import 'save_check_list_model.dart';

class CardCheckModel {
  int id;
  String cardName;
  bool isCheck;

  CardCheckModel(
      {required this.id, required this.cardName, required this.isCheck});

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

  static Set<String> toMap(List<CardCheckModel> item) {
    String cards = '';
    for (var element in item) {
      cards += "'${element.cardName}',";
    }
    return {"cards:[$cards]"};
  }

  static Profile toProfile(String profileName, List<CardCheckModel> item) {
    List<String> cardstNameList = [];
    for (var element in item) {
      cardstNameList.add(element.cardName);
    }

    return Profile(name: profileName, cards: cardstNameList);
  }
}
