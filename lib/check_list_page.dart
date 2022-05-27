import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'package:flutter/foundation.dart';
import 'package:turnchecker/bottom_action_bar.dart';
import 'package:turnchecker/save_profile_list_model.dart';
import 'checklists_tab_widget.dart';
import 'constats.dart';
import 'floating_button_widget_build.dart';
import 'profile_provider.dart';

class SavedProfilesCountNotifier extends StateNotifier<AsyncValue<int>> {
  SavedProfilesCountNotifier() : super(const AsyncValue.loading()) {
    _fetch();
  }

  Future<void> _fetch() async {
    state = const AsyncValue.loading();
    try {
      state = const AsyncValue.data(0);
      final db = Localstore.instance;
      final id = await db.collection(dbCollectionNameChecklists).get();
      if (id != null) {
        if (id['profiles'] != null) {
          var res = SaveProfileListModel.fromJson(id['profiles']);

          state = AsyncValue.data(res.profiles!.length);
        }
      }
    } catch (e) {
      state = const AsyncValue.data(0);
    }
  }

  void increment() {
    state = AsyncValue.data(state.value! + 1);
  }

  void decrement() {
    state = AsyncValue.data(state.value! - 1);
  }
}

final savedProfilesCountNotifierProvider =
    StateNotifierProvider<SavedProfilesCountNotifier, AsyncValue<int>>(((ref) {
  return SavedProfilesCountNotifier();
}));

class NowProfileNameNotifier extends StateNotifier<String> {
  NowProfileNameNotifier(String nowProfileName) : super(nowProfileName);

  changeProfileName(String newName) {
    state = newName;
  }
}

final nowProfileNameProvider =
    StateNotifierProvider<NowProfileNameNotifier, String>(((ref) {
  return NowProfileNameNotifier('');
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
    return MaterialApp(
        title: "TurnChecker",
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Checklist for card activation'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                  )
                ],
              ),
              body: SafeArea(
                child: Builder(
                  builder: (context) =>
                      const SafeArea(child: ChecklistsTabWidget()),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: floatingButtonBuild(),
              bottomNavigationBar:
                  BottomActionBarWidget(nowDisplayProfileProvider),
            );
          },
        ));
  }

  Widget floatingButtonBuild() {
    return const FloatingButtonWidgetBuild(
      text: '',
    );
  }

  Future<void> deleteSavedProfile(int index) async {
    final db = Localstore.instance;
    final id = await db.collection(dbCollectionNameChecklists).get();
    if (id != null) {
      if (id['profiles'] != null) {
        var res = SaveProfileListModel.fromJson(id['profiles']);
        if (!mounted) return;
        res.profiles!.removeAt(index);
        var result = res.toJson();

        db.collection(dbCollectionNameChecklists).doc('profiles').set(result);

        ref.read(savedProfilesCountNotifierProvider.notifier).decrement();
      }
    }
  }
}
