import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turnchecker/card_check_model.dart';

import 'check_list_page.dart';
import 'text_edit_dialog.dart';

class FloatingButtonWidgetBuild extends ConsumerWidget {
  final String text;

  const FloatingButtonWidgetBuild({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        final cardName = await showEditDialog(context, "カード名");
        if (DefaultTabController.of(context)?.index == 1) {
          var items = ref.watch(opponentCheckBoxModelListProvider);
          var newItem = CardCheckModel(
              id: items.length + 1, cardName: cardName!, isCheck: false);
          ref.read(opponentCheckBoxModelListProvider.notifier).addItem(newItem);
        } else {
          var items = ref.watch(myCheckBoxModelListProvider);
          var newItem = CardCheckModel(
              id: items.length + 1, cardName: cardName!, isCheck: false);
          ref.read(myCheckBoxModelListProvider.notifier).addItem(newItem);
        }
      },
      backgroundColor: Colors.green,
      mini: true,
      child: const Icon(Icons.add),
    );
  }

  static Future<String?> showEditDialog(
      BuildContext context, String profileName) async {
    return showDialog(
        context: context,
        builder: (context) {
          return TextEditDialog(text: profileName);
        });
  }
}
