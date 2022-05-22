import 'package:flutter/material.dart';

class TextEditDialog extends StatefulWidget {
  const TextEditDialog({
    Key? key,
    required this.text,
    this.callback,
  }) : super(key: key);
  final String text;
  final Function(BuildContext, String)? callback;

  @override
  State<StatefulWidget> createState() => _TextEditDialog();
}

class _TextEditDialog extends State<TextEditDialog> {
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
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          textEditingController.selection = TextSelection(
              baseOffset: 0, extentOffset: textEditingController.text.length);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        autofocus: true,
        focusNode: focusNode,
        controller: textEditingController,
        onFieldSubmitted: (_) {
          Navigator.of(context).pop(textEditingController.text);
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (widget.callback != null) {
                widget.callback!(context, textEditingController.text);
              }
              Navigator.of(context).pop(textEditingController.text);
            },
            child: const Text("決定"))
      ],
    );
  }
}
