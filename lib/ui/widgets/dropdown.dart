import 'dart:convert';

import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:flutter/material.dart';

class SelectWidget extends StatefulWidget {
  final List<String>? label;
  final List<Map<String, dynamic>> items;
  final Function(dynamic)? itemValue;
  final Function(dynamic)? itemText;
  final Function(Object?) onChanged;
  final Object? value;

  const SelectWidget({
    Key? key,
    this.label,
    required this.items,
    this.itemValue,
    this.itemText,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  List<DropdownMenuItem<Object>> dropdownMenuItem(List<Map<String, dynamic>> items, itemValue, itemText) {
    return items.map((val) {
      // logApp('SELECT MODELS => ' + jsonEncode(val));
      return DropdownMenuItem(
        value: itemValue != null ? itemValue(val) : val['value'],
        child: Text(itemText != null ? itemText(val) : val['text']),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        richLable(context, widget.label?.elementAt(0) ?? '', widget.label?.elementAt(1) ?? ''),
        DropdownButton(
          isExpanded: true,
          // Initial Value
          value: widget.value,
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: dropdownMenuItem(widget.items, widget.itemValue, widget.itemText),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (v) => widget.onChanged(v),
        ),
      ],
    );
  }
}
