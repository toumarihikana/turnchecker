import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';

import 'check_list_page.dart';
import 'constats.dart';
import 'profile_provider.dart';
import 'profiles_select_dialog.dart';
import 'save_profile_list_model.dart';
import 'text_edit_dialog.dart';

class BottomActionBarWidget extends ConsumerStatefulWidget {
  const BottomActionBarWidget(
    this.targetProvider, {
    Key? key,
  }) : super(key: key);

  final AbstractDisplayProfileProvider targetProvider;

  @override
  ConsumerState<BottomActionBarWidget> createState() =>
      _BottomActionBarWidget();
}

class _BottomActionBarWidget extends ConsumerState<BottomActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    Profile targetDisplayProfile = ref.watch(nowDisplayProfileProvider);

    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      notchMargin: 6.0,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(),
        StadiumBorder(
          side: BorderSide(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 30, 2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.folder_open_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                final db = Localstore.instance;
                final id =
                    await db.collection(dbCollectionNameChecklists).get();
                if (id != null) {
                  if (id[dbDocNameChecklists] != null) {
                    var res =
                        SaveProfileListModel.fromJson(id[dbDocNameChecklists]);
                    if (!mounted) return;
                    await showTextDialog(context, res.profiles!);

                    ref
                        .watch(nowProfileNameProvider.notifier)
                        .changeProfileName(
                            ref.watch(nowDisplayProfileProvider).name!);
                  }
                }
              },
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 170,
              ),
              child: Text.rich(
                TextSpan(
                  text: ref.watch(nowProfileNameProvider),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                saveItem(targetDisplayProfile);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.save_as,
                color: Colors.white,
              ),
              onPressed: () async {
                final profileName = await showEditDialog(
                    context, "プロファイル名", (context, profileName) {});

                saveAsItem(profileName!);
                ref
                    .watch(nowProfileNameProvider.notifier)
                    .changeProfileName(profileName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteSavedProfile(int index) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();
    if (id != null) {
      if (id[dbDocNameChecklists] != null) {
        var res = SaveProfileListModel.fromJson(id[dbDocNameChecklists]);
        if (!mounted) return;
        res.profiles!.removeAt(index);
        var result = res.toJson();

        db
            .collection(dbCollectionNameChecklists)
            .doc(dbDocNameChecklists)
            .set(result);

        ref.read(savedProfilesCountNotifierProvider.notifier).decrement();
      }
    }
  }

  static Future<String?> showEditDialog(BuildContext context,
      String profileName, Function(BuildContext, String)? onSuccess) async {
    return showDialog(
        context: context,
        builder: (context) {
          return TextEditDialog(text: profileName, callback: onSuccess);
        });
  }

  static Future<String?> showTextDialog(
      BuildContext context, List<Profile> profiles) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ProfilesSelectDialog(profiles: profiles);
        });
  }

  Future<void> saveAsItem(String name) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();

    Profile profile = ref.watch(nowDisplayProfileProvider);
    Profile saveProfile =
        Profile(name: name, cards: profile.cards, ulid: profile.ulid);
    SaveProfileListModel newSave;

    if (id != null && id[dbDocNameChecklists] != null) {
      SaveProfileListModel saved =
          SaveProfileListModel.fromJson(id[dbDocNameChecklists]).copyWith();

      newSave =
          SaveProfileListModel(profiles: [...?saved.profiles, saveProfile]);
    } else {
      newSave = SaveProfileListModel(profiles: [saveProfile]);
    }

    var result = newSave.toJson();

    db
        .collection(dbCollectionNameChecklists)
        .doc(dbDocNameChecklists)
        .set(result);

    ref.read(savedProfilesCountNotifierProvider.notifier).increment();
    ref.read(nowDisplayProfileProvider.notifier).changeProfile(saveProfile);
    ref
        .watch(nowProfileNameProvider.notifier)
        .changeProfileName(saveProfile.name!);
    // if (widget.targetProvider == myDisplayProfileProvider) {
    //   ref.read(myDisplayProfileProvider.notifier).changeProfile(saveProfile);
    // } else if (widget.targetProvider == opponentDisplayProfileProvider) {
    //   ref
    //       .read(opponentDisplayProfileProvider.notifier)
    //       .changeProfile(saveProfile);
    // }
  }

  Future<void> saveItem(Profile profile) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();
    SaveProfileListModel saved = SaveProfileListModel(profiles: const []);
    if (id != null && id[dbDocNameChecklists] != null) {
      saved = SaveProfileListModel.fromJson(id[dbDocNameChecklists]);

      var newProfile =
          Profile(name: profile.name, cards: profile.cards, ulid: profile.ulid);
      if (saved.profiles != null) {
        var existProfiles = saved.profiles!
            .firstWhere((element) => element.ulid == profile.ulid);

        var i = saved.profiles!.indexOf(existProfiles);

        saved.profiles!.removeAt(i);
        saved.profiles!.insert(i, newProfile);
      }

      var result = saved.toJson();

      db
          .collection(dbCollectionNameChecklists)
          .doc(dbDocNameChecklists)
          .set(result);
    } else {
      // 上書き保存の処理なのでprofilesが存在しないのはおかしい
    }
  }
}
