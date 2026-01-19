import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context, String message, {String textCancel = "Cancelar", String textAccept = "Aceptar"}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmación'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:   Text(textCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:   Text(textAccept),
          ),
        ],
      );
    },
  );
}
