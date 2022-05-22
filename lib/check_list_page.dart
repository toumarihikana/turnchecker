// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'package:flutter/foundation.dart';

import 'card_check_model.dart';
import 'floatingButtonWidgetBuild.dart';
import 'save_check_list_model.dart';
import 'text_edit_dialog.dart';
import 'text_only_dialog.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'check_list_page.freezed.dart';

@freezed
class CardCheckModelList with _$CardCheckModelList {
  factory CardCheckModelList({List<CardCheckModel>? models}) =
      _CardCheckModelList;
}

abstract class AbstractCheckBoxModelListNotifier
    extends StateNotifier<List<CardCheckModel>> {
  AbstractCheckBoxModelListNotifier(List<CardCheckModel> list) : super(list);
  addItem(CardCheckModel item) {
    state = [...state, item];
  }

  removeItem(int id) {
    state = [
      for (final item in state)
        if (item.id != id) item,
    ];
  }

  toggle(int id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isCheck: !item.isCheck) else item,
    ];
  }

  allOff() {
    state = [
      for (final item in state) item.copyWith(isCheck: false),
    ];
  }
}

class MyCheckBoxModelListNotifier extends AbstractCheckBoxModelListNotifier {
  MyCheckBoxModelListNotifier() : super(CardCheckModel.getUsers());
}

final myCheckBoxModelListProvider =
    StateNotifierProvider<MyCheckBoxModelListNotifier, List<CardCheckModel>>(
        ((ref) {
  return MyCheckBoxModelListNotifier();
}));

class OpponentCheckBoxModelListNotifier
    extends AbstractCheckBoxModelListNotifier {
  OpponentCheckBoxModelListNotifier() : super(CardCheckModel.getUsers());
}

final opponentCheckBoxModelListProvider = StateNotifierProvider<
    OpponentCheckBoxModelListNotifier, List<CardCheckModel>>(((ref) {
  return OpponentCheckBoxModelListNotifier();
}));

class CheckListPage extends ConsumerStatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  final String title = 'Checklist for card activation';

  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends ConsumerState<CheckListPage> {
  @override
  Widget build(BuildContext context) {
    List<CardCheckModel> myCheckBoxModelList =
        ref.watch(myCheckBoxModelListProvider);
    List<CardCheckModel> opponentCheckBoxModelList =
        ref.watch(opponentCheckBoxModelListProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    final _tab = <Tab>[
      const Tab(text: 'myself', icon: Icon(Icons.person)),
      const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
    ];

    return MaterialApp(
      home: DefaultTabController(
        length: _tab.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Checklist for card activation'),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              tabs: _tab,
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => CheckboxListTile(
                        value: myCheckBoxModelList[index].isCheck,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? val) {
                          itemChange(myCheckBoxModelListProvider.notifier,
                              myCheckBoxModelList[index].id);
                        },
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(myCheckBoxModelList[index].cardName),
                      ),
                      itemCount: myCheckBoxModelList.length,
                      onReorder: (int oldIndex, int newIndex) {
                        _onReorder(myCheckBoxModelList, oldIndex, newIndex);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetCheckBox(myCheckBoxModelListProvider.notifier);
                      },
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => CheckboxListTile(
                        value: opponentCheckBoxModelList[index].isCheck,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? val) {
                          itemChange(opponentCheckBoxModelListProvider.notifier,
                              opponentCheckBoxModelList[index].id);
                        },
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(opponentCheckBoxModelList[index].cardName),
                      ),
                      itemCount: opponentCheckBoxModelList.length,
                      onReorder: (int oldIndex, int newIndex) {
                        _onReorder(
                            opponentCheckBoxModelList, oldIndex, newIndex);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetCheckBox(
                            opponentCheckBoxModelListProvider.notifier);
                      },
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: floatingButtonBuild(),
          bottomNavigationBar: BottomAppBar(
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
                      final id = await db.collection('checklists').get();
                      var a = "te";
                      if (id != null) {
                        if (id['profiles'] != null) {
                          var res = SaveCheckListModel.fromJson(id['profiles']);
                          await showTextDialog(context,
                              res.profiles![res.profiles!.length - 1].name!);
                        }
                      }
                    },
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 170,
                    ),
                    child: const Text.rich(
                      TextSpan(
                        text: '12345678901234567890',
                        style: TextStyle(
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.save_as,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final profileName = await showEditDialog(
                          context, "プロファイル名", (context, profileName) {});
                      saveAsItem(myCheckBoxModelList, profileName!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget floatingButtonBuild() {
    return const FloatingButtonWidgetBuild(
      text: '',
    );
  }

  void _onReorder(List<CardCheckModel> items, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    items.insert(newIndex, items.removeAt(oldIndex));
  }

  void itemChange(
      AlwaysAliveProviderBase<AbstractCheckBoxModelListNotifier> notifier,
      int index) {
    ref.read(notifier).toggle(index);
  }

  void resetCheckBox(
      AlwaysAliveProviderBase<AbstractCheckBoxModelListNotifier> notifier) {
    ref.read(notifier).allOff();
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
      BuildContext context, String text) async {
    return showDialog(
        context: context,
        builder: (context) {
          return TextOnlyDialog(text: text);
        });
  }

  Future<void> saveAsItem(List<CardCheckModel> items, String name) async {
    final db = Localstore.instance;
    final id = await db.collection('checklists').get();
    SaveCheckListModel saved = SaveCheckListModel();
    if (id != null) {
      if (id['profiles'] != null) {
        saved = SaveCheckListModel.fromJson(id['profiles']);
      }
    }
    var nowList = CardCheckModel.toProfile(name, items);
    if (saved.profiles != null) {
      saved.profiles!.add(nowList);
    } else {
      saved.profiles = <Profile>[];
      saved.profiles!.add(nowList);
    }

    var result = saved.toJson();

    db.collection('checklists').doc('profiles').set(result);
  }
}
