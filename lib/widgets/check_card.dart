import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:turnchecker/models/card_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/profile_provider.dart';
import '../providers/tab_index_provider.dart';

class CheckCard extends HookConsumerWidget {
  CheckCard({
    required this.key,
    required this.cardData,
    required this.index,
  }) : super(key: key);
  final CardData cardData;
  final int index;
  final Key key;
  // bool flag = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    // TODO Providerを両対応にする
    var targetProfile = ref.watch(myProfileProvider);

    return Container(
      key: Key('$index main'),
      color: index.isOdd ? oddItemColor : evenItemColor,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  child: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                checkBoxes(ref, cardData.isChecks, index),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    cardData.cardName,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: (() {
              deleteCard(ref, index);
            }),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget checkBoxes(WidgetRef ref, List<bool> flags, int index) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < flags.length; i++)
          Checkbox(
            activeColor: Colors.blue,
            value: flags[i],
            onChanged: (flag) {
              var fs = [
                for (int j = 0; j < flags.length; j++)
                  if (j == i) !flags[j] else flags[j],
              ];
              flags = fs;
              ref.watch(myProfileProvider.notifier).changeChecks(flags, index);
            },
          ),
      ],
    );
  }

  void deleteCard(WidgetRef ref, int index) {
    if (ref.read(tabIndexProvider) == 0) {
      ref.watch(myProfileProvider.notifier).deleteCard(index);
    } else if (ref.read(tabIndexProvider) == 1) {
      ref.watch(opponentProfileProvider.notifier).deleteCard(index);
    }
  }
}
