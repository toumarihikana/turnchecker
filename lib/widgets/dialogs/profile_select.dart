import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'package:turnchecker/logic/load_profile.dart';

import '../../constants/constant.dart';
import '../../models/profile_list.dart';

class ShowProfilesDialogBuilder {
  String title;
  ProfileList profileList;

  ShowProfilesDialogBuilder(this.title, this.profileList);

  ShowProfilesDialog build() {
    return ShowProfilesDialog._builder(this);
  }
}

class ShowProfilesDialog extends HookConsumerWidget {
  final String title;
  final ProfileList profileList;

  ShowProfilesDialog._builder(ShowProfilesDialogBuilder builder)
      : title = builder.title,
        profileList = builder.profileList;

  static ShowProfilesDialogBuilder builder(
      String title, ProfileList profileList) {
    return ShowProfilesDialogBuilder(title, profileList);
  }

  Future<String?> show(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (_) {
          return this;
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO 並び替え、削除の即時UI反映
    var profileListState = useState(profileList);

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 100,
        height: 300,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ReorderableListView(
                buildDefaultDragHandles: true,
                onReorder: (int oldIndex, int newIndex) async {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  profileListState.value.profiles.insert(newIndex,
                      profileListState.value.profiles.removeAt(oldIndex));

                  final db = Localstore.instance;
                  ProfileList saved =
                      ProfileList(profiles: profileListState.value.profiles);
                  var result = saved.toJson();

                  db
                      .collection('checklists')
                      .doc(dbDocNameChecklists)
                      .set(result);
                },
                children: <Widget>[
                  for (int i = 0;
                      i < profileListState.value.profiles.length;
                      i++)
                    Card(
                        key: Key('${i}profiles'),
                        child: InkWell(
                          onTap: (() async {
                            LoadProfile.loadProfileLogic(
                                ref, profileListState.value.profiles[i].ulid);

                            Navigator.pop(context);
                          }),
                          child: ListTile(
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                deleteProfile(i);
                              },
                            ),
                            title: Text(
                                profileListState.value.profiles[i].profileName),
                            tileColor: i.isEven
                                ? Colors.amber[100]
                                : Colors.amberAccent[100],
                          ),
                        ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteProfile(int i) {
    profileList.profiles.removeAt(i);

    final db = Localstore.instance;
    ProfileList saved = ProfileList(profiles: profileList.profiles);
    var result = saved.toJson();

    db
        .collection(dbCollectionNameChecklists)
        .doc(dbDocNameChecklists)
        .set(result);
  }
}
