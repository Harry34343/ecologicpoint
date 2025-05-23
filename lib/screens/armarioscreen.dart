import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:a/widgets/button.dart'
    as button; // Assuming this path is correct
import 'package:google_fonts/google_fonts.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // By returning the child directly, we don't build the default overscroll indicator.
    return child;
  }
}

class ArmarioScreen extends StatefulWidget {
  const ArmarioScreen({super.key});

  @override
  State<ArmarioScreen> createState() => _ArmarioScreenState();
}

class _ArmarioScreenState extends State<ArmarioScreen> {
  int categoriaSeleccionada = 0;

  void actualizarRecientes() {
    final recientes = <Map<String, dynamic>>[];

    itemsPorCategoria.forEach((categoria, items) {
      if (categoria != 'Reciente') {
        for (var item in items) {
          if (item['selected'] == true) {
            recientes.add({
              ...item,
            }); // Copiamos el mapa para evitar modificar original
          }
        }
      }
    });

    setState(() {
      itemsPorCategoria['Reciente'] = recientes;
    });
  }

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
      {'img': 'assets/plantas/plantita.png', 'selected': false},
      {'img': 'assets/plantas/plantita2.png', 'selected': false},
      {'img': 'assets/plantas/plantita3.png', 'selected': false},
      {'img': 'assets/plantas/plantita4.png', 'selected': false},
      {'img': 'assets/plantas/plantita5.png', 'selected': false},
    ],
    'Planta': [
      {'img': 'assets/plantas/plantauno.svg', 'selected': false},
      {'img': 'assets/plantas/plantados.svg', 'selected': false},
      {'img': 'assets/plantas/plantatres.svg', 'selected': false},
      {'img': 'assets/plantas/planta4.svg', 'selected': false},
      {'img': 'assets/plantas/planta5.svg', 'selected': false},
      {'img': 'assets/plantas/planta6.svg', 'selected': false},
      {'img': 'assets/plantas/planta7.svg', 'selected': false},
      // Add more items if needed for testing layout
    ],
    'Sombrero': [
      {'img': 'assets/sombreros/cono.svg', 'selected': false},
      {'img': 'assets/sombreros/beanie.svg', 'selected': false},
      {'img': 'assets/sombreros/cowboy.svg', 'selected': false},
      {'img': 'assets/sombreros/halo.svg', 'selected': false},
      {'img': 'assets/sombreros/monho.svg', 'selected': false},
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
          body: Container(
            color: Colors.transparent, // Color del fondo deseado
            child: Stack(
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
                                SizedBox(width: relWidth(4)),
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
                        flex: 2,
                        child: Column(
                          children: [
                            // ZONA DE BOTONES (color más grisáceo)
                            Container(
                              color: Color.fromRGBO(229, 233, 228, 1),
                              padding: EdgeInsets.symmetric(
                                vertical: relHeight(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(categorias.length, (
                                  index,
                                ) {
                                  final isSelected =
                                      categoriaSeleccionada == index;

                                  final backgroundColor =
                                      isSelected
                                          ? const Color.fromRGBO(
                                            168,
                                            198,
                                            134,
                                            1,
                                          )
                                          : Colors.transparent;

                                  final iconColor =
                                      isSelected
                                          ? const Color.fromRGBO(
                                            247,
                                            246,
                                            235,
                                            1,
                                          )
                                          : Color.fromRGBO(53, 94, 59, 1);

                                  return GestureDetector(
                                    onTap: () {
                                      setState(
                                        () => categoriaSeleccionada = index,
                                      );
                                    },
                                    child: Container(
                                      width: relWidth(40),
                                      height: relHeight(40),
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: _iconoCategoria(
                                          categorias[index],
                                          iconColor,
                                          20,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),

                            // ZONA DE ITEMS (color más crema)
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: relHeight(15)),
                                color: Colors.transparent,
                                child: ScrollConfiguration(
                                  behavior: const NoGlowScrollBehavior(),
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: relWidth(16),
                                        right: relWidth(16),
                                        top: relHeight(10),
                                        bottom: relHeight(0),
                                      ),
                                      child: Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        alignment: WrapAlignment.center,
                                        children:
                                            items.asMap().entries.map((entry) {
                                              final i = entry.key;
                                              final item = entry.value;
                                              return ItemEquipado(
                                                imagen: item['img'],
                                                seleccionado: item['selected'],
                                                Categoria: categoriaActual,
                                                onTap: () {
                                                  setState(() {
                                                    item['selected'] =
                                                        !item['selected'];
                                                    actualizarRecientes(); // <- aquí actualizamos Reciente
                                                  });
                                                },
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Returns either an [IconData] or a String asset path for SVG.
  Widget _iconoCategoria(String categoria, Color color, double size) {
    switch (categoria) {
      case 'Reciente':
        return Icon(Icons.grid_view_rounded, size: size, color: color);
      case 'Planta':
        return SvgPicture.asset(
          'assets/plantarr.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case 'Sombrero':
        return SvgPicture.asset(
          'assets/sombrero.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case 'Cara':
        return SvgPicture.asset(
          'assets/cara.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case 'Cuerpo':
        return SvgPicture.asset(
          'assets/torso.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      default:
        return Icon(Icons.help_outline, size: size, color: color);
    }
  }
}

// ... (rest of your ArmarioScreen code remains the same) ...

class ItemEquipado extends StatelessWidget {
  final String imagen;
  final bool seleccionado;
  final VoidCallback onTap;
  final String Categoria;

  const ItemEquipado({
    super.key,
    required this.imagen,
    required this.seleccionado,
    required this.onTap,
    required this.Categoria,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemSize = screenWidth * 0.25;

    final double scale =
        (Categoria == 'Sombrero' ||
                Categoria == 'Cara' ||
                Categoria == 'Cuerpo')
            ? 0.6
            : 0.8;

    final Widget imageWidget =
        imagen.toLowerCase().endsWith('.svg')
            ? SvgPicture.asset(
              imagen,
              width: itemSize * 0.8,
              height: itemSize * 0.8,
            )
            : Image.asset(
              imagen,
              width: 80 * scale,
              height: 80 * scale,
              fit: BoxFit.contain,
            );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(229, 233, 228, 1),
          border: Border.all(
            color:
                seleccionado ? const Color(0xFFBDD8A6) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment:
                  (Categoria == 'Sombrero' ||
                          Categoria == 'Cara' ||
                          Categoria == 'Cuerpo')
                      ? Alignment.center
                      : Alignment.bottomCenter,
              child: imageWidget,
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
      ),
    );
  }
}
