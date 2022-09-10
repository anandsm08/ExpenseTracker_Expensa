import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
  final function;
  AddBtn({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ]),
        height: 40,
        width: 40,
        child: Center(
            child:
                Text('+', style: TextStyle(color: Colors.black, fontSize: 28))),
      ),
    );
  }
}
