import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 20,
        width: 20,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
