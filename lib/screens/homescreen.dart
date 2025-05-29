// lib/screens/homescreen.dart
import 'profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// No es estrictamente necesario importar TipsScreen y ChallengesScreen aquí
// si solo navegas por nombre de ruta, pero no hace daño tenerlas
// import 'tipsscreen.dart';
// import 'challengesscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static TextStyle _poppins(FontWeight fontWeight, double fontSize, Color color) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6EA),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: _buildCustomTopBar(context)),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildHeaderCard(context),
                    const SizedBox(height: 32),
                    _buildActionButtons(context),
                    const SizedBox(height: 32),
                    _buildMapPreview(context),
                    const SizedBox(height: 32),
                    _buildSectionTitle(context, "Mis retos", '/challenges'),
                    const SizedBox(height: 12),
                    _buildChallengeItem(
                      iconAsset: 'assets/logo.svg', // Placeholder, usa un icono de reto específico
                      title: 'Reciclador en Acción',
                      description: 'Lleva 3 tipos de residuos a un punto de reciclaje.',
                      progress: '0/3',
                      points: '+50',
                      isSvg: true,
                    ),
                    const SizedBox(height: 12),
                    _buildChallengeItem(
                      iconAsset: 'assets/logo2.svg', // Placeholder, usa un icono de reto específico
                      title: 'Guardián del Parque',
                      description: 'Recolecta 5 basuras en un espacio verde cercano.',
                      progress: '0/5',
                      points: '+25',
                      isSvg: true,
                    ),
                    const SizedBox(height: 12),
                     _buildChallengeItem(
                      iconAsset: 'assets/phplantduotone.svg', // Placeholder
                      title: 'Tech Salvado',
                      description: 'Recicla un electrónico viejo en un centro autorizado.',
                      progress: '0/1',
                      points: '+10',
                      isSvg: true,
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle(context, "Mis tips", '/tips'),
                    const SizedBox(height: 12),
                    _buildTipItem(
                      assetPath: 'assets/planeta.svg', // Globo terráqueo
                      isSvg: true,
                      title: '¿Sabías que…?',
                      description: 'Un solo árbol puede absorber hasta 22 kg de CO₂ al año.',
                    ),
                    const SizedBox(height: 12),
                    _buildTipItem(
                      assetPath: 'assets/gota.svg', // Gota de agua
                      isSvg: true,
                      title: 'Cada gota cuenta',
                      description: 'Dejar el grifo abierto mientras te cepillas puede desperdiciar hasta 20 litros de agua.',
                    ),
                    const SizedBox(height: 12),
                    _buildTipItem(
                      assetPath: 'assets/botella.svg', // Botella de plástico
                      isSvg: true,
                      title: 'El plástico no desaparece',
                      description: 'Una botella de plástico puede tardar más de 400 años en degradarse.',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* Acción del FAB */ },
        backgroundColor: const Color(0xFFA8C686),
        elevation: 4.0,
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          'assets/logo.svg', // TU LOGO PRINCIPAL PARA EL FAB
          width: 28, height: 28, // Ajusta el tamaño si es necesario
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)
        ),
      ),
      bottomNavigationBar: _buildActualBottomNavigationBar(context),
    );
  }

  Widget _buildCustomTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12).copyWith(top: MediaQuery.of(context).padding.top + 12),
      decoration: const BoxDecoration(color: Color(0xFFE4E9E4)), // Color de la barra superior de HomeScreen
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Asumiendo que 'logo.svg' es el logo de la hoja de EcologicPoint
              SvgPicture.asset('assets/logo.svg', width: 25, height: 32, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn)),
              const SizedBox(width: 8),
              Text(
                'EcologicPoint+',
                style: TextStyle(
                  color: const Color(0xFF355E3B),
                  fontSize: 20,
                  fontFamily: 'Agbalumo', // Asegúrate que esta fuente esté en pubspec.yaml
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Asumiendo 'bolas.svg' es el icono de fuego/energía
              SvgPicture.asset('assets/bolas.svg', width: 20, height: 20, colorFilter: ColorFilter.mode(const Color(0xFFEE8E00), BlendMode.srcIn)),
              const SizedBox(width: 4),
              Text('25', style: _poppins(FontWeight.w700, 16, const Color(0xFFEE8E00))),
              const SizedBox(width: 24),
              // Asumiendo 'plata+50.svg' es el icono de hoja/puntos (o usa 'logo.svg' si es el mismo)
              SvgPicture.asset('assets/logo.svg', width: 14, height: 20, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn)),
              const SizedBox(width: 8),
              Text('1500', style: _poppins(FontWeight.w700, 16, const Color(0xFF355E3B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFFD4ECDD), Color(0xFFEAECD4)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Asumiendo 'fondoX.svg' o 'backgroundplant.svg' es el patrón de hojas de fondo
          Positioned.fill(
            child: ClipRRect( // Para que el patrón respete los bordes redondeados
              borderRadius: BorderRadius.circular(24),
              child: SvgPicture.asset(
                'assets/backgroundplant.svg', // O 'fondoX.svg'
                fit: BoxFit.cover, // O BoxFit.fill
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop), // Para hacerlo sutil
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: -10,
            // Asumiendo que 'plantas/cactus.svg' es el cactus
            child: SvgPicture.asset('assets/plantas/cactus.svg', width: 100, height: 150),
          ),
          Positioned(
            left: 125,
            top: 25,
            child: Container(
              // ... (contenido del texto "¡Hola, Marco228!") ...
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12), topLeft: Radius.circular(12)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))],
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '¡Hola, ', style: _poppins(FontWeight.w700, 16, const Color(0xFF1F1F1F))),
                    TextSpan(text: 'Marco228', style: _poppins(FontWeight.w700, 16, const Color(0xFF688549))), // Nombre de usuario en verde
                    TextSpan(text: '!', style: _poppins(FontWeight.w700, 16, const Color(0xFF1F1F1F))),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 75,
            child: Container(
              // ... (contenido del "Mi Eco Chuzitos") ...
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFA8C686),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: const Color(0xFF355E3B).withOpacity(0.5), offset: const Offset(0, 2), blurRadius: 0)]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Mi Eco', style: _poppins(FontWeight.w600, 12, const Color(0xFFF7F6EA))),
                  Text('Chuzitos', style: _poppins(FontWeight.w700, 24, const Color(0xFFF7F6EA))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionButton(context: context, assetIconPath: 'assets/tiendaicon.svg', label: 'Tienda', routeName: '/planta'),
        _actionButton(context: context, assetIconPath: 'assets/armarioicon.svg', label: 'Armario', routeName: '/armario'),
        // Asumiendo 'logo2.svg' o 'gota.svg' para tips
        _actionButton(context: context, assetIconPath: 'assets/logo2.svg', label: 'Tips', routeName: '/tips'),
      ],
    );
  }

  // Modificado para aceptar assetIconPath en lugar de IconData
  Widget _actionButton({required BuildContext context, required String assetIconPath, required String label, String? routeName}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (routeName != null && routeName.isNotEmpty) {
            Navigator.pushNamed(context, routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sección "${label}" no disponible aún.')));
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7F6EA),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadows: [BoxShadow(color: const Color(0x4C9EB3A9), blurRadius: 12)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(assetIconPath, width: 24, height: 24, colorFilter: ColorFilter.mode(const Color(0xFFEE8E00), BlendMode.srcIn)),
              const SizedBox(height: 8),
              Text(label, style: _poppins(FontWeight.w600, 14, const Color(0xFF1F1F1F))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapPreview(BuildContext context) {
    // Usar una imagen real para el mapa si la tienes, o un placeholder con color
    return Container(
      width: double.infinity,
      height: 121,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // Si tienes una imagen específica para el preview del mapa:
        // image: const DecorationImage(image: AssetImage('assets/images/map_home_preview.png'), fit: BoxFit.cover),
        color: Colors.grey.shade300, // Placeholder color
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))]
      ),
      child: Center(child: Text("Vista Previa del Mapa", style: _poppins(FontWeight.w500, 16, Colors.grey.shade700))),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F))),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Text('Ver más', style: _poppins(FontWeight.w600, 14, const Color(0xFF355E3B))),
        ),
      ],
    );
  }

  Widget _buildChallengeItem({ required String iconAsset, required String title, required String description, required String progress, required String points, bool isSvg = true}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(color: const Color(0xFFE4E9E4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Row(
        children: [
          Column(
            children: [
              isSvg ? SvgPicture.asset(iconAsset, width: 25, height: 36, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn))
                   : Image.asset(iconAsset, width: 25, height: 36),
              const SizedBox(height: 4),
              Text(points, style: _poppins(FontWeight.w700, 16, const Color(0xFFEE8E00))),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _poppins(FontWeight.w600, 16, const Color(0xFF1F1F1F))),
                Text(description, style: _poppins(FontWeight.w400, 12, const Color(0xFF5F6964))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(progress, style: _poppins(FontWeight.w600, 16, const Color(0xFF355E3B))),
          const SizedBox(width: 8),
          // Asumiendo 'buttonflecha.svg' es el icono de flecha
          SvgPicture.asset('assets/buttonflecha.svg', width: 16, height: 16, colorFilter: ColorFilter.mode(const Color(0xFF5F6964), BlendMode.srcIn)),
        ],
      ),
    );
  }

   Widget _buildTipItem({ String? assetPath, bool isSvg = true, required String title, required String description }) {
    Widget iconWidget;
    if (assetPath != null) {
      iconWidget = isSvg
          ? SvgPicture.asset(assetPath, width: 32, height: 32, colorFilter: ColorFilter.mode(const Color(0xFF355E3B), BlendMode.srcIn))
          : Image.asset(assetPath, width: 32, height: 32);
    } else {
      iconWidget = const SizedBox(width: 32, height: 32); // Placeholder si no hay asset
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(color: const Color(0xFFE4E9E4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _poppins(FontWeight.w600, 16, const Color(0xFF1F1F1F))),
                Text(description, style: _poppins(FontWeight.w400, 12, const Color(0xFF5F6964))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset('assets/buttonflecha.svg', width: 16, height: 16, colorFilter: ColorFilter.mode(const Color(0xFF5F6964), BlendMode.srcIn)),
        ],
      ),
    );
  }

  Widget _buildActualBottomNavigationBar(BuildContext context) {
    int currentIndex = 0;

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
            Expanded(child: _bottomNavItem(context, icon: Icons.home_filled, label: 'Inicio', isSelected: currentIndex == 0, onTap: () {})),
            Expanded(child: _bottomNavItem(context, icon: Icons.map_outlined, label: 'Mapa', isSelected: currentIndex == 1, onTap: () { /* Navigator.pushNamed(context, '/mapa'); */ })),
            const SizedBox(width: 48),
            Expanded(child: _bottomNavItem(context, icon: Icons.list_alt_outlined, label: 'Retos', isSelected: currentIndex == 2, onTap: () { Navigator.pushNamed(context, '/challenges'); })),
            Expanded(child: _bottomNavItem(context, icon: Icons.person_outline, label: 'Perfil', isSelected: currentIndex == 3, onTap: () { /* Navigator.pushNamed(context, '/perfil'); */ })),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, {required IconData icon, required String label, bool isSelected = false, required VoidCallback onTap}) {
    final color = isSelected ? const Color(0xFF1F1F1F) : const Color(0xFF9EB3A9);
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
              Text(label, style: _poppins(fontWeight, 11.5, color), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}