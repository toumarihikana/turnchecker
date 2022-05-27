import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'card_check_model.dart';
// import 'card_model.dart';
// import 'profile_model.dart';
import 'profile_provider.dart';
import 'save_profile_list_model.dart';

class CommonChecklistsWidget extends ConsumerStatefulWidget {
  const CommonChecklistsWidget(
    this.targetProvider, {
    Key? key,
  }) : super(key: key);

  final AbstractDisplayProfileProvider targetProvider;

  @override
  ConsumerState<CommonChecklistsWidget> createState() =>
      _CommonChecklistsWidget();
}

class _CommonChecklistsWidget extends ConsumerState<CommonChecklistsWidget> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    Profile targetDisplayProfile = ref.watch(widget.targetProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ReorderableListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, index) => CheckboxListTile(
              value: targetDisplayProfile.cards![index].isCheck,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? val) {
                itemChange(widget.targetProvider.notifier, index);
              },
              key: Key('$index' 'main'),
              tileColor: index.isOdd ? oddItemColor : evenItemColor,
              title: Text(targetDisplayProfile.cards![index].cardName),
            ),
            itemCount: targetDisplayProfile.cards!.length,
            onReorder: (int oldIndex, int newIndex) {
              _onReorder(targetDisplayProfile.cards!, oldIndex, newIndex);
            },
          ),
          ElevatedButton(
            onPressed: () {
              resetCheckBox(widget.targetProvider.notifier);
            },
            child: const Text(
              'Reset',
            ),
          ),
        ],
      ),
    );
  }

  void _onReorder(List<CardData> items, int oldIndex, int newIndex) {
    ref.read(widget.targetProvider.notifier).changeIndex(oldIndex, newIndex);
  }

  void itemChange(
      AlwaysAliveProviderBase<AbstractDisplayProfileNotifier> notifier,
      int index) {
    ref.read(widget.targetProvider.notifier).toggle(index);
  }

  void resetCheckBox(
      AlwaysAliveProviderBase<AbstractDisplayProfileNotifier> notifier) {
    ref.read(widget.targetProvider.notifier).allOff();
  }
}
