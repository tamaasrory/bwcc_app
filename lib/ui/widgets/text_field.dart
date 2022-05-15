import 'package:bwcc_app/config/app.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? hint;
  final Function(String?)? onChanged;
  final String? value;
  final Function()? onTap;
  final String? label;
  final Widget? customelabel;
  final TextInputType? inputType;
  final bool? hideText;
  final bool? readonly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;

  const TextFieldWidget({
    Key? key,
    this.validator,
    this.value,
    this.hint,
    this.onChanged,
    this.onTap,
    this.label,
    this.customelabel,
    this.inputType,
    this.hideText,
    this.readonly,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.addListener(() {
      print('TEXTFIELDWIDGET ini adalah percobaan : ${_textController.text}');
    });

    super.initState();
    if (mounted) {
      setFieldValue();
    }
  }

  setFieldValue() {
    logApp('TEXTFIELDWIDGET ' + widget.hint.toString() + ' == on set value => ' + widget.value.toString());
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
    List<Widget> widgetCollect = [];
    if (widget.label != null) {
      widgetCollect.add(Text(
        widget.label.toString(),
        style: Theme.of(context).textTheme.labelMedium,
      ));
      widgetCollect.add(const SizedBox(height: 2));
    }

    if (widget.customelabel != null) {
      widgetCollect.add(widget.customelabel!);
      widgetCollect.add(const SizedBox(height: 2));
    }

    widgetCollect.add(TextFormField(
      // autofocus: true,
      controller: _textController,
      obscureText: widget.hideText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        hintText: widget.hint,
        border: const UnderlineInputBorder(),
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        suffixIcon: widget.suffixIcon,
        suffix: widget.suffix,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        prefixText: widget.prefixText,
        prefixStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      style: const TextStyle(fontSize: 16),
      validator: widget.validator,
      keyboardType: widget.inputType ?? TextInputType.text,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readonly ?? false,
    ));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: widgetCollect);
  }
}
