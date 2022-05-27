import 'save_profile_list_model.dart';

const String dbCollectionNameChecklists = 'checklists';

const String dbDocNameChecklists = 'profiles';

class Ooooo {
  static List<CardData> getUsers() {
    return <CardData>[
      CardData(id: 0, cardName: '神碑の穂先', isCheck: false),
      CardData(id: 1, cardName: '輝く炎の神碑', isCheck: false),
      CardData(id: 2, cardName: '破壊の神碑', isCheck: false),
      CardData(id: 3, cardName: '解呪の神碑', isCheck: false),
      CardData(id: 4, cardName: '凍てつく呪いの神碑', isCheck: false),
      CardData(id: 5, cardName: 'まどろみ神碑', isCheck: false),
      CardData(id: 6, cardName: '黄金の雫の神碑', isCheck: false),
      CardData(id: 7, cardName: '怒れる嵐の神碑', isCheck: false),
    ];
  }
}
