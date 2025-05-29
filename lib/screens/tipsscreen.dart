// lib/screens/tipsscreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// --- INICIO DE DATOS ---
class TipData {
  final String iconAssetPath;
  final String title;
  final String description;
  final bool isSvg;

  TipData({
    required this.iconAssetPath,
    required this.title,
    required this.description,
    this.isSvg = true,
  });
}

// ¡¡DEBES VERIFICAR QUE ESTOS ARCHIVOS EXISTAN EN assets/ Y QUE SEAN LOS CORRECTOS PARA CADA TIP!!
final List<TipData> _unlockedTips = [
  TipData(iconAssetPath: 'assets/planeta.svg', title: '¿Sabías que…?', description: 'Un solo árbol puede absorber hasta 22 kg de CO₂ al año.', isSvg: true),
  TipData(iconAssetPath: 'assets/gota.svg', title: 'Cada gota cuenta', description: 'Dejar el grifo abierto mientras te cepillas puede desperdiciar hasta 20 litros de agua.', isSvg: true),
  TipData(iconAssetPath: 'assets/botella.svg', title: 'El plástico no desaparece', description: 'Una botella de plástico puede tardar más de 400 años en degradarse.', isSvg: true),
  TipData(iconAssetPath: 'assets/logo2.svg', title: 'Energía Fantasma', description: 'Los aparatos en standby consumen energía. ¡Desenchúfalos!', isSvg: true),
  TipData(iconAssetPath: 'assets/plantas/cactus.svg', title: 'Menos Carne, Más Planeta', description: 'Reducir el consumo de carne disminuye tu huella hídrica y de carbono.', isSvg: true),
  TipData(iconAssetPath: 'assets/phplantduotone.svg', title: 'Transporte Sostenible', description: 'Camina, usa bici o transporte público para reducir emisiones.', isSvg: true),
  TipData(iconAssetPath: 'assets/armarioicon.svg', title: 'Moda Consciente', description: 'Opta por ropa de segunda mano o marcas sostenibles.', isSvg: true),
  TipData(iconAssetPath: 'assets/tiendaicon.svg', title: 'Compra Local', description: 'Apoya a los productores locales y reduce el transporte de alimentos.', isSvg: true),
  TipData(iconAssetPath: 'assets/sombrero.svg', title: 'Reutiliza y Repara', description: 'Antes de desechar, piensa si puedes darle una segunda vida o arreglarlo.', isSvg: true),
  TipData(iconAssetPath: 'assets/plantas/girasol.svg', title: 'Biodiversidad en Casa', description: 'Planta flores nativas para atraer polinizadores a tu jardín o balcón.', isSvg: true),
  TipData(iconAssetPath: 'assets/logo.svg', title: 'Papel Inteligente', description: 'Imprime a doble cara y recicla todo el papel que puedas.', isSvg: true),
  TipData(iconAssetPath: 'assets/gota.svg', title: 'Fugas Silenciosas', description: 'Revisa periódicamente grifos e inodoros para detectar fugas de agua.', isSvg: true),
  TipData(iconAssetPath: 'assets/botella.svg', title: 'Evita los Microplásticos', description: 'Elige cosméticos y ropa sin microplásticos que contaminan el agua.', isSvg: true),
  TipData(iconAssetPath: 'assets/logo2.svg', title: 'Luz Natural al Máximo', description: 'Aprovecha la luz del día y reduce el uso de luz artificial.', isSvg: true),
  TipData(iconAssetPath: 'assets/plantas/lotus.svg', title: 'Compostaje Casero', description: 'Transforma tus residuos orgánicos en abono nutritivo para tus plantas.', isSvg: true),
  TipData(iconAssetPath: 'assets/phplantduotone.svg', title: 'Conducción Eficiente', description: 'Mantén la velocidad constante y evita acelerones para ahorrar combustible.', isSvg: true),
  TipData(iconAssetPath: 'assets/armarioicon.svg', title: 'Dona lo que no Usas', description: 'La ropa, libros o juguetes en buen estado pueden servir a otros.', isSvg: true),
  TipData(iconAssetPath: 'assets/tiendaicon.svg', title: 'Reduce el Desperdicio Alimentario', description: 'Planifica tus compras, aprovecha las sobras y conserva bien los alimentos.', isSvg: true),
  TipData(iconAssetPath: 'assets/sombrero.svg', title: 'Educación Ambiental Continua', description: 'Sigue aprendiendo sobre sostenibilidad y comparte tus conocimientos.', isSvg: true),
  TipData(iconAssetPath: 'assets/plantas/sprout.svg', title: 'Pequeñas Acciones, Gran Impacto', description: 'Cada gesto cuenta en la construcción de un futuro más sostenible.', isSvg: true),
];
// --- FIN DE DATOS ---


class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F6EA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF1F1F1F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Tips',
          style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: const Color(0xFF355E3B), size: 28),
            onPressed: () { /* Acción de búsqueda */ },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tips desbloqueados',
                style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F)),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _unlockedTips.length,
                itemBuilder: (context, index) {
                  final tip = _unlockedTips[index];
                  return _buildTipCard(tip);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 12),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFA8C686),
        elevation: 4.0,
        shape: const CircleBorder(),
        child: SvgPicture.asset('assets/logo.svg', width: 28, height: 28, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      ),
      bottomNavigationBar: _buildActualBottomNavigationBar(context),
    );
  }

  Widget _buildTipCard(TipData tip) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFE4E9E4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tip.isSvg
              ? SvgPicture.asset(tip.iconAssetPath, width: 32, height: 32, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn) /* Aplicar color si es SVG */)
              : Image.asset(tip.iconAssetPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: _poppins(FontWeight.w600, 16, const Color(0xFF1F1F1F)),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: _poppins(FontWeight.w400, 12, const Color(0xFF5F6964)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActualBottomNavigationBar(BuildContext context) {
    // En TipsScreen, el ítem "Inicio" podría seguir activo visualmente, o ningún ítem.
    // Si tuvieras una pestaña "Tips" en la barra, la seleccionarías.
    // Por ahora, asumimos que "Inicio" es la referencia.
    int currentIndex = 0; // 0 para Inicio

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
            Expanded(child: _bottomNavItem(context, icon: Icons.home_filled, label: 'Inicio', isSelected: currentIndex == 0, onTap: () { if (ModalRoute.of(context)?.settings.name != '/home') {Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);}})),
            Expanded(child: _bottomNavItem(context, icon: Icons.map_outlined, label: 'Mapa', isSelected: currentIndex == 1, onTap: () {})),
            const SizedBox(width: 48),
            Expanded(child: _bottomNavItem(context, icon: Icons.list_alt_outlined, label: 'Retos', isSelected: currentIndex == 2, onTap: () { if (ModalRoute.of(context)?.settings.name != '/challenges') {Navigator.pushReplacementNamed(context, '/challenges');}})),
            Expanded(child: _bottomNavItem(context, icon: Icons.person_outline, label: 'Perfil', isSelected: currentIndex == 3, onTap: () {})),
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