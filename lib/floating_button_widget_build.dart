import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turnchecker/profile_provider.dart';

import 'save_profile_list_model.dart';
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
        Profile targetProfile = ref.watch(nowDisplayProfileProvider);
        var newItem = CardData(
            id: targetProfile.cards!.length + 1,
            cardName: cardName!,
            isCheck: false);
        ref.read(nowDisplayProfileProvider.notifier).addItem(newItem);
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
