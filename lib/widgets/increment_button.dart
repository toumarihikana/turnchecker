import 'package:flutter/material.dart';
import 'package:turnchecker/providers/profile_provider.dart';
import '/providers/tab_index_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dialogs/text_input.dart';

class IncrementButton extends HookConsumerWidget {
  const IncrementButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: (() => tapAction(context, ref)),
      tooltip: 'External Increment',
      child: const Icon(Icons.add),
    );
  }

  Future<void> tapAction(BuildContext context, WidgetRef ref) async {
    var builder = EditTextDialog.builder("Add Card");
    builder.submit = "Create";
    var cardName = await builder.build().show(context);

    // ダイアログの外をタップするとダイアログから文字が帰ってこないのでnullチェックが必要
    if (cardName == null) return;

    if (ref.read(tabIndexProvider) == 0) {
      ref.read(myProfileProvider.notifier).addCard(cardName);
    } else if (ref.read(tabIndexProvider) == 1) {
      ref.read(opponentProfileProvider.notifier).addCard(cardName);
    }
  }
}
