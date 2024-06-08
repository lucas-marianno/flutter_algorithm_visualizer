import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<int?> intInputDialog(
  BuildContext context,
  String title,
  int value,
  int min,
  int max,
) async =>
    await showDialog(
      context: context,
      builder: (context) {
        int newValue = value;

        return AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(helperText: '$min - $max'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (v) => newValue = int.parse(v),
            onSubmitted: (_) => Navigator.pop(context, newValue.clamp(min, max)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, newValue.clamp(min, max)),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
