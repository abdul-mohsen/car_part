import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getEditText(
        {String? label,
        String? text,
        void Function(String? text)? onTextChange,
        List<TextInputFormatter>? inputFormatters,
        double? width,
        int? maxLines = 1}) =>
    SizedBox(
        width: width,
        child: TextFormField(
          inputFormatters: inputFormatters,
          onChanged: onTextChange,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: label,
          ),
          initialValue: text,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 18),
        ));
