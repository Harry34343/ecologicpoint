import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/button.dart' as button;
import 'package:a/widgets/navegationbarhome.dart' as navBar;
import 'package:a/widgets/tiendayarmario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Plant1 extends StatefulWidget {
  const Plant1({super.key});

  @override
  _Plant1State createState() => _Plant1State();
}

class _Plant1State extends State<Plant1> {
  int _selectedIndex = 2;
  bool _isFabPressed = false;
  String _plantaEquipadaAsset =
      'assets/plantas/cactus.svg'; // Valor por defecto inicial
  String? _sombreroEquipadoAsset;
  String? _caraEquipadaAsset;
  String? _cuerpoEquipadoAsset;
  bool _isLoadingEquippedItems = true;
  final double designPlantDisplayHeight = 400.0;
  final double designPlantDisplayWidth = 430.0;
  final double globalAccessoryDesignOffsetX =
      96; // Ejemplo: 10.0 para mover 10 unidades a la derecha
  final double globalAccessoryDesignOffsetY = 0.0;

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
  @override
  void initState() {
    super.initState();
    _loadEquippedItems();
  }

  Future<void> _loadEquippedItems() async {
    setState(() {
      _isLoadingEquippedItems = true;
    });
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _plantaEquipadaAsset =
          prefs.getString('equipped_planta') ??
          'assets/plantas/cactus.svg'; // Un default si no hay nada
      _sombreroEquipadoAsset = prefs.getString('equipped_sombrero');
      _caraEquipadaAsset = prefs.getString('equipped_cara');
      _cuerpoEquipadoAsset = prefs.getString('equipped_cuerpo');
      _isLoadingEquippedItems = false;
    });
    print(
      "PLANT1: Items equipados cargados: Planta: $_plantaEquipadaAsset, Sombrero: $_sombreroEquipadoAsset",
    );
  }

  Widget _buildAccessoryWidget({
    required String accessoryPath,
    required double responsiveTopPx, // Directly use this
    required double responsiveLeftPx, // Directly use this
    required double responsiveScale, // Directly use this
    required double rotationValue, // Directly use this
    required double
    globalOffsetX, // Offset X global para todos los accesorios, ya escalado
    required double globalOffsetY,
    required String typeKey,
  }) {
    final double finalTopPx = responsiveTopPx + globalOffsetY;
    final double finalLeftPx = responsiveLeftPx + globalOffsetX;
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
      top: finalTopPx, // Use the passed responsive value
      left: finalLeftPx, // Use the passed responsive value
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

  Widget _buildFloatingActionButton() {
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 956);

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
            child: SvgPicture.asset(
              'phplantduotone.svg',
              width: relWidth(24),
              height: relHeight(24),
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
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Added missing definition
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
          final double heightScaleFactor =
              actualPlantDisplayHeight / designPlantDisplayHeight;
          final double widthScaleFactor =
              actualPlantDisplayWidth / designPlantDisplayWidth;
          final double accessoryScaleFactor = heightScaleFactor;
          final double scaledGlobalAccessoryOffsetX =
              globalAccessoryDesignOffsetX * widthScaleFactor;
          final double scaledGlobalAccessoryOffsetY =
              globalAccessoryDesignOffsetY * heightScaleFactor;

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
                        color: Color.fromRGBO(247, 246, 235, 1),
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
                        fontSize: relWidth(16),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F1F1F),
                      ),
                    ),
                    // Monedas
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: relWidth(12),
                        vertical: relHeight(4),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 246, 235, 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco_rounded,
                            color: Color(0xFF355E3B),
                            size: relWidth(20),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '1500',
                            style: GoogleFonts.poppins(
                              fontSize: relWidth(16),
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
              if (_isLoadingEquippedItems)
                const Center(child: CircularProgressIndicator())
              else
                Positioned.fill(
                  // O usa Align o Center, ajusta 'top', 'bottom' para posicionar verticalmente
                  child: Center(
                    // Centra el SizedBox de la planta
                    child: SizedBox(
                      // Define un tamaño para el área de visualización de la planta
                      // Puedes usar relHeight/relWidth o tamaños fijos adaptados
                      width:
                          actualPlantDisplayWidth, // Ejemplo: 80% del ancho de diseño
                      height:
                          actualPlantDisplayHeight, // Ejemplo: 80% del alto de diseño
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior:
                            Clip.none, // Permite que los accesorios se salgan un poco si es necesario
                        children: [
                          // Planta Base Equipada
                          SvgPicture.asset(
                            _plantaEquipadaAsset,
                            key: ValueKey("plant_$_plantaEquipadaAsset"),
                            // Ajusta el tamaño de la planta base como necesites para esta pantalla
                            height:
                                actualPlantDisplayHeight, // Ejemplo de tamaño
                          ),

                          // Lógica para mostrar Sombrero Equipado (similar a ArmarioScreen)
                          if (_sombreroEquipadoAsset != null)
                            if (multiSlotSombreroConfigs.containsKey(
                              _plantaEquipadaAsset,
                            ))
                              ...(multiSlotSombreroConfigs[_plantaEquipadaAsset] ?? []).map((
                                slotConfig,
                              ) {
                                // ... (cálculos de responsiveTopPx, etc. igual que en ArmarioScreen)
                                final double originalTop =
                                    (slotConfig['top'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalLeft =
                                    (slotConfig['left'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalScale =
                                    (slotConfig['scale'] as num?)?.toDouble() ??
                                    1.0;
                                final double originalRotation =
                                    (slotConfig['rotation'] as num?)
                                        ?.toDouble() ??
                                    0.0;
                                return _buildAccessoryWidget(
                                  accessoryPath: _sombreroEquipadoAsset!,
                                  responsiveTopPx:
                                      originalTop * heightScaleFactor,
                                  responsiveLeftPx:
                                      originalLeft * widthScaleFactor,
                                  responsiveScale:
                                      originalScale * accessoryScaleFactor,
                                  rotationValue: originalRotation,
                                  globalOffsetX:
                                      scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  typeKey:
                                      'sombrero_multi_${slotConfig.hashCode}_plant1',
                                );
                              }).toList()
                            else if (sombreroConfigs.containsKey(
                                  _plantaEquipadaAsset,
                                ) &&
                                sombreroConfigs[_plantaEquipadaAsset]!
                                    .containsKey(_sombreroEquipadoAsset!))
                              () {
                                // ... (lógica para single slot igual que en ArmarioScreen)
                                final Map<String, dynamic> itemConfig =
                                    sombreroConfigs[_plantaEquipadaAsset]![_sombreroEquipadoAsset!]!;
                                final double originalTop =
                                    (itemConfig['top'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalLeft =
                                    (itemConfig['left'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalScale =
                                    (itemConfig['scale'] as num?)?.toDouble() ??
                                    1.0;
                                final double originalRotation =
                                    (itemConfig['rotation'] as num?)
                                        ?.toDouble() ??
                                    0.0;
                                return _buildAccessoryWidget(
                                  accessoryPath: _sombreroEquipadoAsset!,
                                  responsiveTopPx:
                                      originalTop * heightScaleFactor,
                                  responsiveLeftPx:
                                      originalLeft * widthScaleFactor,
                                  responsiveScale:
                                      originalScale * accessoryScaleFactor,
                                  globalOffsetX:
                                      scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  rotationValue: originalRotation,
                                  typeKey: 'sombrero_single_plant1',
                                );
                              }(),

                          // Lógica para mostrar Cara Equipada (similar a ArmarioScreen)
                          if (_caraEquipadaAsset != null)
                            // ... (copia y adapta la lógica de multiSlot y single slot para 'cara' aquí) ...
                            if (multiSlotCaraConfigs.containsKey(
                              _plantaEquipadaAsset,
                            ))
                              ...(multiSlotCaraConfigs[_plantaEquipadaAsset] ??
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
                                      accessoryPath: _caraEquipadaAsset!,
                                      responsiveTopPx:
                                          originalTop * heightScaleFactor,
                                      responsiveLeftPx:
                                          originalLeft * widthScaleFactor,
                                      responsiveScale:
                                          originalScale * accessoryScaleFactor,
                                      rotationValue: originalRotation,
                                      globalOffsetX:
                                          scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                      globalOffsetY:
                                          scaledGlobalAccessoryOffsetY,
                                      typeKey:
                                          'cara_multi_${slotConfig.hashCode}_plant1',
                                    );
                                  })
                                  .toList()
                            else if (caraConfigs.containsKey(
                                  _plantaEquipadaAsset,
                                ) &&
                                caraConfigs[_plantaEquipadaAsset]!.containsKey(
                                  _caraEquipadaAsset!,
                                ))
                              () {
                                final Map<String, dynamic> itemConfig =
                                    caraConfigs[_plantaEquipadaAsset]![_caraEquipadaAsset!]!;
                                final double originalTop =
                                    (itemConfig['top'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalLeft =
                                    (itemConfig['left'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalScale =
                                    (itemConfig['scale'] as num?)?.toDouble() ??
                                    1.0;
                                final double originalRotation =
                                    (itemConfig['rotation'] as num?)
                                        ?.toDouble() ??
                                    0.0;
                                return _buildAccessoryWidget(
                                  accessoryPath: _caraEquipadaAsset!,
                                  responsiveTopPx:
                                      originalTop * heightScaleFactor,
                                  responsiveLeftPx:
                                      originalLeft * widthScaleFactor,
                                  responsiveScale:
                                      originalScale * accessoryScaleFactor,
                                  rotationValue: originalRotation,
                                  globalOffsetX:
                                      scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  typeKey: 'cara_single_plant1',
                                );
                              }(),

                          // Lógica para mostrar Cuerpo Equipado (similar a ArmarioScreen)
                          if (_cuerpoEquipadoAsset != null)
                            // ... (copia y adapta la lógica de multiSlot y single slot para 'cuerpo' aquí) ...
                            if (multiSlotCuerpoConfigs.containsKey(
                              _plantaEquipadaAsset,
                            ))
                              ...(multiSlotCuerpoConfigs[_plantaEquipadaAsset] ??
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
                                      accessoryPath: _cuerpoEquipadoAsset!,
                                      responsiveTopPx:
                                          originalTop * heightScaleFactor,
                                      responsiveLeftPx:
                                          originalLeft * widthScaleFactor,
                                      responsiveScale:
                                          originalScale * accessoryScaleFactor,
                                      rotationValue: originalRotation,

                                      globalOffsetX:
                                          scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                      globalOffsetY:
                                          scaledGlobalAccessoryOffsetY,
                                      typeKey:
                                          'cuerpo_multi_${slotConfig.hashCode}_plant1',
                                    );
                                  })
                                  .toList()
                            else if (cuerpoConfigs.containsKey(
                                  _plantaEquipadaAsset,
                                ) &&
                                cuerpoConfigs[_plantaEquipadaAsset]!
                                    .containsKey(_cuerpoEquipadoAsset!))
                              () {
                                final Map<String, dynamic> itemConfig =
                                    cuerpoConfigs[_plantaEquipadaAsset]![_cuerpoEquipadoAsset!]!;
                                final double originalTop =
                                    (itemConfig['top'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalLeft =
                                    (itemConfig['left'] as num?)?.toDouble() ??
                                    0.0;
                                final double originalScale =
                                    (itemConfig['scale'] as num?)?.toDouble() ??
                                    1.0;
                                final double originalRotation =
                                    (itemConfig['rotation'] as num?)
                                        ?.toDouble() ??
                                    0.0;
                                return _buildAccessoryWidget(
                                  accessoryPath: _cuerpoEquipadoAsset!,
                                  responsiveTopPx:
                                      originalTop * heightScaleFactor,
                                  responsiveLeftPx:
                                      originalLeft * widthScaleFactor,
                                  responsiveScale:
                                      originalScale * accessoryScaleFactor,
                                  rotationValue: originalRotation,
                                  globalOffsetX:
                                      scaledGlobalAccessoryOffsetX, // <--- Pasar offset X
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  typeKey: 'cuerpo_single_plant1',
                                );
                              }(),
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: relHeight(
                  150,
                ), // Adjust top position as needed (e.g., below the top bar)
                right: relWidth(16), // Adjust right padding as needed
                child: SideButtons(
                  onArmarioTap: () {
                    Navigator.pushNamed(context, '/armario').then((_) {
                      _loadEquippedItems();
                    });
                  },
                  onTiendaTap: () {
                    Navigator.pushNamed(context, '/tienda');
                  },
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
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1)
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
