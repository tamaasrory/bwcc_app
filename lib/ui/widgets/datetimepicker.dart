import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class DateTimeWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? hint;
  final Function(String?)? onChanged;
  final String? value;
  final String? initValue;
  final String? mask;
  final String? locale;
  final DateTimePickerType? type;

  const DateTimeWidget({
    Key? key,
    this.validator,
    this.hint,
    this.onChanged,
    this.value,
    this.mask,
    this.locale,
    this.type,
    this.initValue,
  }) : super(key: key);

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(setFieldValue);
  }

  setFieldValue() {
    _textController.text = widget.value ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      controller: _textController,
      type: widget.type ?? DateTimePickerType.date,
      locale: Locale(widget.locale ?? 'id'),
      dateMask: widget.mask ?? 'dd/MMM/yyyy',
      dateHintText: widget.hint,
      // initialValue: widget.initValue,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
