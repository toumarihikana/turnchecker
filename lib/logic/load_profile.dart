import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstore/localstore.dart';

import '../constants/constant.dart';
import '../models/profile.dart';
import '../models/profile_list.dart';
import '../providers/profile_provider.dart';
import '../providers/tab_index_provider.dart';

class LoadProfile {
  static Future<void> loadProfileLogic(WidgetRef ref, String ulid) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();
    if (id != null) {
      if (id[dbDocNameChecklists] != null) {
        ProfileList saved = ProfileList.fromJson(id[dbDocNameChecklists]);
        Profile selectedProfile =
            saved.profiles.firstWhere((element) => element.ulid == ulid);

        if (ref.read(tabIndexProvider) == 0) {
          ref.watch(myProfileProvider.notifier).changeProfile(selectedProfile);
        } else if (ref.read(tabIndexProvider) == 1) {
          ref
              .watch(opponentProfileProvider.notifier)
              .changeProfile(selectedProfile);
        }
      }
    }
  }
}
