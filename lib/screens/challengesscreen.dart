// lib/screens/challengesscreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/challenges_filter_provider.dart'; // Ajusta si la ruta es diferente
import 'profilescreen.dart';
import 'package:a/widgets/navegationbarhome.dart' as navBar;

// --- INICIO DE DATOS ---
class ChallengeData {
  final String iconAssetPath;
  final String title;
  final String description;
  final String points;
  final int currentProgress;
  final int totalProgress;
  final bool isSvg;

  ChallengeData({
    required this.iconAssetPath,
    required this.title,
    required this.description,
    required this.points,
    required this.currentProgress,
    required this.totalProgress,
    this.isSvg = true,
  });

  String get progressText => '$currentProgress/$totalProgress';
}

// Lista de datos iniciales con rutas de assets actualizadas
// ¡¡DEBES VERIFICAR QUE ESTOS ARCHIVOS EXISTAN EN assets/ Y QUE SEAN LOS CORRECTOS PARA CADA RETO!!
final List<ChallengeData> initialChallengesData = [
  // Retos NUEVOS
  ChallengeData(
    iconAssetPath: 'assets/logo.svg',
    title: 'Reciclador Maestro',
    description:
        'Clasifica y lleva 5 tipos diferentes de residuos a un punto de reciclaje esta semana.',
    points: '+75',
    currentProgress: 0,
    totalProgress: 5,
  ), // Usando 'logo.svg' como placeholder
  ChallengeData(
    iconAssetPath: 'assets/gota.svg',
    title: 'Campeón del Ahorro de Agua',
    description: 'Implementa 3 nuevas medidas para ahorrar agua en tu hogar.',
    points: '+50',
    currentProgress: 0,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/cactus.svg',
    title: 'Rey/Reina del Compost',
    description:
        'Inicia una pila de compost y añade residuos orgánicos durante 2 semanas seguidas.',
    points: '+40',
    currentProgress: 0,
    totalProgress: 2,
  ), // Usando un asset de planta
  ChallengeData(
    iconAssetPath: 'assets/phplantduotone.svg',
    title: 'Ciclista Urbano Dedicado',
    description:
        'Usa la bicicleta como tu principal medio de transporte por 5 días.',
    points: '+80',
    currentProgress: 0,
    totalProgress: 5,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/sprout.svg',
    title: 'Sembrador de Futuro',
    description:
        'Participa en una jornada de reforestación o planta 2 árboles nativos.',
    points: '+90',
    currentProgress: 0,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/logo2.svg',
    title: 'Alquimista de la Limpieza Eco',
    description:
        'Prepara y utiliza 2 productos de limpieza caseros y ecológicos.',
    points: '+30',
    currentProgress: 0,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/planetal.svg',
    title: 'Lunes Sin Carne Comprometido',
    description: 'No consumas carne durante 4 lunes consecutivos.',
    points: '+70',
    currentProgress: 0,
    totalProgress: 4,
  ),
  ChallengeData(
    iconAssetPath: 'assets/armarioicon.svg',
    title: 'Detox de Moda Rápida',
    description: 'Abstente de comprar ropa nueva durante un mes.',
    points: '+100',
    currentProgress: 0,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/tiendaicon.svg',
    title: 'Limpieza Digital Ecológica',
    description:
        'Elimina suscripciones de correo innecesarias y borra archivos de la nube.',
    points: '+20',
    currentProgress: 0,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/sombrero.svg',
    title: 'Embajador Ecológico',
    description:
        'Explica a un amigo la importancia de un reto y anímale a participar.',
    points: '+50',
    currentProgress: 0,
    totalProgress: 1,
  ),

  // Retos ACTIVOS
  ChallengeData(
    iconAssetPath: 'assets/logo.svg',
    title: 'Guardián del Parque Extremo',
    description:
        'Organiza o participa en una limpieza comunitaria recolectando 10 bolsas de basura.',
    points: '+150',
    currentProgress: 3,
    totalProgress: 10,
  ),
  ChallengeData(
    iconAssetPath: 'assets/botella.svg',
    title: 'Rescate Tecnológico Total',
    description: 'Lleva 3 dispositivos electrónicos viejos a reciclar.',
    points: '+60',
    currentProgress: 1,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/logo2.svg',
    title: 'Experto en Eficiencia Energética',
    description: 'Reduce tu consumo eléctrico en un 10% este mes.',
    points: '+100',
    currentProgress: 0,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/bolas.svg',
    title: 'Semana Sin Plástico de un Solo Uso',
    description: 'Evita plásticos de un solo uso durante 7 días.',
    points: '+120',
    currentProgress: 2,
    totalProgress: 7,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/girasol.svg',
    title: 'Explorador Gastronómico Local',
    description: 'Prepara 3 comidas con ingredientes locales.',
    points: '+65',
    currentProgress: 1,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/logo.svg',
    title: 'Intercambio Literario Sostenible',
    description: 'Organiza o participa en un intercambio de 3 libros.',
    points: '+25',
    currentProgress: 1,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/lotus.svg',
    title: 'Horticultor de Ventana',
    description: 'Cultiva 2 tipos de hierbas o vegetales.',
    points: '+35',
    currentProgress: 1,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/phplantduotone.svg',
    title: 'Profesional del Transporte Público',
    description: 'Usa solo transporte público por 3 días laborables.',
    points: '+55',
    currentProgress: 1,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/carnivora.svg',
    title: 'Amigo de las Aves Urbanas',
    description:
        'Construye/instala un comedero y mantenlo con alimento una semana.',
    points: '+45',
    currentProgress: 0,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/logo.svg',
    title: 'Almuerzo Cero Residuos',
    description: 'Prepara almuerzo sin generar basura por 3 días.',
    points: '+60',
    currentProgress: 1,
    totalProgress: 3,
  ),

  // Retos COMPLETADOS
  ChallengeData(
    iconAssetPath: 'assets/logo.svg',
    title: 'Reciclador Semanal Cumplido',
    description: 'Llevaste 5 tipos de residuos a reciclar la semana pasada.',
    points: '+75',
    currentProgress: 5,
    totalProgress: 5,
  ),
  ChallengeData(
    iconAssetPath: 'assets/gota.svg',
    title: 'Ahorrador de Agua Verificado',
    description: 'Implementaste 3 medidas de ahorro de agua.',
    points: '+50',
    currentProgress: 3,
    totalProgress: 3,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/bambu.svg',
    title: 'Compostador Establecido',
    description: 'Compostaste orgánicos por 2 semanas.',
    points: '+40',
    currentProgress: 2,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/phplantduotone.svg',
    title: 'Meta Ciclista Alcanzada',
    description: 'Usaste la bicicleta por 5 días.',
    points: '+80',
    currentProgress: 5,
    totalProgress: 5,
  ),
  ChallengeData(
    iconAssetPath: 'assets/plantas/sprout.svg',
    title: '¡Árboles Plantados!',
    description: 'Plantaste 2 árboles nativos.',
    points: '+90',
    currentProgress: 2,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/logo2.svg',
    title: 'Maestro Limpiador Eco',
    description: 'Creaste 2 productos de limpieza caseros.',
    points: '+30',
    currentProgress: 2,
    totalProgress: 2,
  ),
  ChallengeData(
    iconAssetPath: 'assets/planetal.svg',
    title: 'Lunes Verdes Superados',
    description: 'Cumpliste 4 Lunes Sin Carne.',
    points: '+70',
    currentProgress: 4,
    totalProgress: 4,
  ),
  ChallengeData(
    iconAssetPath: 'assets/armarioicon.svg',
    title: 'Mes de Moda Consciente',
    description: 'Superaste el mes sin comprar ropa nueva.',
    points: '+100',
    currentProgress: 1,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/tiendaicon.svg',
    title: 'Bandeja de Entrada Limpia',
    description: 'Redujiste tu huella digital.',
    points: '+20',
    currentProgress: 1,
    totalProgress: 1,
  ),
  ChallengeData(
    iconAssetPath: 'assets/sombrero.svg',
    title: 'Influencer Positivo',
    description: 'Inspiraste a un amigo con un reto ecológico.',
    points: '+50',
    currentProgress: 1,
    totalProgress: 1,
  ),
];

