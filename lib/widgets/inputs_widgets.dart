import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  const InputWidget(
      {Key? key, required this.textEditingController, required this.text})
      : super(key: key);
  final TextEditingController textEditingController;
  final String text;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        label: Text(widget.text),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff066124), width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff066124), width: 1),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff066124), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff066124), width: 1),
        ),
      ),
    );
  }
}
