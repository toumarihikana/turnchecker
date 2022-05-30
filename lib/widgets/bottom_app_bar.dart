import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:localstore/localstore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:turnchecker/logic/saveProfile.dart';

import '../constants/constant.dart';
import '../models/profile_list.dart';
import '../providers/profile_provider.dart';
import '/providers/tab_index_provider.dart';

import 'dialogs/profile_select.dart';
import 'dialogs/text_input.dart';

class BottomBar extends HookConsumerWidget {
  const BottomBar({Key? key, required this.stateCheckStr}) : super(key: key);
  final String stateCheckStr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var myProfileName = ref.watch(myProfileProvider).profileName;
    var opponentProfileName = ref.watch(opponentProfileProvider).profileName;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color barColor = colorScheme.onSurface;
    final Color profileNameColor = colorScheme.surface;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: barColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.folder),
              onPressed: () async {
                final db = Localstore.instance;
                final id =
                    await db.collection(dbCollectionNameChecklists).get();
                if (id != null) {
                  if (id[dbDocNameChecklists] != null) {
                    var res = ProfileList.fromJson(id[dbDocNameChecklists]);
                    var builder = ShowProfilesDialog.builder("保存済みプロファイル", res);
                    builder.build().show(context);
                  }
                }
              },
            ),
            Text.rich(
              TextSpan(
                  text: (() {
                    if (ref.watch(tabIndexProvider) == 0) {
                      return myProfileName;
                    } else if (ref.watch(tabIndexProvider) == 1) {
                      return opponentProfileName;
                    } else {
                      return '';
                    }
                  }()),
                  style: TextStyle(color: profileNameColor)),
            ),
            IconButton(
              tooltip: 'save',
              icon: const Icon(Icons.save),
              onPressed: () {
                saveTapAction(context, ref);
              },
            ),
            IconButton(
              tooltip: 'Save as',
              icon: const Icon(Icons.save_as),
              onPressed: () async {
                saveAsTapAction(context, ref);
              },
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveTapAction(BuildContext context, WidgetRef ref) async {
    if (ref.read(tabIndexProvider) == 0) {
      SaveProfile.saveLogic(ref, ref.watch(myProfileProvider));
    } else if (ref.read(tabIndexProvider) == 1) {
      SaveProfile.saveLogic(ref, ref.watch(opponentProfileProvider));
    }
    showSnackBarWithNoAction(context, 'Save');
  }

  Future<void> saveAsTapAction(BuildContext context, WidgetRef ref) async {
    var builder = EditTextDialog.builder("Save As");
    builder.submit = "Create";
    var profileName = await builder.build().show(context);
    if (profileName == null) {
      showSnackBarWithNoAction(context, 'Please set profile name',
          durationTime: 3000);
      return;
    }

    if (ref.read(tabIndexProvider) == 0) {
      SaveProfile.saveAsLogic(ref, ref.watch(myProfileProvider), profileName);
    } else if (ref.read(tabIndexProvider) == 1) {
      SaveProfile.saveAsLogic(
          ref, ref.watch(opponentProfileProvider), profileName);
    }
    showSnackBarWithNoAction(context, 'Save As');
  }

  void showSnackBarWithNoAction(BuildContext context, String message,
      {int durationTime = 1000}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: durationTime),
        content: Text(message),
        // action: SnackBarAction(
        //   label: 'Action',
        //   onPressed: () {
        //     // Code to execute.
        //   },
        // ),
      ),
    );
  }
}
