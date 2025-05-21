import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/button.dart' as button;
import 'package:a/widgets/navegationbarhome.dart' as navBar;

class Plant1 extends StatefulWidget {
  @override
  _Plant1State createState() => _Plant1State();
}

class _Plant1State extends State<Plant1> {
  int _selectedIndex = 2;
  bool _isFabPressed = false;

  Widget _buildFloatingActionButton() {
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 900);

    // The FAB represents index 2 (Plant screen)
    bool isPlantSelected = _selectedIndex == 2;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isFabPressed = true),
      onTapUp: (_) {
        setState(() {
          _isFabPressed = false;
          // If tapping the FAB and we are NOT already on the plant screen (index 2)
          // then update _selectedIndex and navigate.
          if (_selectedIndex != 2) {
            _selectedIndex = 2; // Update the state for Plant1

            // Perform navigation to the plant screen if not already there
            // This check is important to prevent re-pushing the same route
            if (ModalRoute.of(context)?.settings.name != '/planta') {
              Navigator.pushReplacementNamed(context, '/planta');
            }
          }
          // If _selectedIndex is already 2, tapping the FAB might do nothing,
          // or you could add a refresh action or some other specific FAB behavior here.
        });
      },
      onTapCancel: () => setState(() => _isFabPressed = false),
      child: Transform.scale(
        scale: _isFabPressed ? 0.95 : 1.0, // Slightly adjusted scale
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: relWidth(64),
          height: relHeight(64),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isPlantSelected
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
                  isPlantSelected
                      ? const Color.fromRGBO(247, 246, 235, 1)
                      : const Color.fromRGBO(53, 94, 59, 1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // <<<<<<<< THIS IS THE ONLY SCAFFOLD FOR THIS SCREEN
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          double relWidth(double w) => screenWidth * (w / 440);
          double relHeight(double h) => screenHeight * (h / 956);

          return Stack(
            children: [
              // Fondo
              Positioned.fill(
                child: IgnorePointer(
                  child: SvgPicture.asset(
                    'assets/backgroundplant.svg',
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
              Positioned(
                top: relHeight(40),
                left: relWidth(24),
                right: relWidth(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón atrás
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: button.CustomIconButton(
                        isActivated: true,
                        icon: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    // Título
                    Text(
                      'Chuzitos',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F1F1F),
                      ),
                    ),
                    // Monedas
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Color(0xFF355E3B),
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '1500',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF355E3B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: navBar.CustomBottomNavBar(
        // This returns a BottomAppBar
        currentIndex: _selectedIndex,
        onItemSelected: (int index) {
          // This is the callback from your CustomBottomNavBar's icons (not the FAB)
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
            // Navigation logic for bottom nav items
            if (index == 0)
              Navigator.pushReplacementNamed(context, '/home');
            else if (index == 1)
              Navigator.pushReplacementNamed(
                context,
                '/mapa',
              ); // Corrected from welcome
            else if (index == 2) {
              // Plant/FAB's logical screen
              if (ModalRoute.of(context)?.settings.name != '/planta') {
                Navigator.pushReplacementNamed(context, '/planta');
              }
            } else if (index == 3)
              Navigator.pushReplacementNamed(context, '/retos');
            else if (index == 4)
              Navigator.pushReplacementNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}
