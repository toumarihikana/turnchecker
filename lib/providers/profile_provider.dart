import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:turnchecker/models/card_data.dart';
import 'package:turnchecker/models/profile.dart';
import 'package:ulid/ulid.dart';

class ProfileNotifier extends StateNotifier<Profile> {
  ProfileNotifier()
      : super(Profile(
            ulid: Ulid().toString(),
            profileName: 'Default',
            cards: const [
              CardData(id: 0, cardName: '0', isChecks: [false])
            ]));

  void addCard(String cardName) {
    var newCard = CardData(
        id: state.cards.length, cardName: cardName, isChecks: const [false]);
    var newCards = [...state.cards, newCard];
    Profile newProfile = Profile(
        ulid: state.ulid, profileName: state.profileName, cards: newCards);
    state = newProfile;
  }

  void deleteCard(int id) {
    var newCards = [
      for (final card in state.cards)
        if (card.id != id) card,
    ];
    Profile newProfile = Profile(
        ulid: state.ulid, profileName: state.profileName, cards: newCards);
    state = newProfile;
  }

  changeIndex(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    List<CardData> cardList = [
      for (final item in state.cards) item,
    ];
    cardList.insert(newIndex, cardList.removeAt(oldIndex));

    Profile newProfile = Profile(
        profileName: state.profileName, cards: cardList, ulid: state.ulid);

    state = newProfile;
  }

  void changeProfile(Profile selectedProfile) {
    Profile newProfile = Profile(
        profileName: selectedProfile.profileName,
        cards: selectedProfile.cards,
        ulid: selectedProfile.ulid);
    state = newProfile;
  }
}

typedef ProfileProvider = StateNotifierProvider<ProfileNotifier, Profile>;

final profileProvider = ProfileProvider((_) => ProfileNotifier());

final myProfileProvider = ProfileProvider((_) => ProfileNotifier());
final opponentProfileProvider = ProfileProvider((_) => ProfileNotifier());
