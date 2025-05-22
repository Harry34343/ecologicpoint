import 'package:flutter/material.dart';

class ArmarioCategoriaWidget extends StatelessWidget {
  final List<Widget> items;

  const ArmarioCategoriaWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFCFBF3), // Fondo beige clarito
      padding: const EdgeInsets.all(8),
      child: Wrap(spacing: 12, runSpacing: 12, children: items),
    );
  }
}
