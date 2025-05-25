import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Necesitarás el paquete flutter_svg para los SVGs

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper para los estilos de texto para no repetirlos tanto
  TextStyle _poppins(FontWeight fontWeight, double fontSize, Color color) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // El código de Figma usa un ancho fijo de 440, lo que no es ideal.
    // Usaremos el ancho de la pantalla pero mantendremos algunos paddings.
    // El padding horizontal general parece ser de 24.
    final contentWidth = screenWidth - 48;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6EA), // Color de fondo general
      body: SafeArea( // Para evitar el notch y la barra de estado del sistema
        child: Stack( // Stack para la barra de navegación inferior y el contenido
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildCustomAppBar(context),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderCard(context, contentWidth),
                        const SizedBox(height: 32),
                        _buildActionButtons(context, contentWidth),
                        const SizedBox(height: 32),
                        _buildMapPreview(context, contentWidth),
                        const SizedBox(height: 32),
                        _buildSectionTitle("Mis retos", () { /* Acción Ver más */ }),
                        const SizedBox(height: 12),
                        _buildChallengeItem(
                          iconAsset: 'assets/logo2.svg', // Reemplaza con tu asset
                          title: 'Reciclador en Acción',
                          description: 'Lleva 3 tipos de residuos a un punto de reciclaje.',
                          progress: '0/3',
                          points: '+ 50',
                        ),
                        const SizedBox(height: 12),
                        _buildChallengeItem(
                          iconAsset: 'assets/logo2.svg', // Reemplaza con tu asset
                          title: 'Guardián del Parque',
                          description: 'Recolecta 5 basuras en un espacio verde cercano.',
                          progress: '0/5',
                          points: '+ 50',
                        ),
                        const SizedBox(height: 12),
                        _buildChallengeItem(
                          iconAsset: 'assets/logo2.svg', // Reemplaza con tu asset
                          title: 'Tech Salvado',
                          description: 'Recicla un electrónico viejo en un centro autorizado.',
                          progress: '0/1',
                          points: '+ 50',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionTitle("Mis tips", () { /* Acción Ver más */ }),
                        const SizedBox(height: 12),
                        _buildTipItem(
                          assetPath: 'assets/icons/planeta.svg', // Reemplaza con tu icono/asset (mundo)
                          title: '¿Sabías que…?',
                          description: 'Un solo árbol puede absorber hasta 22 kg de CO₂ al año.',
                        ),
                        const SizedBox(height: 12),
                        _buildTipItem(
                          assetPath: 'assets/icons/gota.svg', // Reemplaza (gota)
                          title: 'Cada gota cuenta',
                          description: 'Dejar el grifo abierto mientras te cepillas puede desperdiciar hasta 20 litros de agua.',
                        ),
                        const SizedBox(height: 12),
                        _buildTipItem(
                          assetPath: 'assets/icons/botella.svg', // Reemplaza (botella)
                          title: 'El plástico no desaparece',
                          description: 'Una botella de plástico puede tardar más de 400 años en degradarse.',
                        ),
                        const SizedBox(height: 80), // Espacio para la barra de navegación inferior
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildCustomBottomNavigationBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    // La barra de estado con la hora (9:41) usualmente la maneja el sistema.
    // Nos enfocaremos en la barra de la app "EcologicPoint+"
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(color: Color(0xFFE4E9E4)), // Coincide con la imagen
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Asumiendo que tienes un logo en SVG o PNG
              SvgPicture.asset('assets/logo2.svg', width: 25, height: 32, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn)), // Reemplaza
              const SizedBox(width: 8),
              Text(
                'EcologicPoint+',
                style: TextStyle(
                  color: const Color(0xFF355E3B),
                  fontSize: 20,
                  fontFamily: 'Agbalumo', // Asegúrate de tener esta fuente
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded, color: const Color(0xFFEE8E00), size: 20),
              const SizedBox(width: 4),
              Text(
                '25',
                style: _poppins(FontWeight.w700, 16, const Color(0xFFEE8E00)),
              ),
              const SizedBox(width: 24),
              SvgPicture.asset('assets/logo2.svg', width: 14, height: 20, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn)), // Reemplaza
              const SizedBox(width: 8),
              Text(
                '1500',
                style: _poppins(FontWeight.w700, 16, const Color(0xFF355E3B)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, double contentWidth) {
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
        clipBehavior: Clip.none, // Permitir que el cactus se salga un poco si es necesario
        children: [
          // Aquí iría el patrón de hojas de fondo si es una imagen separada
          // Positioned.fill(child: Image.asset('assets/images/leaf_pattern_background.png', fit: BoxFit.cover)),

          Positioned(
            left: 20,
            bottom: -10, // Ajusta para que la base de la maceta esté alineada o un poco por debajo
            child: SvgPicture.asset(
              'assets/plantas/cactus.svg', // REEMPLAZA con tu imagen de cactus
              width: 100, // Ajusta el tamaño
              height: 150, // Ajusta el tamaño
            ),
          ),
          Positioned(
            left: 110, // Ajustar basado en el tamaño del cactus
            top: 25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12), // O diferente si es una burbuja de chat
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '¡Hola, ', style: _poppins(FontWeight.w700, 16, const Color(0xFF1F1F1F))),
                    TextSpan(text: 'Marco228', style: _poppins(FontWeight.w700, 16, const Color(0xFF688549))),
                    TextSpan(text: '!', style: _poppins(FontWeight.w700, 16, const Color(0xFF1F1F1F))),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 70, // Ajustar
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFA8C686), // Color del Figma
                borderRadius: BorderRadius.circular(12),
                boxShadow: [ // Sombra sutil
                   BoxShadow(
                     color: const Color(0xFF355E3B).withOpacity(0.5),
                     offset: const Offset(0, 2),
                     blurRadius: 0
                   )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildActionButtons(BuildContext context, double contentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionButton(icon: Icons.store_mall_directory_outlined, label: 'Tienda', onTap: () {}),
        _actionButton(icon: Icons.checkroom_outlined, label: 'Armario', onTap: () {}),
        _actionButton(icon: Icons.tips_and_updates_outlined, label: 'Tips', onTap: () {}),
      ],
    );
  }

  Widget _actionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded( // Para que ocupen el espacio equitativamente
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5), // Pequeño espacio entre ellos
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7F6EA),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadows: [
              BoxShadow(
                color: const Color(0x4C9EB3A9),
                blurRadius: 12,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFFEE8E00), size: 24), // Color naranja de los iconos
              const SizedBox(height: 8),
              Text(label, style: _poppins(FontWeight.w600, 14, const Color(0xFF1F1F1F))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapPreview(BuildContext context, double contentWidth) {
    return Container(
      width: double.infinity,
      height: 121,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/map_preview.png'), // REEMPLAZA con tu asset de mapa
          fit: BoxFit.cover,
        ),
         boxShadow: [ // Sombra sutil
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ]
      ),
      // child: Center(child: Text('Map Preview Placeholder', style: TextStyle(color: Colors.white))),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onVerMas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F))),
        TextButton(
          onPressed: onVerMas,
          child: Text(
            'Ver más',
            style: _poppins(FontWeight.w600, 14, const Color(0xFF355E3B)),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeItem({
    required String iconAsset,
    required String title,
    required String description,
    required String progress,
    required String points,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFFE4E9E4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Column(
            children: [
              SvgPicture.asset(iconAsset, width: 25, height: 36, colorFilter: ColorFilter.mode(Color(0xFF355E3B), BlendMode.srcIn)), // Reemplaza
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
          Text(progress, style: _poppins(FontWeight.w600, 16, const Color(0xFF355E3B))), // Asumiendo que '0' es verde y '/3' es gris claro
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16, color: const Color(0xFF5F6964)),
        ],
      ),
    );
  }

   Widget _buildTipItem({ // ESTA ES LA NUEVA DEFINICIÓN
    IconData? icon,
    String? assetPath,
    required String title,
    required String description,
  }) {
    assert(icon != null || assetPath != null, 'Debes proporcionar un IconData o un assetPath');
    assert(!(icon != null && assetPath != null), 'No puedes proporcionar IconData y assetPath al mismo tiempo');

    Widget iconWidget;
    if (assetPath != null) {
      iconWidget = SvgPicture.asset(
        assetPath,
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(const Color(0xFF355E3B), BlendMode.srcIn),
      );
    } else {
      iconWidget = Icon(icon!, size: 32, color: const Color(0xFF355E3B));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFFE4E9E4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          iconWidget, // Usa el widget de icono que hemos determinado
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
          Icon(Icons.arrow_forward_ios, size: 16, color: const Color(0xFF5F6964)),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavigationBar(BuildContext context) {
    // Esta es una implementación simplificada. Una real manejaría el estado del ítem seleccionado.
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 72, // Altura de la barra de navegación
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6EA), // Color de fondo de la barra de navegación
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2), // Sombra hacia arriba
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none, // Para que el FAB se salga
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bottomNavItem(context, icon: Icons.home_filled, label: 'Inicio', isSelected: true, onTap: () {}),
                _bottomNavItem(context, icon: Icons.map_outlined, label: 'Mapa', onTap: () {}),
                const SizedBox(width: 54), // Espacio para el FAB
                _bottomNavItem(context, icon: Icons.list_alt_outlined, label: 'Retos', onTap: () {}),
                _bottomNavItem(context, icon: Icons.person_outline, label: 'Perfil', onTap: () {}),
              ],
            ),
            Positioned(
              top: -27, // Para que la mitad del FAB esté arriba de la barra
              left: MediaQuery.of(context).size.width / 2 - 27, // Centrar el FAB (54/2)
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: const Color(0xFFA8C686),
                elevation: 4.0,
                child: SvgPicture.asset('assets/icons/fab_leaf.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)), // Reemplaza
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, {required IconData icon, required String label, bool isSelected = false, required VoidCallback onTap}) {
    final color = isSelected ? const Color(0xFF1F1F1F) : const Color(0xFF9EB3A9);
    final fontWeight = isSelected ? FontWeight.w600 : FontWeight.w400;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: _poppins(fontWeight, 14, color)),
          ],
        ),
      ),
    );
  }
}