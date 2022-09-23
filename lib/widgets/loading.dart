import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingW extends StatefulWidget {
  const LoadingW({Key? key}) : super(key: key);

  @override
  State<LoadingW> createState() => _LoadingWState();
}

class _LoadingWState extends State<LoadingW> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: _size.height * .3,
        width: _size.width * .3,
        child: CupertinoActivityIndicator(
          animating: true,
          radius: _size.height * .07,
          color: Colors.blue,
        ),
      ),
    );
  }
}
