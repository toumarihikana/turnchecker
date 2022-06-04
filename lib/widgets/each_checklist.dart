import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:turnchecker/models/card_data.dart';

import '../models/profile.dart';
import '/widgets/check_card.dart';
import '../providers/profile_provider.dart';

class EachChecklist extends HookConsumerWidget {
  const EachChecklist({required this.targetProvider, Key? key})
      : super(key: key);
  final ProfileProvider targetProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileProvider pp = targetProvider;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ReorderableListView.builder(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              // print('object$index');
              return CheckCard(
                cardData: ref.watch(pp).cards[index],
                index: index,
                targetProvider: targetProvider,
                key: ValueKey('$index main'),
              );
            },
            itemCount: ref.watch(pp).cards.length,
            onReorder: (int oldIndex, int newIndex) {
              _onReorder(ref, oldIndex, newIndex);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .watch(pp.notifier)
                  .changeProfile(resetChecksProfile(ref.watch(pp)));
            },
            child: const Text(
              "Reset Button",
            ),
          )
        ],
      ),
    );
  }

  void _onReorder(WidgetRef ref, int oldIndex, int newIndex) {
    ref.read(myProfileProvider.notifier).changeIndex(oldIndex, newIndex);
  }

  Profile resetChecksProfile(Profile profile) {
    List<CardData> newCards = [
      for (final card in profile.cards)
        CardData(
          id: card.id,
          cardName: card.cardName,
          isChecks: card.isChecks.map((e) => false).toList(),
        )
    ];
    Profile newProfile = Profile(
        ulid: profile.ulid, profileName: profile.profileName, cards: newCards);
    return newProfile;
  }
}
