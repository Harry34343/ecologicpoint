import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:a/widgets/button.dart'
    as button; // Assuming this path is correct
import 'package:google_fonts/google_fonts.dart';

class ArmarioScreen extends StatefulWidget {
  const ArmarioScreen({super.key});

  @override
  State<ArmarioScreen> createState() => _ArmarioScreenState();
}

class _ArmarioScreenState extends State<ArmarioScreen> {
  int categoriaSeleccionada = 0;

  final List<String> categorias = [
    'Reciente',
    'Planta',
    'Sombrero',
    'Cara',
    'Cuerpo',
  ];

  final Map<String, List<Map<String, dynamic>>> itemsPorCategoria = {
    'Reciente': [
      {'img': 'assets/plantas/cactus.png', 'selected': true},
    ],
    'Planta': [
      {'img': 'assets/cactus.png', 'selected': false},
      // Add more items if needed for testing layout
    ],
    'Sombrero': [
      {'img': 'assets/cono.png', 'selected': false},
    ],
    'Cara': [
      {'img': 'assets/gafas.png', 'selected': false},
    ],
    'Cuerpo': [
      {'img': 'assets/corbatita.png', 'selected': false},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final categoriaActual = categorias[categoriaSeleccionada];
    final items = itemsPorCategoria[categoriaActual]!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        double relWidth(double w) => screenWidth * (w / 440);
        double relHeight(double h) => screenHeight * (h / 956);

        return Scaffold(
          backgroundColor: const Color(
            0xFFFCFBF3,
          ), // This will be visible if background doesn't cover all or for bottom part
          body: Stack(
            children: [
              // FONDO que cubre HASTA el 70%
              Positioned(
                top:
                    0, // Changed from 10 to 0 if you want it flush from the top
                left: 0,
                right: 0,
                height: screenHeight * 0.70, // Explicitly 70%
                child: SvgPicture.asset(
                  'assets/armariobk.svg',
                  fit: BoxFit.cover, // <<< THIS IS THE KEY CHANGE!
                  // width: screenWidth, // Not strictly needed as Positioned with left/right handles width
                  // and BoxFit.cover will respect the Positioned widget's bounds.
                  // height: screenHeight * 0.7, // Also not strictly needed for SvgPicture itself if Positioned defines height
                ),
              ),

              // Header Section (Your existing code)
              Positioned(
                top: relHeight(24),
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: relHeight(64),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: relWidth(24),
                        child: Container(
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
                      ),
                      Text(
                        'Armario',
                        style: GoogleFonts.poppins(
                          fontSize: relWidth(20),
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(247, 246, 235, 1),
                        ),
                      ),
                      Positioned(
                        right: relWidth(24),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: relWidth(12),
                            vertical: relHeight(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: const Color(0xFF355E3B),
                                size: relWidth(20),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1500',
                                style: GoogleFonts.poppins(
                                  fontSize: relWidth(16),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF355E3B),
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
              Positioned.fill(
                child: Column(
                  children: [
                    SizedBox(
                      height: relHeight(24 + 64 + 10),
                    ), // Approximate height of header + top padding
                    // Mitad superior: planta/personaje centrado
                    // This Expanded will try to take space *within the Column*.
                    // The Column itself is layered on top of the background.
                    Expanded(
                      flex:
                          3, // Adjust flex to control how much space this takes relative to items
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/plantas/cactus.svg',
                          height: relHeight(
                            400,
                          ), // Adjusted from 350 to better fit typical proportions
                        ),
                      ),
                    ),

                    // This content will be at the bottom of the Column.
                    // If the plant and space above take up ~70% of the screen height,
                    // these items will appear in the bottom ~30%.
                    // If the content in this Column is scrollable, items might appear
                    // on top of the Scaffold's background if they scroll past the 70% SVG background.
                    Expanded(
                      flex: 2, // Adjust flex
                      child: Container(
                        color: Color.fromRGBO(247, 246, 235, 1),
                        padding: EdgeInsets.only(
                          bottom: relWidth(16.0),
                        ), // Add some bottom padding
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center, // Center items vertically in their space
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                categorias.length,
                                (index) => IconButton(
                                  onPressed: () {
                                    setState(
                                      () => categoriaSeleccionada = index,
                                    );
                                  },
                                  icon: _iconoCategoria(categorias[index]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              // Allow Wrap to take available space and scroll if needed
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: relWidth(16),
                                  ),
                                  child: Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    alignment: WrapAlignment.center,
                                    children:
                                        items
                                            .map(
                                              (item) => ItemEquipado(
                                                imagen: item['img'],
                                                seleccionado: item['selected'],
                                              ),
                                            )
                                            .toList(),
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
              ),
            ],
          ),
        );
      },
    );
  }

  /// Returns either an [IconData] or a String asset path for SVG.
  Widget _iconoCategoria(String categoria) {
    switch (categoria) {
      case 'Reciente':
        return Icon(Icons.grid_view_rounded, size: 40);
      case 'Planta':
        return SvgPicture.asset(
          'assets/phplantduotone.svg',
          color: const Color(0xFF355E3B),
        ); // Example SVG asset
      case 'Sombrero':
        return SvgPicture.asset('assets/sombrero.svg'); // Example SVG asset
      case 'Cara':
        return SvgPicture.asset('assets/cara.svg'); // Example SVG asset
      case 'Cuerpo':
        return SvgPicture.asset('assets/torso.svg'); // Example SVG asset
      default:
        return Icon(Icons.help_outline);
    }
  }
}

class ItemEquipado extends StatelessWidget {
  final String imagen;
  final bool seleccionado;

  const ItemEquipado({
    super.key,
    required this.imagen,
    this.seleccionado = false,
  });

  @override
  Widget build(BuildContext context) {
    // Using LayoutBuilder to make item size responsive, if desired
    // Or keep fixed size as you had: width: 60, height: 60
    final screenWidth = MediaQuery.of(context).size.width;
    final itemSize = screenWidth * 0.15; // Example: item is 15% of screen width

    return Container(
      width: itemSize, // Example: make item size responsive
      height: itemSize, // Example: make item size responsive
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 233, 228, 1),
        border: Border.all(
          color: seleccionado ? const Color(0xFFBDD8A6) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Optional: add a subtle shadow
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            // Add padding so image doesn't touch border
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              imagen,
              fit:
                  BoxFit
                      .contain, // Ensure image fits well within the padded area
            ),
          ),
          if (seleccionado)
            const Positioned(
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
