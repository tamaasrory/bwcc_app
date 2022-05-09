import 'package:flutter/material.dart';

Widget textFieldWidget(
  context, {
  String? Function(String?)? validator,
  required String hint,
  Function(String?)? onChanged,
  Function()? onTap,
  String? label,
  Widget? customelabel,
  TextInputType? inputType,
  bool? hideText,
  Widget? suffixIcon,
  Widget? suffix,
  Widget? prefix,
  Widget? prefixIcon,
  String? prefixText,
}) {
  List<Widget> widget = [];
  if (label != null) {
    widget.add(Text(
      label,
      style: Theme.of(context).textTheme.labelMedium,
    ));
    widget.add(const SizedBox(height: 2));
  }

  if (customelabel != null) {
    widget.add(customelabel);
    widget.add(const SizedBox(height: 2));
  }

  widget.add(TextFormField(
    // autofocus: true,
    obscureText: hideText ?? false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      hintText: hint,
      border: const UnderlineInputBorder(),
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      suffixIcon: suffixIcon,
      suffix: suffix,
      prefix: prefix,
      prefixIcon: prefixIcon,
      prefixText: prefixText,
      prefixStyle: const TextStyle(fontSize: 14, color: Colors.grey),
    ),
    style: const TextStyle(fontSize: 16),
    validator: validator,
    keyboardType: inputType ?? TextInputType.text,
    onChanged: onChanged,
    onTap: onTap,
  ));
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: widget);
}
