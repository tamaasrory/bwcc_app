import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:flutter/material.dart';

Widget dropdownField(
  context, {
  List<String>? label,
  required List<Map<String, dynamic>> items,
  Function(dynamic)? itemValue,
  Function(dynamic)? itemText,
  required Function(Object?) onChanged,
  Object? value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      richLable(context, label?.elementAt(0) ?? '', label?.elementAt(1) ?? ''),
      DropdownButton(
        isExpanded: true,
        // Initial Value
        value: value,
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        // Array list of items
        items: dropdownMenuItem(items, itemValue, itemText),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (v) => onChanged(v),
      ),
    ],
  );
}

List<DropdownMenuItem<Object>> dropdownMenuItem(List<Map<String, dynamic>> items, itemValue, itemText) {
  return items.map((val) {
    logApp('BACAAA => ' + val['text']);
    return DropdownMenuItem(
      value: itemValue != null ? itemValue(val) : val['value'],
      child: Text(itemText != null ? itemText(val) : val['text']),
    );
  }).toList();
}
