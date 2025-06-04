import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/button.dart' as button; // Your existing import
import 'package:a/widgets/navegationbarhome.dart'
    as navBar; // Your existing import
import 'package:a/widgets/tiendayarmario.dart'; // Your existing import
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
  final double globalAccessoryDesignOffsetX = 96;
  final double globalAccessoryDesignOffsetY = 0.0;

  // --- NEW: State for plant name and controller ---
  String _plantName = "Chuzitos"; // Default name
  late TextEditingController _nameEditingController;
  // --- END NEW ---

  // Your existing config maps (sombreroConfigs, caraConfigs, etc.) remain here
  // ... (multiSlotSombreroConfigs, multiSlotCaraConfigs, multiSlotCuerpoConfigs)
  // ... (sombreroConfigs, caraConfigs, cuerpoConfigs)

  final Map<String, List<Map<String, dynamic>>> multiSlotSombreroConfigs = {
    'assets/plantas/bambu.svg': [
      {'top': -20, 'left': 84.0, 'scale': 2.0, 'rotation': 0.6},
      {'top': 48.0, 'left': 124.0, 'scale': 2.0, 'rotation': 0.0},
    ],
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCaraConfigs = {
    'assets/plantas/bambu.svg': [
      {'top': 80, 'left': -94.0, 'scale': .1, 'rotation': 0},
      {'top': 168.0, 'left': -44.0, 'scale': .1, 'rotation': 0.0},
    ],
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCuerpoConfigs = {
    'assets/plantas/bambu.svg': [
      {
        'top': 188,
        'left': 84.0,
        'scale': 2.0,
        'rotation': 0.0,
        'isBehind': false,
      },
      {
        'top': 288,
        'left': 138.0,
        'scale': 2.0,
        'rotation': 0.0,
        'isBehind': false,
      },
    ],
  };
  final Map<String, Map<String, Map<String, dynamic>>> sombreroConfigs = {
    'assets/plantas/cactus.svg': {
      'assets/sombreros/cono.svg': {
        'top': -.0,
        'left': 94.0,
        'scale': 3.5,
        'rotation': 0.0,
      },
      'assets/sombreros/beanie.svg': {
        'top': -10.0,
        'left': 90.0,
        'scale': 3.2,
        'rotation': -0.32,
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
      'assets/sombreros/beanie.svg': {
        'top': -10.0,
        'left': 90.0,
        'scale': 3.2,
        'rotation': -0.32,
      },
      'assets/sombreros/cowboy.svg': {
        'top': 24.0,
        'left': 96.0,
        'scale': 3.0,
        'rotation': 0.3,
      },
      'assets/sombreros/halo.svg': {
        'top': -10.0,
        'left': 96.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
      'assets/sombreros/monho.svg': {
        'top': 20.0,
        'left': 112.0,
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
      'assets/sombreros/beanie.svg': {
        'top': -24.0,
        'left': 48.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -24.0,
        'left': 48.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -24.0,
        'left': 48.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/monho.svg': {
        'top': -24.0,
        'left': 48.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 124.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/beanie.svg': {
        'top': -4.0,
        'left': 124.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/cowboy.svg': {
        'top': 12.0,
        'left': 118.0,
        'scale': 2.0,
        'rotation': 1,
      },
      'assets/sombreros/halo.svg': {
        'top': -4.0,
        'left': 124.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/monho.svg': {
        'top': 24.0,
        'left': 130.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/sombreros/cono.svg': {
        'top': -20.0,
        'left': 176.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/beanie.svg': {
        'top': -20.0,
        'left': 176.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/cowboy.svg': {
        'top': -12.0,
        'left': 180.0,
        'scale': 3.0,
        'rotation': 0.6,
      },
      'assets/sombreros/halo.svg': {
        'top': -20.0,
        'left': 176.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
      'assets/sombreros/monho.svg': {
        'top': 24.0,
        'left': 186.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/sombreros/cono.svg': {
        'top': -30.0,
        'left': 254.0,
        'scale': 6.0,
        'rotation': 0.6,
      },
      'assets/sombreros/beanie.svg': {
        'top': -30.0,
        'left': 254.0,
        'scale': 5.0,
        'rotation': 0.3,
      },
      'assets/sombreros/cowboy.svg': {
        'top': 10.0,
        'left': 254.0,
        'scale': 3.0,
        'rotation': 1,
      },
      'assets/sombreros/halo.svg': {
        'top': -30.0,
        'left': 254.0,
        'scale': 3.0,
        'rotation': 0.6,
      },
      'assets/sombreros/monho.svg': {
        'top': 54.0,
        'left': 254.0,
        'scale': 3.0,
        'rotation': 0.6,
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
        'top': 25,
        'left': 44.0,
        'scale': .3,
        'rotation': 0.6,
      },
      'assets/cara/payaso.svg': {
        'top': -50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 32,
        'left': 20.0,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 28,
        'left': -120.0,
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
        'top': 25,
        'left': 44.0,
        'scale': .3,
        'rotation': 0.6,
      },
      'assets/cara/payaso.svg': {
        'top': -50,
        'left': -60.0,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 32,
        'left': 20.0,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 0,
        'left': -126.0,
        'scale': .2,
        'rotation': 0.0,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cara/gadas.svg': {
        'top': 196,
        'left': -48.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 175,
        'left': 38.0,
        'scale': .15,
        'rotation': 1.5,
      },
      'assets/cara/payaso.svg': {
        'top': 100,
        'left': -60.0,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 188,
        'left': -18.0,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 138,
        'left': -130.0,
        'scale': .08,
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
        'top': -44,
        'left': -20,
        'scale': .3,
        'rotation': 0.1,
      },
      'assets/cara/payaso.svg': {
        'top': -84,
        'left': -122,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': -20,
        'left': -24,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': -56,
        'left': -180,
        'scale': 0.4,
        'rotation': 0,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cara/gadas.svg': {
        'top': 45,
        'left': -52,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/curita.svg': {
        'top': 16,
        'left': 34,
        'scale': .3,
        'rotation': .6,
      },
      'assets/cara/payaso.svg': {
        'top': -68,
        'left': -52,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 24,
        'left': 14,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': -4,
        'left': -116,
        'scale': .2,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cara/gadas.svg': {
        'top': 94,
        'left': -56,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 94,
        'left': 76,
        'scale': .5,
        'rotation': -0.6,
      },
      'assets/cara/payaso.svg': {
        'top': 64,
        'left': -56,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 124,
        'left': 64,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 124,
        'left': -104,
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
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 188,
        'left': 82,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 270,
        'left': 92,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 212,
        'left': 64,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 156,
        'left': 32,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 196,
        'left': 110,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 196,
        'left': 82,
        'scale': 1.7,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 192,
        'left': 92,
        'scale': 2,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 212,
        'left': 64,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 156,
        'left': 32,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 300,
        'left': 116,
        'scale': 2,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 284,
        'left': 96,
        'scale': 1,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 284,
        'left': 104,
        'scale': 1,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 196,
        'left': 66,
        'scale': 1,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 196,
        'left': 34,
        'scale': 1,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 104,
        'left': 144.0,
        'scale': 3,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 162,
        'left': 124.0,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 232,
        'left': 64,
        'scale': 2.8,
        'rotation': 1,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 162,
        'left': 124.0,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 162,
        'left': 32.0,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 204,
        'left': 112,
        'scale': 3.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 240,
        'left': 92,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 232,
        'left': 90,
        'scale': 3.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 150,
        'left': 70,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 150,
        'left': 24,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 360.0,
        'left': 114.0,
        'scale': 5.0,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 360.0,
        'left': 88.0,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 360.0,
        'left': 92.0,
        'scale': 5.0,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 124.0,
        'left': 16.0,
        'scale': 3,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 124.0,
        'left': 16.0,
        'scale': 3,
        'rotation': 0,
        'isBehind': true,
      },
    },
  };

  @override
  void initState() {
    super.initState();
    // --- NEW: Initialize TextEditingController ---
    _nameEditingController = TextEditingController();
    // --- END NEW ---
    _loadEquippedItems();
    _loadPlantName(); // Load plant name
  }

  @override
  void dispose() {
    // --- NEW: Dispose TextEditingController ---
    _nameEditingController.dispose();
    // --- END NEW ---
    super.dispose();
  }

  // --- NEW: Method to load plant name ---
  Future<void> _loadPlantName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _plantName =
          prefs.getString('plant_name') ?? "Chuzitos"; // Default if not found
      _nameEditingController.text = _plantName; // Set initial text for editing
    });
  }
  // --- END NEW ---

  // --- NEW: Method to save plant name ---
  Future<void> _savePlantName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('plant_name', newName);
    setState(() {
      _plantName = newName;
    });
  }
  // --- END NEW ---

  Future<void> _loadEquippedItems() async {
    setState(() {
      _isLoadingEquippedItems = true;
    });
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _plantaEquipadaAsset =
          prefs.getString('equipped_planta') ?? 'assets/plantas/cactus.svg';
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
    required double responsiveTopPx,
    required double responsiveLeftPx,
    required double responsiveScale,
    required double rotationValue,
    required double globalOffsetX,
    required double globalOffsetY,
    required String typeKey,
  }) {
    final double finalTopPx = responsiveTopPx + globalOffsetY;
    final double finalLeftPx = responsiveLeftPx + globalOffsetX;

    return Positioned(
      key: ValueKey(
        "${typeKey}_${accessoryPath.hashCode}_${responsiveTopPx.toStringAsFixed(2)}_${responsiveLeftPx.toStringAsFixed(2)}",
      ),
      top: finalTopPx,
      left: finalLeftPx,
      child: Transform.rotate(
        angle: rotationValue,
        child: Transform.scale(
          scale: responsiveScale,
          child: SvgPicture.asset(
            accessoryPath,
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
    bool isPlantSelected = _selectedIndex == 2;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isFabPressed = true),
      onTapUp: (_) {
        setState(() {
          _isFabPressed = false;
          if (_selectedIndex != 2) {
            _selectedIndex = 2;
            if (ModalRoute.of(context)?.settings.name != '/planta') {
              Navigator.pushReplacementNamed(context, '/planta');
            }
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
              'assets/phplantduotone.svg', // Ensure this asset path is correct
              width: relWidth(24),
              height: relHeight(24),
              colorFilter: ColorFilter.mode(
                // Updated from 'color'
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

  // --- NEW: Method to show the edit name dialog ---
  // Ensure this import points to your custom buttons file
  // import 'package:a/widgets/button.dart' as button; // Already in your code

  void _showEditNameDialog(BuildContext context) {
    _nameEditingController.text = _plantName;
    _nameEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _nameEditingController.text.length),
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        double screenHeight =
            MediaQuery.of(
              dialogContext,
            ).size.height; // Not directly used for height yet
        double screenWidth = MediaQuery.of(dialogContext).size.width;

        // Define the TOTAL width of your SVG element on screen (including leaves).
        // This will likely be a bit wider than just the beige box.
        // Example: If beige box is 80% of screen, maybe total SVG is 90-95%.
        final double dialogCanvasWidth =
            screenWidth * 1; // ADJUST THIS for total SVG width

        // The height of the canvas. This needs to match the aspect ratio of your *entire* SVG
        // (beige box + leaves). If you don't know it, you might need to:
        // 1. Open SVG in an editor, get its viewBox dimensions (e.g., viewBox="0 0 300 350")
        //    aspectRatio = width / height (e.g., 300 / 350)
        //    dialogCanvasHeight = dialogCanvasWidth / aspectRatio;
        // OR 2. Guess and check.
        // Let's assume an example SVG aspect ratio (width/height) of 300/380 for the whole visual.
        final double svgOverallAspectRatio =
            440 / 365; // GUESS: width/height of your SVG including leaves
        final double dialogCanvasHeight =
            dialogCanvasWidth / svgOverallAspectRatio;

        // --- Sizing for content WITHIN the beige box ---
        // These are relative to the beige box area.
        // Let's assume the beige box content area is roughly 70-75% of the dialogCanvasWidth
        // and a certain fixed proportion for height for the content part.
        double contentAreaDesignWidth =
            280; // A reference design width for the beige box content
        // The actual width available for content after accounting for leaves visually:
        double actualContentDisplayWidth =
            dialogCanvasWidth *
            0.75; // GUESS: Beige box is 75% of total SVG width

        double cRelWidth(double w) =>
            actualContentDisplayWidth * (w / contentAreaDesignWidth);
        // For cRelHeight, it's trickier without knowing the beige box's height portion.
        // Let's use fixed padding/SizedBox heights for vertical spacing for now or scale them similarly.
        double cRelHeight(double h, {double baseContentHeight = 180}) =>
            (dialogCanvasHeight * 0.5) * (h / baseContentHeight);
        double dRelWidth(double w) =>
            MediaQuery.of(dialogContext).size.width * (w / 440);
        double dRelHeight(double h) =>
            MediaQuery.of(dialogContext).size.height * (h / 956);

        final double dialogContainerWidth =
            MediaQuery.of(dialogContext).size.width;
        // You might need to adjust dialogContainerHeight if your custom buttons
        // have different vertical padding than the previous ElevatedButton setup.
        final double dialogContainerHeight = dRelHeight(360);

        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero, // Allows dialog to size to its child
          child: SizedBox(
            // This SizedBox is the canvas for the ENTIRE SVG
            width: dialogCanvasWidth,
            height: dialogCanvasHeight,
            child: Stack(
              // This centers the Column of content within the dialogCanvasWidth/Height.
              // The Column itself will then be constrained.
              alignment: Alignment.center,
              clipBehavior:
                  Clip.none, // Important if SVG design has parts that are truly "outside"
              children: [
                // Layer 1: The SVG background
                SvgPicture.asset(
                  'assets/fondopopsinB.svg', // YOUR SVG
                  width: dialogCanvasWidth,
                  height: dialogCanvasHeight,
                  // BoxFit.fill will stretch the SVG to fill the canvas.
                  // This is often desired if the canvas dimensions are specifically for the SVG.
                  fit: BoxFit.fill,
                ),

                // Layer 2: The content Column
                // This Column needs to be narrower than dialogCanvasWidth if leaves are on sides.
                // We constrain its width.
                Container(
                  width:
                      actualContentDisplayWidth, // Constrain width to beige box area
                  // Height will be determined by content (MainAxisSize.min)
                  // Add padding if your SVG's beige box has internal padding before content starts
                  padding: EdgeInsets.symmetric(
                    // horizontal: cRelWidth(15), // Internal padding within the beige box if any
                    vertical: cRelHeight(
                      15,
                      baseContentHeight: 200,
                    ), // Internal top/bottom padding
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Editar nombre',
                        style: GoogleFonts.poppins(
                          fontSize: cRelWidth(16),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F1F),
                        ),
                      ),
                      SizedBox(height: cRelHeight(18, baseContentHeight: 200)),
                      SizedBox(
                        height: dialogCanvasHeight * 0.12,
                        child: TextField(
                          controller: _nameEditingController,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.center,
                          style: GoogleFonts.poppins(
                            fontSize: cRelWidth(14),
                            color: const Color(0xFF1F1F1F),
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: cRelWidth(10),
                                right: cRelWidth(6),
                              ),
                              child: Icon(
                                Icons.park_rounded,
                                color: const Color(0xFF355E3B),
                                size: cRelWidth(20),
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEAE9E0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                cRelWidth(20),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: cRelWidth(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: cRelHeight(12, baseContentHeight: 200),
                      ), // Reduced space
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: button.CustomOutlinedButton(
                              text: 'Cancelar',
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              isActivated: false,
                            ),
                          ),
                          SizedBox(width: cRelWidth(10)),
                          Expanded(
                            child: button.FilledButton(
                              text: 'Guardar',
                              onPressed: () {
                                if (_nameEditingController.text
                                    .trim()
                                    .isNotEmpty) {
                                  _savePlantName(
                                    _nameEditingController.text.trim(),
                                  );
                                  Navigator.of(dialogContext).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "El nombre no puede estar vacío.",
                                      ),
                                    ),
                                  );
                                }
                              },
                              isActivated: true,
                            ),
                          ),
                        ],
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
  // --- END NEW ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
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
          final double heightScaleFactor =
              actualPlantDisplayHeight / designPlantDisplayHeight;
          final double widthScaleFactor =
              actualPlantDisplayWidth / designPlantDisplayWidth;
          final double accessoryScaleFactor = heightScaleFactor;
          final double scaledGlobalAccessoryOffsetX =
              globalAccessoryDesignOffsetX * widthScaleFactor;
          final double scaledGlobalAccessoryOffsetY =
              globalAccessoryDesignOffsetY * heightScaleFactor;
          Map<String, dynamic>? currentSingleSlotCuerpoConfig;
          bool isSingleSlotCuerpoBehind = false;

          // Define the lists outside the loop so they are accessible in the widget tree
          List<Widget> multiSlotCuerpoBehindWidgets = [];
          List<Widget> multiSlotCuerpoFrontWidgets = [];

          if (_cuerpoEquipadoAsset != null &&
              !multiSlotCuerpoConfigs.containsKey(_plantaEquipadaAsset) &&
              cuerpoConfigs.containsKey(_plantaEquipadaAsset) &&
              cuerpoConfigs[_plantaEquipadaAsset]!.containsKey(
                _cuerpoEquipadoAsset!,
              )) {
            currentSingleSlotCuerpoConfig =
                cuerpoConfigs[_plantaEquipadaAsset]![_cuerpoEquipadoAsset!]!;
            isSingleSlotCuerpoBehind =
                (currentSingleSlotCuerpoConfig['isBehind'] as bool?) ?? false;
          }
          if (_cuerpoEquipadoAsset != null &&
              multiSlotCuerpoConfigs.containsKey(_plantaEquipadaAsset)) {
            final List<Map<String, dynamic>> slotConfigsForPlant =
                multiSlotCuerpoConfigs[_plantaEquipadaAsset] ?? [];
            for (var slotConfig in slotConfigsForPlant) {
              final double originalTop =
                  (slotConfig['top'] as num?)?.toDouble() ?? 0.0;
              final double originalLeft =
                  (slotConfig['left'] as num?)?.toDouble() ?? 0.0;
              final double originalScale =
                  (slotConfig['scale'] as num?)?.toDouble() ?? 1.0;
              final double originalRotation =
                  (slotConfig['rotation'] as num?)?.toDouble() ?? 0.0;
              final bool isThisSlotBehind =
                  (slotConfig['isBehind'] as bool?) ?? false;

              Widget accessoryWidget = _buildAccessoryWidget(
                accessoryPath: _cuerpoEquipadoAsset!,
                responsiveTopPx: originalTop * heightScaleFactor,
                responsiveLeftPx: originalLeft * widthScaleFactor,
                responsiveScale: originalScale * accessoryScaleFactor,
                rotationValue: originalRotation,
                globalOffsetX:
                    scaledGlobalAccessoryOffsetX, // Apply Plant1's global offset
                globalOffsetY:
                    scaledGlobalAccessoryOffsetY, // Apply Plant1's global offset
                typeKey:
                    'cuerpo_multi_${isThisSlotBehind ? "behind" : "front"}_${slotConfig.hashCode}_plant1',
              );
              if (isThisSlotBehind) {
                multiSlotCuerpoBehindWidgets.add(accessoryWidget);
              } else {
                multiSlotCuerpoFrontWidgets.add(accessoryWidget);
              }
            }
          }

          return Stack(
            children: [
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
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 246, 235, 1),
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
                    // --- MODIFIED: Plant name is now tappable ---
                    GestureDetector(
                      onTap: () {
                        _showEditNameDialog(context);
                      },
                      child: Text(
                        _plantName, // Use the state variable for plant name
                        style: GoogleFonts.poppins(
                          fontSize: relWidth(16),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F1F),
                        ),
                      ),
                    ),
                    // --- END MODIFICATION ---
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: relWidth(12),
                        vertical: relHeight(4),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 246, 235, 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco_rounded,
                            color: const Color(0xFF355E3B),
                            size: relWidth(20),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '1500', // This should probably be dynamic too
                            style: GoogleFonts.poppins(
                              fontSize: relWidth(16),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF355E3B),
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
                  child: Center(
                    child: SizedBox(
                      width: actualPlantDisplayWidth,
                      height: actualPlantDisplayHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          if (_cuerpoEquipadoAsset != null &&
                              isSingleSlotCuerpoBehind &&
                              currentSingleSlotCuerpoConfig != null)
                            () {
                              final Map<String, dynamic> itemConfig =
                                  currentSingleSlotCuerpoConfig!;
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
                                globalOffsetX: scaledGlobalAccessoryOffsetX,
                                globalOffsetY: scaledGlobalAccessoryOffsetY,
                                typeKey: 'cuerpo_single_behind_plant1',
                              );
                            }(),

                          // --- 2. RENDER "BEHIND" MULTI-SLOT CUERPO ITEMS ---
                          ...multiSlotCuerpoBehindWidgets,
                          SvgPicture.asset(
                            _plantaEquipadaAsset,
                            key: ValueKey("plant_$_plantaEquipadaAsset"),
                            height: actualPlantDisplayHeight,
                          ),
                          if (_sombreroEquipadoAsset != null)
                            // ... (Your existing sombrero rendering logic - unchanged) ...
                            // Ensure it uses scaledGlobalAccessoryOffsetX/Y in _buildAccessoryWidget calls
                            if (multiSlotSombreroConfigs.containsKey(
                              _plantaEquipadaAsset,
                            ))
                              ...(multiSlotSombreroConfigs[_plantaEquipadaAsset] ??
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
                                      accessoryPath: _sombreroEquipadoAsset!,
                                      responsiveTopPx:
                                          originalTop * heightScaleFactor,
                                      responsiveLeftPx:
                                          originalLeft * widthScaleFactor,
                                      responsiveScale:
                                          originalScale * accessoryScaleFactor,
                                      rotationValue: originalRotation,
                                      globalOffsetX:
                                          scaledGlobalAccessoryOffsetX,
                                      globalOffsetY:
                                          scaledGlobalAccessoryOffsetY,
                                      typeKey:
                                          'sombrero_multi_${slotConfig.hashCode}_plant1',
                                    );
                                  })
                                  .toList()
                            else if (sombreroConfigs.containsKey(
                                  _plantaEquipadaAsset,
                                ) &&
                                sombreroConfigs[_plantaEquipadaAsset]!
                                    .containsKey(_sombreroEquipadoAsset!))
                              () {
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
                                  globalOffsetX: scaledGlobalAccessoryOffsetX,
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  rotationValue: originalRotation,
                                  typeKey: 'sombrero_single_plant1',
                                );
                              }(),

                          // --- 5. RENDER CARA ---
                          if (_caraEquipadaAsset != null)
                            // ... (Your existing cara rendering logic - unchanged) ...
                            // Ensure it uses scaledGlobalAccessoryOffsetX/Y in _buildAccessoryWidget calls
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
                                          scaledGlobalAccessoryOffsetX,
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
                                  globalOffsetX: scaledGlobalAccessoryOffsetX,
                                  globalOffsetY: scaledGlobalAccessoryOffsetY,
                                  typeKey: 'cara_single_plant1',
                                );
                              }(),

                          // --- 6. RENDER "FRONT" SINGLE-SLOT CUERPO ITEMS ---
                          if (_cuerpoEquipadoAsset != null &&
                              !multiSlotCuerpoConfigs.containsKey(
                                _plantaEquipadaAsset,
                              ) && // single-slot
                              !isSingleSlotCuerpoBehind && // and front
                              currentSingleSlotCuerpoConfig != null)
                            () {
                              final Map<String, dynamic> itemConfig =
                                  currentSingleSlotCuerpoConfig!;
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
                                globalOffsetX: scaledGlobalAccessoryOffsetX,
                                globalOffsetY: scaledGlobalAccessoryOffsetY,
                                typeKey: 'cuerpo_single_front_plant1',
                              );
                            }(),

                          // --- 7. RENDER "FRONT" MULTI-SLOT CUERPO ITEMS ---
                          ...multiSlotCuerpoFrontWidgets,
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: relHeight(150),
                right: relWidth(16),
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
}
