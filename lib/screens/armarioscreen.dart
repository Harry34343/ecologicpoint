import 'package:a/widgets/tiendayarmario.dart';
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
  String plantaEquipada = 'assets/plantas/cactus.svg'; // por ejemplo
  String? sombreroEquipado;
  String? caraEquipada;
  String? cuerpoEquipado;
  // DESIGN CONSTANTS (can be defined at the top of your state class or build method)
  final double designPlantDisplayHeight = 400.0;
  // Adjust this if your plant assets are not typically square when at 400px height
  final double designPlantDisplayWidth = 400.0;

  void actualizarRecientes() {
    final recientes = <Map<String, dynamic>>[];

    itemsPorCategoria.forEach((categoria, items) {
      if (categoria != 'Reciente') {
        // Iterate through original categories
        for (var item in items) {
          if (item['selected'] == true) {
            recientes.add({
              ...item, // Copiamos el mapa para evitar modificar original
              'originalCategory': categoria,
            });
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
    'Reciente': [],
    'Planta': [
      {
        'img': 'assets/plantas/plantauno.svg',
        'selected': false,
        'display': 'assets/plantas/cactus.svg',
      },
      {
        'img': 'assets/plantas/plantados.svg',
        'selected': false,
        'display': 'assets/plantas/Girasol.svg',
      },
      {
        'img': 'assets/plantas/plantatres.svg',
        'selected': false,
        'display': 'assets/plantas/sprout.svg',
      },
      {
        'img': 'assets/plantas/plantacuatro.svg',
        'selected': false,
        'display': 'assets/plantas/carnivora.svg',
      },
      {
        'img': 'assets/plantas/plantacinco.svg',
        'selected': false,
        'display': 'assets/plantas/bambu.svg',
      },
      {
        'img': 'assets/plantas/plantaseis.svg',
        'selected': false,
        'display': 'assets/plantas/lotus.svg',
      },
      {
        'img': 'assets/plantas/plantasiete.svg',
        'selected': false,
        'display': 'assets/plantas/Planeta.svg',
      },
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
      {'img': 'assets/cara/gadas.svg', 'selected': false},
      {'img': 'assets/cara/curita.svg', 'selected': false},
      {'img': 'assets/cara/payaso.svg', 'selected': false},
      {'img': 'assets/cara/pestenegra.svg', 'selected': false},
      {'img': 'assets/cara/tapabocasvr1.svg', 'selected': false},
    ],
    'Cuerpo': [
      {'img': 'assets/cuerpo/alas.svg', 'selected': false},
      {'img': 'assets/cuerpo/bufanda.svg', 'selected': false},
      {'img': 'assets/cuerpo/canguro.svg', 'selected': false},
      {'img': 'assets/cuerpo/capa.svg', 'selected': false},
      {'img': 'assets/cuerpo/corbata.svg', 'selected': false},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> multiSlotSombreroConfigs = {
    'assets/plantas/bambu.svg': [
      // Bambu has two slots for the selected sombrero
      {'top': -20, 'left': 64.0, 'scale': 2.0, 'rotation': 0.6}, // Slot 1
      {'top': 48.0, 'left': 104.0, 'scale': 2.0, 'rotation': 0.0}, // Slot 2
    ],
    // Add other plants here if they also have multiple slots for a single type of hat
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCaraConfigs = {
    'assets/plantas/bambu.svg': [
      // Bambu has two slots for the selected cara
      {'top': 80, 'left': -104.0, 'scale': .1, 'rotation': 0},
      {'top': 168.0, 'left': -54.0, 'scale': .1, 'rotation': 0.0}, // Slot 2
    ],
    // Add other plants here if they also have multiple slots for a single type of cara
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCuerpoConfigs = {
    'assets/plantas/bambu.svg': [
      // Bambu has two slots for the selected cuerpo
      {'top': 188, 'left': 64.0, 'scale': 2.0, 'rotation': 0.0},
      {'top': 288, 'left': 118.0, 'scale': 2.0, 'rotation': 0.0},
    ],
    // Add other plants here if they also have multiple slots for a single type of cuerpo
  };

  final Map<String, Map<String, Map<String, dynamic>>> sombreroConfigs = {
    'assets/plantas/cactus.svg': {
      // Plant: Cactus
      'assets/sombreros/cono.svg': {
        // Accessory: Cono
        'top': -.0, 'left': 94.0, 'scale': 3.5, 'rotation': 0.0,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -10.0,
        'left': 90.0,
        'scale': 3.2,
        'rotation': -0.32, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': 8.0,
        'left': 76.0,
        'scale': 2.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 80.0,
        'scale': 2,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': 8.0,
        'left': 120.0,
        'scale': 2,
        'rotation': 0.3,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 128.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -15.0,
        'left': 90.0,
        'scale': 3.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 95.0,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': -8.0,
        'left': 100.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/sombreros/cono.svg': {
        'top': -24.0,
        'left': 48.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -15.0,
        'left': 90.0,
        'scale': 3.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 95.0,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': -8.0,
        'left': 100.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },

    'assets/plantas/carnivora.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 124.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -15.0,
        'left': 90.0,
        'scale': 3.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 95.0,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': -8.0,
        'left': 100.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 176.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -15.0,
        'left': 90.0,
        'scale': 3.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 95.0,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': -8.0,
        'left': 100.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/sombreros/cono.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 6.0,
        'rotation': 0.6,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -15.0,
        'left': 90.0,
        'scale': 3.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 95.0,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': -8.0,
        'left': 100.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },
  };

  final Map<String, Map<String, Map<String, dynamic>>> caraConfigs = {
    'assets/plantas/cactus.svg': {
      'assets/cara/gadas.svg': {
        'top': 50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/curita.svg': {
        'top': 50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/payaso.svg': {
        'top': 50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/cara/gadas.svg': {
        'top': 45,
        'left': -60,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 45,
        'left': -60,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/payaso.svg': {
        'top': 45,
        'left': -60,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 45,
        'left': -60,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 45,
        'left': -60,
        'scale': .2,
        'rotation': 0,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cara/gadas.svg': {
        'top': 188,
        'left': -24.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 188,
        'left': -24.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/payaso.svg': {
        'top': 188,
        'left': -24.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 188,
        'left': -24.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 188,
        'left': -24.0,
        'scale': .1,
        'rotation': 0,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/cara/gadas.svg': {
        'top': -36,
        'left': -80,
        'scale': .3,
        'rotation': 0.4,
      },
      'assets/cara/curita.svg': {
        'top': -36,
        'left': -80,
        'scale': .3,
        'rotation': 0.4,
      },
      'assets/cara/payaso.svg': {
        'top': -36,
        'left': -80,
        'scale': .3,
        'rotation': 0.4,
      },
      'assets/cara/pestenegra.svg': {
        'top': -36,
        'left': -80,
        'scale': .3,
        'rotation': 0.4,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': -36,
        'left': -80,
        'scale': .3,
        'rotation': 0.4,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cara/gadas.svg': {
        'top': 45,
        'left': -32,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/curita.svg': {
        'top': 45,
        'left': -32,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/payaso.svg': {
        'top': 45,
        'left': -32,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 45,
        'left': -32,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 45,
        'left': -32,
        'scale': .3,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cara/gadas.svg': {
        'top': 94,
        'left': 16,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 94,
        'left': 16,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/payaso.svg': {
        'top': 94,
        'left': 16,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 94,
        'left': 16,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 94,
        'left': 16,
        'scale': .5,
        'rotation': 0,
      },
    },
  };

  final Map<String, Map<String, Map<String, dynamic>>> cuerpoConfigs = {
    'assets/plantas/cactus.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/cuerpo/capa.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0.0,
      },
      'assets/cuerpo/alas.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
      },
      'assets/cuerpo/capa.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
      },
      'assets/cuerpo/alas.svg': {
        'top': 188,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 300,
        'left': 146,
        'scale': 2,
        'rotation': 0,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 288,
        'left': 142,
        'scale': 2,
        'rotation': 0,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 288,
        'left': 142,
        'scale': 2,
        'rotation': 0,
      },
      'assets/cuerpo/capa.svg': {
        'top': 288,
        'left': 142,
        'scale': 2,
        'rotation': 0,
      },
      'assets/cuerpo/alas.svg': {
        'top': 288,
        'left': 142,
        'scale': 2,
        'rotation': 0,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
      },
      'assets/cuerpo/capa.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
      },
      'assets/cuerpo/alas.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 204,
        'left': 142,
        'scale': 3.5,
        'rotation': 0,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 204,
        'left': 142,
        'scale': 3.5,
        'rotation': 0,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 204,
        'left': 142,
        'scale': 3.5,
        'rotation': 0,
      },
      'assets/cuerpo/capa.svg': {
        'top': 204,
        'left': 142,
        'scale': 3.5,
        'rotation': 0,
      },
      'assets/cuerpo/alas.svg': {
        'top': 204,
        'left': 142,
        'scale': 3.5,
        'rotation': 0,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/cuerpo/canguro.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/cuerpo/capa.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/cuerpo/alas.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
    },
  };

  // Inside _ArmarioScreenState
  // Inside _ArmarioScreenState
  Widget _buildAccessoryWidget({
    required String accessoryPath,
    required double responsiveTopPx, // Directly use this
    required double responsiveLeftPx, // Directly use this
    required double responsiveScale, // Directly use this
    required double rotationValue, // Directly use this
    required String typeKey,
  }) {
    // THE EXTRACTION LOGIC USING 'config' SHOULD BE REMOVED FROM HERE
    // final double top = (config['top'] as num?)?.toDouble() ?? 0.0; // REMOVE
    // final double left = (config['left'] as num?)?.toDouble() ?? 0.0; // REMOVE
    // final double scale = (config['scale'] as num?)?.toDouble() ?? 1.0; // REMOVE
    // final double rotation = (config['rotation'] as num?)?.toDouble() ?? 0.0; // REMOVE

    return Positioned(
      key: ValueKey(
        // Using a more robust key combining accessory and config details
        "${typeKey}_${accessoryPath.hashCode}_${responsiveTopPx.toStringAsFixed(2)}_${responsiveLeftPx.toStringAsFixed(2)}",
      ),
      top: responsiveTopPx, // Use the passed responsive value
      left: responsiveLeftPx, // Use the passed responsive value
      child: Transform.rotate(
        angle: rotationValue, // Use the passed rotation value
        child: Transform.scale(
          scale: responsiveScale, // Use the passed responsive scale
          child: SvgPicture.asset(
            accessoryPath,
            // Another key for the SvgPicture itself
            key: ValueKey("${typeKey}_svg_${accessoryPath.hashCode}"),
          ),
        ),
      ),
    );
  }

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
        final double actualPlantDisplayHeight = relHeight(
          designPlantDisplayHeight,
        );
        final double actualPlantDisplayWidth = relWidth(
          designPlantDisplayWidth,
        );

        // Calculate scaling factors
        final double heightScaleFactor =
            actualPlantDisplayHeight / designPlantDisplayHeight;
        final double widthScaleFactor =
            actualPlantDisplayWidth / designPlantDisplayWidth;
        // You can choose one factor for scale, e.g., heightScaleFactor, or average, or keep scale unadjusted
        final double accessoryScaleFactor = heightScaleFactor;

        return Scaffold(
          backgroundColor: const Color.fromRGBO(
            247,
            246,
            235,
            1,
          ), // This will be visible if background doesn't cover all or for bottom part
          body: Container(
            clipBehavior: Clip.none,
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
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: SizedBox(
                              key: ValueKey(plantaEquipada),
                              height: relHeight(400),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    plantaEquipada,
                                    key: ValueKey(
                                      "plant_$plantaEquipada",
                                    ), // More specific key
                                    height: relHeight(400),
                                  ),
                                  if (sombreroEquipado != null)
                                    // Check if it's a multi-slot plant for sombreros (like Bambu)
                                    if (multiSlotSombreroConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotSombreroConfigs[plantaEquipada] ??
                                              [])
                                          .map((slotConfig) {
                                            final double originalTop =
                                                (slotConfig['top'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalLeft =
                                                (slotConfig['left'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalScale =
                                                (slotConfig['scale'] as num?)
                                                    ?.toDouble() ??
                                                1.0;
                                            final double originalRotation =
                                                (slotConfig['rotation'] as num?)
                                                    ?.toDouble() ??
                                                0.0;

                                            return _buildAccessoryWidget(
                                              accessoryPath: sombreroEquipado!,
                                              responsiveTopPx:
                                                  originalTop *
                                                  heightScaleFactor,
                                              responsiveLeftPx:
                                                  originalLeft *
                                                  widthScaleFactor,
                                              responsiveScale:
                                                  originalScale *
                                                  accessoryScaleFactor, // Or just originalScale
                                              rotationValue: originalRotation,
                                              typeKey:
                                                  'sombrero_multi_${slotConfig.hashCode}',
                                            );
                                          })
                                          .toList()
                                    // Else, it's a single-slot plant or accessory-specific config
                                    else if (sombreroConfigs.containsKey(
                                          plantaEquipada,
                                        ) &&
                                        sombreroConfigs[plantaEquipada]!
                                            .containsKey(sombreroEquipado!))
                                      () {
                                        // Use a self-invoking function to scope variables
                                        final Map<String, dynamic> itemConfig =
                                            sombreroConfigs[plantaEquipada]![sombreroEquipado!]!;
                                        final double originalTop =
                                            (itemConfig['top'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalLeft =
                                            (itemConfig['left'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalScale =
                                            (itemConfig['scale'] as num?)
                                                ?.toDouble() ??
                                            1.0;
                                        final double originalRotation =
                                            (itemConfig['rotation'] as num?)
                                                ?.toDouble() ??
                                            0.0;

                                        return _buildAccessoryWidget(
                                          accessoryPath: sombreroEquipado!,
                                          responsiveTopPx:
                                              originalTop * heightScaleFactor,
                                          responsiveLeftPx:
                                              originalLeft * widthScaleFactor,
                                          responsiveScale:
                                              originalScale *
                                              accessoryScaleFactor, // Or just originalScale
                                          rotationValue: originalRotation,
                                          typeKey: 'sombrero_single',
                                        );
                                      }(), // Immediately invoke the function
                                  // Cuerpo
                                  if (caraEquipada != null)
                                    if (multiSlotCaraConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotCaraConfigs[plantaEquipada] ??
                                              [])
                                          .map((slotConfig) {
                                            final double originalTop =
                                                (slotConfig['top'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalLeft =
                                                (slotConfig['left'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalScale =
                                                (slotConfig['scale'] as num?)
                                                    ?.toDouble() ??
                                                1.0;
                                            final double originalRotation =
                                                (slotConfig['rotation'] as num?)
                                                    ?.toDouble() ??
                                                0.0;

                                            return _buildAccessoryWidget(
                                              accessoryPath: caraEquipada!,
                                              responsiveTopPx:
                                                  originalTop *
                                                  heightScaleFactor,
                                              responsiveLeftPx:
                                                  originalLeft *
                                                  widthScaleFactor,
                                              responsiveScale:
                                                  originalScale *
                                                  accessoryScaleFactor, // Or just originalScale
                                              rotationValue: originalRotation,
                                              typeKey:
                                                  'cara_multi_${slotConfig.hashCode}',
                                            );
                                          })
                                          .toList()
                                    else if (caraConfigs.containsKey(
                                          plantaEquipada,
                                        ) &&
                                        caraConfigs[plantaEquipada]!
                                            .containsKey(caraEquipada!))
                                      () {
                                        final Map<String, dynamic> itemConfig =
                                            caraConfigs[plantaEquipada]![caraEquipada!]!;
                                        final double originalTop =
                                            (itemConfig['top'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalLeft =
                                            (itemConfig['left'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalScale =
                                            (itemConfig['scale'] as num?)
                                                ?.toDouble() ??
                                            1.0;
                                        final double originalRotation =
                                            (itemConfig['rotation'] as num?)
                                                ?.toDouble() ??
                                            0.0;

                                        return _buildAccessoryWidget(
                                          accessoryPath: caraEquipada!,
                                          responsiveTopPx:
                                              originalTop * heightScaleFactor,
                                          responsiveLeftPx:
                                              originalLeft * widthScaleFactor,
                                          responsiveScale:
                                              originalScale *
                                              accessoryScaleFactor, // Or just originalScale
                                          rotationValue: originalRotation,
                                          typeKey: 'cara_single',
                                        );
                                      }(),
                                  if (cuerpoEquipado != null)
                                    if (multiSlotCuerpoConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotCuerpoConfigs[plantaEquipada] ??
                                              [])
                                          .map((slotConfig) {
                                            final double originalTop =
                                                (slotConfig['top'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalLeft =
                                                (slotConfig['left'] as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final double originalScale =
                                                (slotConfig['scale'] as num?)
                                                    ?.toDouble() ??
                                                1.0;
                                            final double originalRotation =
                                                (slotConfig['rotation'] as num?)
                                                    ?.toDouble() ??
                                                0.0;

                                            return _buildAccessoryWidget(
                                              accessoryPath: cuerpoEquipado!,
                                              responsiveTopPx:
                                                  originalTop *
                                                  heightScaleFactor,
                                              responsiveLeftPx:
                                                  originalLeft *
                                                  widthScaleFactor,
                                              responsiveScale:
                                                  originalScale *
                                                  accessoryScaleFactor, // Or just originalScale
                                              rotationValue: originalRotation,
                                              typeKey:
                                                  'cuerpo_multi_${slotConfig.hashCode}',
                                            );
                                          })
                                          .toList()
                                    else if (cuerpoConfigs.containsKey(
                                          plantaEquipada,
                                        ) &&
                                        cuerpoConfigs[plantaEquipada]!
                                            .containsKey(cuerpoEquipado!))
                                      () {
                                        final Map<String, dynamic> itemConfig =
                                            cuerpoConfigs[plantaEquipada]![cuerpoEquipado!]!;
                                        final double originalTop =
                                            (itemConfig['top'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalLeft =
                                            (itemConfig['left'] as num?)
                                                ?.toDouble() ??
                                            0.0;
                                        final double originalScale =
                                            (itemConfig['scale'] as num?)
                                                ?.toDouble() ??
                                            1.0;
                                        final double originalRotation =
                                            (itemConfig['rotation'] as num?)
                                                ?.toDouble() ??
                                            0.0;

                                        return _buildAccessoryWidget(
                                          accessoryPath: cuerpoEquipado!,
                                          responsiveTopPx:
                                              originalTop * heightScaleFactor,
                                          responsiveLeftPx:
                                              originalLeft * widthScaleFactor,
                                          responsiveScale:
                                              originalScale *
                                              accessoryScaleFactor, // Or just originalScale
                                          rotationValue: originalRotation,
                                          typeKey: 'cuerpo_single',
                                        );
                                      }(),
                                ],
                              ),
                            ),
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
                                              final item =
                                                  entry
                                                      .value; // This 'item' is from itemsPorCategoria[categoriaActual]
                                              return ItemEquipado(
                                                imagen: item['img'],
                                                seleccionado: item['selected'],
                                                Categoria: categoriaActual,
                                                onTap: () {
                                                  setState(() {
                                                    final String tappedItemImg =
                                                        item['img'];
                                                    // For plants, the 'display' field is the unique identifier for what's equipped.
                                                    // For accessories, 'img' is the identifier.
                                                    final String?
                                                    tappedItemDisplayPath =
                                                        item['display']; // Might be null for accessories

                                                    if (categoriaActual ==
                                                        'Planta') {
                                                      // Always select a plant. No "deselection" to an empty state.
                                                      // Only update if it's a new plant.
                                                      if (plantaEquipada !=
                                                              tappedItemDisplayPath &&
                                                          tappedItemDisplayPath !=
                                                              null) {
                                                        for (var p
                                                            in itemsPorCategoria['Planta']!) {
                                                          // Update 'selected' status for all plants
                                                          p['selected'] =
                                                              (p['display'] ==
                                                                  tappedItemDisplayPath);
                                                        }
                                                        plantaEquipada =
                                                            tappedItemDisplayPath;
                                                        actualizarRecientes();
                                                      }
                                                    } else if (categoriaActual ==
                                                            'Sombrero' ||
                                                        categoriaActual ==
                                                            'Cara' ||
                                                        categoriaActual ==
                                                            'Cuerpo') {
                                                      // Handles Sombrero, Cara, Cuerpo tabs directly
                                                      String?
                                                      currentEquippedAccessory;
                                                      switch (categoriaActual) {
                                                        case 'Sombrero':
                                                          currentEquippedAccessory =
                                                              sombreroEquipado;
                                                          break;
                                                        case 'Cara':
                                                          currentEquippedAccessory =
                                                              caraEquipada;
                                                          break;
                                                        case 'Cuerpo':
                                                          currentEquippedAccessory =
                                                              cuerpoEquipado;
                                                          break;
                                                      }

                                                      if (currentEquippedAccessory ==
                                                          tappedItemImg) {
                                                        // Tapped the SAME already equipped accessory: Unequip it
                                                        switch (categoriaActual) {
                                                          case 'Sombrero':
                                                            sombreroEquipado =
                                                                null;
                                                            break;
                                                          case 'Cara':
                                                            caraEquipada = null;
                                                            break;
                                                          case 'Cuerpo':
                                                            cuerpoEquipado =
                                                                null;
                                                            break;
                                                        }
                                                        // Update 'selected' status in the source list for this category
                                                        item['selected'] =
                                                            false;
                                                      } else {
                                                        // Tapped a NEW or DIFFERENT accessory: Equip it
                                                        // Deselect previously selected item in this category's source list
                                                        for (var otherItem
                                                            in itemsPorCategoria[categoriaActual]!) {
                                                          otherItem['selected'] =
                                                              false;
                                                        }
                                                        // Select and equip the new one
                                                        item['selected'] =
                                                            true; // Update 'selected' in source list
                                                        switch (categoriaActual) {
                                                          case 'Sombrero':
                                                            sombreroEquipado =
                                                                tappedItemImg;
                                                            break;
                                                          case 'Cara':
                                                            caraEquipada =
                                                                tappedItemImg;
                                                            break;
                                                          case 'Cuerpo':
                                                            cuerpoEquipado =
                                                                tappedItemImg;
                                                            break;
                                                        }
                                                      }
                                                      actualizarRecientes();
                                                    } else if (categoriaActual ==
                                                        'Reciente') {
                                                      // Handles "Reciente" tab
                                                      // The 'item' here is from the 'Reciente' list and has 'originalCategory'
                                                      final String
                                                      originalCategory =
                                                          item['originalCategory'];
                                                      // Determine the correct identifier (display for plants, img for accessories)
                                                      final String
                                                      itemIdentifierInReciente =
                                                          (originalCategory ==
                                                                  'Planta')
                                                              ? item['display'] // Use 'display' if it's a plant
                                                              : item['img']; // Use 'img' if it's an accessory

                                                      if (originalCategory ==
                                                          'Planta') {
                                                        // Tapping a plant in "Reciente" should do nothing.
                                                        // It's already the selected plant. Plant changes are handled in the 'Planta' tab.
                                                        return; // Exit early, no state change
                                                      } else {
                                                        // It's an accessory from Reciente. Tapping it means UNEQUIP.
                                                        bool unequipped = false;
                                                        if (originalCategory ==
                                                                'Sombrero' &&
                                                            sombreroEquipado ==
                                                                itemIdentifierInReciente) {
                                                          sombreroEquipado =
                                                              null;
                                                          unequipped = true;
                                                        } else if (originalCategory ==
                                                                'Cara' &&
                                                            caraEquipada ==
                                                                itemIdentifierInReciente) {
                                                          caraEquipada = null;
                                                          unequipped = true;
                                                        } else if (originalCategory ==
                                                                'Cuerpo' &&
                                                            cuerpoEquipado ==
                                                                itemIdentifierInReciente) {
                                                          cuerpoEquipado = null;
                                                          unequipped = true;
                                                        }

                                                        if (unequipped) {
                                                          // Find the original item in its source category list and set 'selected' to false
                                                          if (itemsPorCategoria
                                                              .containsKey(
                                                                originalCategory,
                                                              )) {
                                                            for (var originalItem
                                                                in itemsPorCategoria[originalCategory]!) {
                                                              // Match based on 'img' for accessories, as itemIdentifierInReciente will be item['img']
                                                              if (originalItem['img'] ==
                                                                  itemIdentifierInReciente) {
                                                                originalItem['selected'] =
                                                                    false;
                                                                break;
                                                              }
                                                            }
                                                          }
                                                          actualizarRecientes();
                                                        }
                                                      }
                                                    }
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
                Positioned(
                  bottom: relHeight(
                    350,
                  ), // Justo encima de categorías (ajusta según necesidad)
                  right: relWidth(4), // Pegado al borde derecho
                  child: SideButtons(
                    showArmario: false,
                    onTiendaTap: () {
                      Navigator.pushNamed(context, '/tienda');
                    },
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
            ? 0.2
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
            width: 4,
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
