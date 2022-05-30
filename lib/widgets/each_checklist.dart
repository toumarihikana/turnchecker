import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/profile.dart';
import '/widgets/check_card.dart';
import '../providers/profile_provider.dart';

class EachChecklist extends HookConsumerWidget {
  const EachChecklist({required this.profile, Key? key}) : super(key: key);
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ReorderableListView.builder(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemBuilder: (_, index) => CheckCard(
              cardData: profile.cards[index],
              index: index,
              key: ValueKey('$index main'),
            ),
            itemCount: profile.cards.length,
            onReorder: (int oldIndex, int newIndex) {
              _onReorder(ref, oldIndex, newIndex);
            },
          ),
        ],
      ),
    );
  }

  void _onReorder(WidgetRef ref, int oldIndex, int newIndex) {
    ref.read(myProfileProvider.notifier).changeIndex(oldIndex, newIndex);
  }
}
