import 'package:flutter/material.dart';

class TextOnlyDialog extends StatefulWidget {
  const TextOnlyDialog({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<StatefulWidget> createState() => _TextOnlyDialog();
}

class _TextOnlyDialog extends State<TextOnlyDialog> {
  final focusNode = FocusNode();
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(textEditingController.text),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(textEditingController.text);
            },
            child: const Text("決定"))
      ],
    );
  }
}
