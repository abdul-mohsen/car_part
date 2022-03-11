import 'package:flutter/material.dart';

Widget getEditText(String label, void Function(String? text) onTextChange) =>
    SizedBox(
        width: 250,
        child: TextFormField(
          onChanged: onTextChange,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: label,
          ),
          maxLines: 1,
          style: const TextStyle(fontSize: 18),
        ));
