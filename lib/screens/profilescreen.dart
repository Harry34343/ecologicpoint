// lib/screens/profilescreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a/widgets/navegationbarhome.dart' as navBar;

class ProfileScreen extends StatefulWidget {
  // CHANGED to StatefulWidget
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(); // CHANGED
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex =
      4; // <<--- Challenges screen is index 3 (0:Home, 1:Mapa, 2:Planta/FAB, 3:Retos, 4:Perfil)
  bool _isFabPressed = false;
  Widget _buildFloatingActionButton() {
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 956);

    bool isPlantSelected = _selectedIndex == 2;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isFabPressed = true),
      onTapUp: (_) {
        setState(() {
          _isFabPressed = false;
          if (_selectedIndex != 2) {
            _selectedIndex = 2;
            Navigator.pushReplacementNamed(context, '/planta');
          }
        });
      },
      onTapCancel: () => setState(() => _isFabPressed = false),
      child: Transform.scale(
        scale: _isFabPressed ? 0.95 : 1.0,
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
            child: SvgPicture.asset(
              'assets/phplantduotone.svg', // Your main FAB icon
              width: relWidth(24),
              height: relHeight(24),
              colorFilter: ColorFilter.mode(
                isPlantSelected
                    ? const Color.fromRGBO(247, 246, 235, 1)
                    : const Color.fromRGBO(53, 94, 59, 1),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper para Poppins (mantenlo consistente o muévelo a utils)
  static TextStyle _poppins(
    FontWeight fontWeight,
    double fontSize,
    Color color,
  ) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo del usuario (eventualmente vendrán de un gestor de estado o API)
    const String userName = "Marco228";
    const String userEmail = "marco4345@email.com";
    const String userAvatarAsset =
        'assets/plantas/bambu.svg'; // O la planta actual del usuario
    const int userStreak = 25;
    const String userStreakUnit = "Racha"; // O Días, etc.
    const int userEcoPoints = 1500;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6EA), // Fondo general
      appBar: AppBar(
        backgroundColor: const Color(
          0xFFF7F6EA,
        ), // Fondo de AppBar igual al body
        elevation: 0,
        automaticallyImplyLeading: false, // No mostrar botón de retroceso
        title: Text(
          'Mi Perfil',
          style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false, // La BottomAppBar ya maneja el espacio inferior
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Avatar
              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(
                  8,
                ), // Espacio entre el borde y la imagen
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(
                    0xFFD4ECDD,
                  ).withOpacity(0.7), // Fondo claro para el círculo
                  border: Border.all(
                    color: const Color(0xFFA8C686),
                    width: 3,
                  ), // Borde verde
                ),
                child: ClipOval(
                  child: SvgPicture.asset(
                    userAvatarAsset,
                    fit:
                        BoxFit
                            .contain, // O BoxFit.cover si la imagen no es perfectamente circular
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Nombre de usuario y email
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: _poppins(
                      FontWeight.w700,
                      22,
                      const Color(0xFF1F1F1F),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Icono de copiar, si lo tienes como SVG, usa SvgPicture.asset
                  Icon(
                    Icons.copy_outlined,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                userEmail,
                style: _poppins(FontWeight.w400, 14, Colors.grey.shade700),
              ),
              const SizedBox(height: 24),

              // Tarjetas de Estadísticas
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'assets/bolas.svg',
                      userStreak.toString(),
                      userStreakUnit,
                      isStreak: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'assets/logo.svg',
                      userEcoPoints.toString(),
                      'EcoPoints',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Opciones del menú
              _buildProfileOptionItem(
                icon: Icons.person_outline, // O tu asset: 'assets/cara.svg'
                text: 'Editar perfil',
                onTap: () {
                  /* Navegar a Editar Perfil */
                },
              ),
              _buildProfileOptionItem(
                icon: Icons.lock_outline, // O tu asset de candado
                text: 'Cambiar contraseña',
                onTap: () {
                  /* Navegar a Cambiar Contraseña */
                },
              ),
              _buildProfileOptionItem(
                icon: Icons.help_outline, // O tu asset de candado/ayuda
                text: 'Centro de ayuda y sugerencias',
                onTap: () {
                  /* Navegar a Centro de Ayuda */
                },
              ),
              const SizedBox(height: 32),

              // Botón Cerrar Sesión
              ElevatedButton.icon(
                icon: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
                label: Text(
                  'Cerrar sesión',
                  style: _poppins(FontWeight.w600, 16, Colors.red.shade700),
                ),
                onPressed: () {
                  // Lógica para cerrar sesión
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Fondo blanco
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Ancho completo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ), // Bordes redondeados
                    side: BorderSide(
                      color: Colors.red.shade700,
                      width: 1.5,
                    ), // Borde rojo
                  ),
                  elevation: 2, // Sombra sutil
                ),
              ),
              const SizedBox(height: 20), // Espacio al final
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: navBar.CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onItemSelected: (int index) {
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0)
              Navigator.pushReplacementNamed(context, '/home');
            else if (index == 1)
              Navigator.pushReplacementNamed(context, '/mapa');
            else if (index == 2) {
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

  Widget _buildStatCard(
    String iconAssetPath,
    String value,
    String label, {
    bool isStreak = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAssetPath,
            width: 28,
            height: 28,
            colorFilter:
                isStreak
                    ? ColorFilter.mode(const Color(0xFFEE8E00), BlendMode.srcIn)
                    : ColorFilter.mode(
                      const Color(0xFF355E3B),
                      BlendMode.srcIn,
                    ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: _poppins(FontWeight.w700, 22, const Color(0xFF1F1F1F)),
              ),
              Text(
                label,
                style: _poppins(FontWeight.w400, 12, Colors.grey.shade600),
              ),
            ],
          ),
          if (isStreak) const SizedBox(width: 4), // Pequeño espacio si es racha
          if (isStreak)
            Text(
              "Racha",
              style: _poppins(FontWeight.w400, 10, Colors.grey.shade600),
            ), // Texto "Racha" pequeño si es necesario (como en la imagen)
        ],
      ),
    );
  }

  Widget _buildProfileOptionItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE4E9E4), // Gris claro de fondo
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF355E3B),
              size: 22,
            ), // Icono verde oscuro
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: _poppins(FontWeight.w500, 16, const Color(0xFF1F1F1F)),
              ),
            ),
            SvgPicture.asset(
              'assets/buttonflecha.svg',
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade600,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Copia y pega _buildActualBottomNavigationBar y _bottomNavItem de otros screens
  // Asegúrate de que el currentIndex sea el correcto para "Perfil"
  Widget _buildActualBottomNavigationBar(BuildContext context) {
    int currentIndex = 3; // 3 para Perfil

    return BottomAppBar(
      color: const Color(0xFFF7F6EA),
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 8.0,
      child: SizedBox(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.home_filled,
                label: 'Inicio',
                isSelected: currentIndex == 0,
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/home') {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.map_outlined,
                label: 'Mapa',
                isSelected: currentIndex == 1,
                onTap: () {
                  /* Nav a Mapa */
                },
              ),
            ),
            const SizedBox(width: 48),
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.list_alt_outlined,
                label: 'Retos',
                isSelected: currentIndex == 2,
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/challenges') {
                    Navigator.pushReplacementNamed(context, '/challenges');
                  }
                },
              ),
            ),
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.person_outline,
                label: 'Perfil',
                isSelected: currentIndex == 3,
                onTap: () {
                  /* Ya estamos en Perfil */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final color =
        isSelected ? const Color(0xFF1F1F1F) : const Color(0xFF9EB3A9);
    final fontWeight = isSelected ? FontWeight.w600 : FontWeight.w400;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 3),
              Text(
                label,
                style: _poppins(fontWeight, 11.5, color),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
