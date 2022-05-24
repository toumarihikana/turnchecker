import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'card_check_model.dart';
import 'check_list_page.dart';
import 'save_check_list_model.dart';

class ProfilesSelectDialog extends ConsumerStatefulWidget {
  const ProfilesSelectDialog(
      {Key? key, required this.profiles, required this.tabIndex})
      : super(key: key);

  final List<Profile> profiles;
  final int tabIndex;

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
                  SaveCheckListModel saved = SaveCheckListModel();
                  saved.profiles = widget.profiles;
                  var result = saved.toJson();

                  db.collection('checklists').doc('profiles').set(result);
                },
                children: <Widget>[
                  for (int i = 0; i < widget.profiles.length; i++)
                    Card(
                        key: Key('${i}profiles'),
                        child: InkWell(
                          onTap: (() async {
                            if (widget.tabIndex == 1) {
                              final db = Localstore.instance;
                              final id =
                                  await db.collection('checklists').get();
                              SaveCheckListModel saved = SaveCheckListModel();
                              if (id != null) {
                                if (id['profiles'] != null) {
                                  saved = SaveCheckListModel.fromJson(
                                      id['profiles']);
                                  var select = saved.profiles![i];
                                  List<String> cardsName = select.cards ?? [];
                                  changeNowViewList(
                                      opponentCheckBoxModelListProvider
                                          .notifier,
                                      cardsName);
                                  ref
                                      .read(
                                          opponentProfileNameProvider.notifier)
                                      .changeProfileName(select.name!);
                                  ref
                                      .read(viewNowProfileNameProvider.notifier)
                                      .changeProfileName(select.name!);
                                  ref
                                      .read(viewNowProfileUlidProvider.notifier)
                                      .changeUlid(select.ulid);
                                }
                              }
                            } else {
                              final db = Localstore.instance;
                              final id =
                                  await db.collection('checklists').get();
                              SaveCheckListModel saved = SaveCheckListModel();
                              if (id != null) {
                                if (id['profiles'] != null) {
                                  saved = SaveCheckListModel.fromJson(
                                      id['profiles']);
                                  var select = saved.profiles![i];
                                  List<String> cardsName = select.cards ?? [];
                                  changeNowViewList(
                                      myCheckBoxModelListProvider.notifier,
                                      cardsName);
                                  ref
                                      .read(myProfileNameProvider.notifier)
                                      .changeProfileName(select.name!);
                                  ref
                                      .read(viewNowProfileNameProvider.notifier)
                                      .changeProfileName(select.name!);
                                  ref
                                      .read(viewNowProfileUlidProvider.notifier)
                                      .changeUlid(select.ulid);
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
                                SaveCheckListModel saved = SaveCheckListModel();
                                saved.profiles = widget.profiles;
                                var result = saved.toJson();

                                db
                                    .collection('checklists')
                                    .doc('profiles')
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
      AlwaysAliveProviderBase<AbstractCheckBoxModelListNotifier> notifier,
      List<String> item) {
    ref.read(notifier).changeList(CardCheckModel.fromStringList(item));
  }
}
