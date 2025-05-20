import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  bool _isPressed = false;

  double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
  double relHeight(double h) => MediaQuery.of(context).size.height * (h / 900);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors
              .transparent, // o un color con opacidad, ej: Colors.white.withOpacity(0.8)
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // Botón central flotante
      floatingActionButton: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
            _selectedIndex = 2; // Índice del botón de planta
          });
          // Aquí puedes navegar o cambiar pantalla si quieres
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: relWidth(64),
          height: relHeight(64),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _selectedIndex == 2
                    ? const Color.fromRGBO(53, 94, 59, 1)
                    : const Color.fromRGBO(168, 198, 134, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.local_florist,
              size: relWidth(32),
              color:
                  _selectedIndex == 2
                      ? const Color.fromRGBO(247, 246, 235, 1)
                      : const Color.fromRGBO(53, 94, 59, 1),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 8,
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(relWidth(24)),
            topRight: Radius.circular(relWidth(24)),
          ),
          child: SizedBox(
            height: relHeight(relHeight(70)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavIcon(Icons.home, 'Inicio', 0, relWidth),
                _buildNavIcon(Icons.pin_drop_rounded, 'Mapa', 1, relWidth),
                SizedBox(
                  width: relWidth(24),
                ), // Espacio antes del botón central
                _buildNavIcon(Icons.list, 'Retos', 3, relWidth),
                _buildNavIcon(Icons.person, 'Perfil', 4, relWidth),
              ],
            ),
          ),
        ),
      ),
      body:
          Container(), // Puedes reemplazar esto con el contenido principal de tu pantalla
    );
  }

  Widget _buildNavIcon(
    IconData icon,
    String label,
    int index,
    double Function(double) relWidth,
  ) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF355E3B) : Colors.grey,
            size: relWidth(24),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: relWidth(12),
              color: isSelected ? const Color(0xFF355E3B) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
