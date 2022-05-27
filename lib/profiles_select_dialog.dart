import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'constats.dart';
import 'profile_provider.dart';
import 'save_profile_list_model.dart';

class ProfilesSelectDialog extends ConsumerStatefulWidget {
  const ProfilesSelectDialog({Key? key, required this.profiles})
      : super(key: key);

  final List<Profile> profiles;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilesSelectDialogState();
}

class _ProfilesSelectDialogState extends ConsumerState<ProfilesSelectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("保存済みプロファイル"),
        content: SizedBox(
            width: 100,
            height: 300,
            child: Row(children: <Widget>[
              Expanded(
                  child: ReorderableListView(
                buildDefaultDragHandles: false,
                onReorder: (int oldIndex, int newIndex) async {
                  setState((() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    widget.profiles
                        .insert(newIndex, widget.profiles.removeAt(oldIndex));
                  }));

                  final db = Localstore.instance;
                  SaveProfileListModel saved =
                      SaveProfileListModel(profiles: widget.profiles);
                  var result = saved.toJson();

                  db
                      .collection('checklists')
                      .doc(dbDocNameChecklists)
                      .set(result);
                },
                children: <Widget>[
                  for (int i = 0; i < widget.profiles.length; i++)
                    Card(
                        key: Key('${i}profiles'),
                        child: InkWell(
                          onTap: (() async {
                            var targetProvider = nowDisplayProfileProvider;

                            final db = Localstore.instance;
                            final id = await db
                                .collection(dbCollectionNameChecklists)
                                .get();
                            if (id != null) {
                              if (id[dbDocNameChecklists] != null) {
                                SaveProfileListModel saved =
                                    SaveProfileListModel.fromJson(
                                        id[dbDocNameChecklists]);
                                ref
                                    .watch(targetProvider.notifier)
                                    .changeProfile(saved.profiles![i]);

                                if (targetProvider ==
                                    myDisplayProfileProvider) {
                                  ref
                                      .watch(myDisplayProfileProvider.notifier)
                                      .changeProfile(saved.profiles![i]);
                                } else if (targetProvider ==
                                    opponentDisplayProfileProvider) {
                                  ref
                                      .watch(opponentDisplayProfileProvider
                                          .notifier)
                                      .changeProfile(saved.profiles![i]);
                                }
                              }
                            }

                            if (!mounted) return;
                            Navigator.pop(context);
                          }),
                          child: ListTile(
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                setState((() {
                                  widget.profiles.removeAt(i);
                                }));

                                final db = Localstore.instance;
                                SaveProfileListModel saved =
                                    SaveProfileListModel(
                                        profiles: widget.profiles);
                                var result = saved.toJson();

                                db
                                    .collection('checklists')
                                    .doc(dbDocNameChecklists)
                                    .set(result);
                              },
                            ),
                            title: Text(widget.profiles[i].name!),
                            tileColor: i.isEven
                                ? Colors.amber[100]
                                : Colors.amberAccent[100],
                          ),
                        ))
                ],
              ))
            ])));
  }

  void changeNowViewList(
      AlwaysAliveProviderBase<AbstractDisplayProfileNotifier> notifier,
      Profile item) {
    ref.read(notifier).changeProfile(item);
  }
}
