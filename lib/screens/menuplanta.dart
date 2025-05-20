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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        double relWidth(double w) => screenWidth * (w / 440);
        double relHeight(double h) => screenHeight * (h / 956);

        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Fondo
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/backgroundplant.svg',
                  fit: BoxFit.cover,
                ),
              ),
              // TODO: aquí va tu cactus o contenido si quieres agregar
              Positioned(
                top: relHeight(24), // distancia desde arriba
                left: relWidth(24),
                right: relWidth(24),
                child: Container(
                  height: relHeight(60),
                  padding: EdgeInsets.symmetric(horizontal: relWidth(12)),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Botón izquierda
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF355E3B),
                          ),
                        ),
                      ),

                      // Título centro
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Chuzitos',
                          style: GoogleFonts.poppins(
                            fontSize: relWidth(16),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F1F1F),
                          ),
                        ),
                      ),

                      // Monedas derecha
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                size: 20,
                                color: Color(0xFF355E3B),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1500',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF355E3B),
                                  fontSize: relWidth(16),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: relWidth(24),
                bottom: relHeight(300),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // O el color base que quieras
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x4C9EB3A9),
                        blurRadius: 12,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ícono o figurita
                      SizedBox(
                        width: 65,
                        height: 64.5,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15.06,
                              top: 40.24,
                              child: Container(
                                width: 34,
                                height: 23.77,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF995E05),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15.06,
                              top: 40.24,
                              child: Container(
                                width: 34,
                                height: 18.82,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEE8E00),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ), // Separación entre ícono y texto
                      // Etiqueta "Armario"
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F6EA),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(
                          child: Text(
                            'Armario',
                            style: TextStyle(
                              color: Color(0xFF1F1F1F),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: navBar.CustomBottomNavBar(
            currentIndex: _selectedIndex,
            onItemSelected: (int index) {
              if (_selectedIndex != index) {
                setState(() {
                  _selectedIndex = index;
                });
                // Aquí puedes navegar a la pantalla correspondiente
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else if (index == 1) {
                  Navigator.pushReplacementNamed(context, '/welcome');
                } else if (index == 2) {
                  Navigator.pushReplacementNamed(context, '/planta');
                }
              }
            },
          ),
        );
      },
    );
  }
}
