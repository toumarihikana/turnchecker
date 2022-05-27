import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turnchecker/constats.dart';
import 'package:ulid/ulid.dart';

import 'save_profile_list_model.dart';

// import 'card_check_model.dart';
// import 'card_model.dart';

abstract class AbstractDisplayProfileNotifier extends StateNotifier<Profile> {
  AbstractDisplayProfileNotifier(Profile profile) : super(profile);
  addItem(CardData item) {
    List<CardData> cardList = [
      for (final item in state.cards!) item,
    ];
    cardList.add(item);

    Profile newProfile =
        Profile(name: state.name, cards: cardList, ulid: state.ulid);

    state = newProfile.copyWith();
  }

  removeItem(int id) {
    // state.cards = [
    //   for (final item in state.cards!)
    //     if (item.id != id) item,
    // ];
  }

  toggle(int id) {
    List<CardData> cardList = [
      for (int i = 0; i < state.cards!.length; i++)
        if (i == id)
          state.cards![i].copyWith(isCheck: !state.cards![i].isCheck)
        else
          state.cards![i],
    ];

    Profile newProfile =
        Profile(name: state.name, cards: cardList, ulid: state.ulid);

    state = newProfile.copyWith();
  }

  allOff() {
    List<CardData> cardList = [
      for (int i = 0; i < state.cards!.length; i++)
        state.cards![i].copyWith(isCheck: false)
    ];

    Profile newProfile =
        Profile(name: state.name, cards: cardList, ulid: state.ulid);

    state = newProfile.copyWith();
  }

  changeProfile(Profile item) {
    state = item;
  }

  changeIndex(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    List<CardData> cardList = [
      for (final item in state.cards!) item,
    ];
    cardList.insert(newIndex, cardList.removeAt(oldIndex));

    Profile newProfile =
        Profile(name: state.name, cards: cardList, ulid: state.ulid);

    state = newProfile.copyWith();
  }
}

class MyDisplayProfileNotifier extends AbstractDisplayProfileNotifier {
  MyDisplayProfileNotifier()
      : super(Profile(
            ulid: Ulid().toString(), name: 'my con', cards: Ooooo.getUsers()));
}

typedef AbstractDisplayProfileProvider
    = StateNotifierProvider<AbstractDisplayProfileNotifier, Profile>;

final myDisplayProfileProvider = AbstractDisplayProfileProvider(((ref) {
  return MyDisplayProfileNotifier();
}));

class OpponentDisplayProfileNotifier extends AbstractDisplayProfileNotifier {
  OpponentDisplayProfileNotifier()
      : super(Profile(
            ulid: Ulid().toString(), name: 'op con', cards: Ooooo.getUsers()));
}

final opponentDisplayProfileProvider = AbstractDisplayProfileProvider(((ref) {
  return OpponentDisplayProfileNotifier();
}));

AbstractDisplayProfileNotifier nowDisplayProfileNotifier =
    MyDisplayProfileNotifier as AbstractDisplayProfileNotifier;
AbstractDisplayProfileProvider nowDisplayProfileProvider =
    myDisplayProfileProvider;
