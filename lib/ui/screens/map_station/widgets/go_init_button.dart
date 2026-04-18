import 'package:flutter/material.dart';

class GoInitButton extends StatelessWidget {
  final VoidCallback goToInitial;
  const GoInitButton({super.key, required this.goToInitial});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 16,
      child: FloatingActionButton(
        onPressed: goToInitial,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
