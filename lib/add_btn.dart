import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
  const AddBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
