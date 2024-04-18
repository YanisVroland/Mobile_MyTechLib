import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const DeleteDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onCancel,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () async {
             onDelete();
          },
          child: const Text("Continuer"),
        ),
      ],
    );
  }
}