// --- FIN DE DATOS ---
class ChallengesScreen extends StatefulWidget {
  // CHANGED to StatefulWidget
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState(); // CHANGED
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  int _selectedIndex =
      3; // <<--- Challenges screen is index 3 (0:Home, 1:Mapa, 2:Planta/FAB, 3:Retos, 4:Perfil)
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
    final challengesProvider = context.watch<ChallengesFilterProvider>();
    final displayedChallenges = challengesProvider.filteredChallenges;
    final selectedTabIndex = challengesProvider.selectedTabIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F6EA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: const Color(0xFF1F1F1F)),
          onPressed: () {
            /* Scaffold.of(context).openDrawer(); */
          },
        ),
        title: Text(
          'Retos',
          style: _poppins(FontWeight.w600, 20, const Color(0xFF1F1F1F)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: const Color(0xFF355E3B), size: 28),
            onPressed: () {
              /* Acción de búsqueda */
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilterTabs(context, selectedTabIndex, challengesProvider),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedTabIndex == 0
                          ? 'Todos los retos'
                          : (selectedTabIndex == 1
                              ? 'Retos Activos'
                              : 'Retos Completados'),
                      style: _poppins(
                        FontWeight.w600,
                        20,
                        const Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (displayedChallenges.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: Center(
                          child: Text(
                            selectedTabIndex == 1
                                ? "¡No hay retos activos en este momento!"
                                : (selectedTabIndex == 2
                                    ? "Aún no has completado ningún reto."
                                    : "No hay retos disponibles."),
                            style: _poppins(
                              FontWeight.w400,
                              16,
                              Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayedChallenges.length,
                        itemBuilder: (context, index) {
                          final challenge = displayedChallenges[index];
                          return _buildChallengeCard(challenge);
                        },
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
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

  Widget _buildFilterTabs(
    BuildContext context,
    int currentSelectedTabIndex,
    ChallengesFilterProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _filterTabItem("Todos", 0, currentSelectedTabIndex, provider),
            _filterTabItem("Activos", 1, currentSelectedTabIndex, provider),
            _filterTabItem("Completados", 2, currentSelectedTabIndex, provider),
          ],
        ),
      ),
    );
  }

  Widget _filterTabItem(
    String label,
    int index,
    int currentSelectedTabIndex,
    ChallengesFilterProvider provider,
  ) {
    bool isSelected = currentSelectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.selectTab(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF355E3B) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: _poppins(
              FontWeight.w600,
              14,
              isSelected
                  ? Colors.white
                  : const Color(0xFF355E3B).withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeCard(ChallengeData challenge) {
    bool isCompleted =
        challenge.currentProgress == challenge.totalProgress &&
        challenge.totalProgress > 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFE4E9E4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              challenge.isSvg
                  ? SvgPicture.asset(
                    challenge.iconAssetPath,
                    width: 36,
                    height: 36,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF355E3B),
                      BlendMode.srcIn,
                    ) /* Añadido colorFilter si es necesario */,
                  )
                  : Image.asset(challenge.iconAssetPath, width: 36, height: 36),
              const SizedBox(height: 4),
              Text(
                challenge.points,
                style: _poppins(FontWeight.w700, 14, const Color(0xFFEE8E00)),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.title,
                  style: _poppins(FontWeight.w600, 16, const Color(0xFF1F1F1F)),
                ),
                const SizedBox(height: 2),
                Text(
                  challenge.description,
                  style: _poppins(FontWeight.w400, 12, const Color(0xFF5F6964)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          isCompleted
              ? Icon(Icons.check_circle, color: Colors.green.shade600, size: 24)
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    challenge.progressText,
                    style: _poppins(
                      FontWeight.w600,
                      16,
                      const Color(0xFF355E3B),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          const SizedBox(width: 8),
          if (!isCompleted)
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: const Color(0xFF5F6964),
            ),
          if (isCompleted)
            const SizedBox(width: 18), // Mantener el espacio si no hay flecha
        ],
      ),
    );
  }

  Widget _buildActualBottomNavigationBar(BuildContext context) {
    int currentIndex = 2; // Retos

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
                onTap: () {},
              ),
            ),
            const SizedBox(width: 48),
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.list_alt_outlined,
                label: 'Retos',
                isSelected: currentIndex == 2,
                onTap: () {},
              ),
            ),
            Expanded(
              child: _bottomNavItem(
                context,
                icon: Icons.person_outline,
                label: 'Perfil',
                isSelected: currentIndex == 3,
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
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
