import 'package:flutter/material.dart';

class ItemEquipado extends StatelessWidget {
  final Widget icono;
  final bool seleccionado;

  const ItemEquipado({
    super.key,
    required this.icono,
    this.seleccionado = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: seleccionado ? const Color(0xFFBDD8A6) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Center(child: icono),
          if (seleccionado)
            Positioned(
              top: 4,
              right: 4,
              child: Icon(
                Icons.check_circle,
                size: 16,
                color: Color(0xFF90BE6D),
              ),
            ),
        ],
      ),
    );
  }
}
