import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'package:turnchecker/models/profile.dart';
import 'package:turnchecker/models/profile_list.dart';
import 'package:ulid/ulid.dart';

import '../constants/constant.dart';
import '../providers/profile_provider.dart';
import '../providers/tab_index_provider.dart';

class SaveProfile {
  static void saveLogic(WidgetRef ref, Profile profile) async {
    saveAsLogic(ref, profile, profile.profileName);
  }

  static void saveAsLogic(
      WidgetRef ref, Profile profile, String profileName) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();

    Profile saveProfile = Profile(
        profileName: profileName,
        cards: profile.cards,
        ulid: Ulid().toString());
    ProfileList newSave;

    if (id != null && id[dbDocNameChecklists] != null) {
      ProfileList saved = ProfileList.fromJson(id[dbDocNameChecklists]);

      newSave = ProfileList(profiles: [...saved.profiles, saveProfile]);
    } else {
      newSave = ProfileList(profiles: [saveProfile]);
    }

    var result = newSave.toJson();

    db
        .collection(dbCollectionNameChecklists)
        .doc(dbDocNameChecklists)
        .set(result);

    if (ref.read(tabIndexProvider) == 0) {
      ref.read(myProfileProvider.notifier).changeProfile(saveProfile);
    } else if (ref.read(tabIndexProvider) == 1) {
      ref.read(opponentProfileProvider.notifier).changeProfile(saveProfile);
    }
  }
}
