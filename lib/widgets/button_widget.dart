import 'package:flutter/material.dart';

class ButtonEidget extends StatefulWidget {
  const ButtonEidget({
    Key? key,
    required this.width,
    required this.action,
    required this.txt,
  }) : super(key: key);
  final double width;
  final Function() action;
  final String txt;
  @override
  State<ButtonEidget> createState() => _ButtonEidgetState();
}

class _ButtonEidgetState extends State<ButtonEidget> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        height: _size.height * .07,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(
            38,
            117,
            64,
            82,
          ),
        ),
        child: Text(
          widget.txt,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
