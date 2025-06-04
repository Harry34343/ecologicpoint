import 'package:a/widgets/tiendayarmario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:a/widgets/button.dart'
    as button; // Assuming this path is correct
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isLoading = true;
  // DESIGN CONSTANTS (can be defined at the top of your state class or build method)
  final double designPlantDisplayHeight = 400.0;
  // Adjust this if your plant assets are not typically square when at 400px height
  final double designPlantDisplayWidth = 430.0;
  @override
  void initState() {
    super.initState();
    _loadAndFilterOwnedItems();
  }

  Future<void> _loadAndFilterOwnedItems() async {
    setState(() {
      _isLoading = true;
    }); // Iniciar carga

    final prefs = await SharedPreferences.getInstance();
    List<String> purchasedItemIds = prefs.getStringList('purchasedItems') ?? [];
    print("Armario - IDs comprados cargados: $purchasedItemIds");

    String loadedPlantaEquipada =
        prefs.getString('equipped_planta') ??
        'assets/plantas/cactus.svg'; // Default si no hay nada
    String? loadedSombreroEquipado = prefs.getString('equipped_sombrero');
    String? loadedCaraEquipada = prefs.getString('equipped_cara');
    String? loadedCuerpoEquipado = prefs.getString('equipped_cuerpo');
    print(
      "ARMARIO: Items equipados cargados - Planta: $loadedPlantaEquipada, Sombrero: $loadedSombreroEquipado, Cara: $loadedCaraEquipada, Cuerpo: $loadedCuerpoEquipado",
    );

    Map<String, List<Map<String, dynamic>>> tempOwnedItems = {
      'Reciente': [], // 'Reciente' se actualizará después
    };
    String?
    firstOwnedPlantDisplay; // Para equipar la primera planta poseída por defecto

    _baseItemsPorCategoria.forEach((category, baseItemsList) {
      if (category == 'Reciente') return; // Saltar 'Reciente' por ahora

      List<Map<String, dynamic>> ownedInCategory = [];
      for (var baseItemMap in baseItemsList) {
        final String? itemId =
            baseItemMap['id']
                as String?; // Asegúrate que 'id' existe y es String
        if (itemId != null && purchasedItemIds.contains(itemId)) {
          // Determinar si este ítem estaba 'selected' (equipado)
          bool isCurrentlySelected = false;
          if (category == 'Planta' &&
              baseItemMap['display'] == loadedPlantaEquipada) {
            isCurrentlySelected = true;
            if (firstOwnedPlantDisplay == null) {
              // Asegurar que la planta equipada es la primera opción si es la única
              firstOwnedPlantDisplay = baseItemMap['display'] as String?;
            }
          } else if (category == 'Sombrero' &&
              baseItemMap['img'] == loadedSombreroEquipado) {
            isCurrentlySelected = true;
          } else if (category == 'Cara' &&
              baseItemMap['img'] == loadedCaraEquipada) {
            isCurrentlySelected = true;
          } else if (category == 'Cuerpo' &&
              baseItemMap['img'] == loadedCuerpoEquipado) {
            isCurrentlySelected = true;
          }
          ownedInCategory.add({
            ...baseItemMap,
            'selected':
                isCurrentlySelected, // <--- Usar el estado cargado o calculado
          });
        }
      }
      tempOwnedItems[category] = ownedInCategory;
    });
    plantaEquipada = loadedPlantaEquipada; // Usar el valor cargado
    sombreroEquipado = loadedSombreroEquipado;
    caraEquipada = loadedCaraEquipada;
    cuerpoEquipado = loadedCuerpoEquipado;
    // Establecer la planta equipada por defecto a la primera planta poseída
    // o mantener la actual si ya está poseída.
    bool currentPlantaEquipadaIsOwned = false;
    if (tempOwnedItems['Planta'] != null) {
      for (var plant in tempOwnedItems['Planta']!) {
        if (plant['display'] == plantaEquipada) {
          currentPlantaEquipadaIsOwned = true;
          plant['selected'] =
              true; // Marcarla como seleccionada en la lista de poseídos
          break;
        }
      }
    }

    if (!currentPlantaEquipadaIsOwned && firstOwnedPlantDisplay != null) {
      plantaEquipada = firstOwnedPlantDisplay!;
      // Marcarla como seleccionada en la lista de poseídos
      if (tempOwnedItems['Planta'] != null) {
        for (var plant in tempOwnedItems['Planta']!) {
          if (plant['display'] == plantaEquipada) {
            plant['selected'] = true;
            break;
          }
        }
      }
    } else if (!currentPlantaEquipadaIsOwned &&
        (tempOwnedItems['Planta'] == null ||
            tempOwnedItems['Planta']!.isEmpty)) {
      // No hay plantas poseídas, ¿qué hacer? Podrías tener una planta base "default" no comprable
      // o mostrar un estado vacío. Por ahora, se quedaría con el valor hardcodeado inicial.
      // O podrías establecer plantaEquipada a un asset de placeholder.
      // plantaEquipada = 'assets/plantas/placeholder_vacio.svg';
      print("Advertencia: No hay plantas poseídas para equipar por defecto.");
    }
    ['Sombrero', 'Cara', 'Cuerpo'].forEach((accCategory) {
      String? equippedAccAsset;
      if (accCategory == 'Sombrero')
        equippedAccAsset = sombreroEquipado;
      else if (accCategory == 'Cara')
        equippedAccAsset = caraEquipada;
      else if (accCategory == 'Cuerpo')
        equippedAccAsset = cuerpoEquipado;

      if (equippedAccAsset != null && tempOwnedItems[accCategory] != null) {
        bool foundEquippedAndOwned = false;
        for (var item in tempOwnedItems[accCategory]!) {
          if (item['img'] == equippedAccAsset) {
            item['selected'] = true;
            foundEquippedAndOwned = true;
          } else {
            item['selected'] = false;
          }
        }
        if (!foundEquippedAndOwned) {
          // El accesorio equipado guardado ya no se posee
          if (accCategory == 'Sombrero')
            sombreroEquipado = null;
          else if (accCategory == 'Cara')
            caraEquipada = null;
          else if (accCategory == 'Cuerpo')
            cuerpoEquipado = null;
        }
      } else if (equippedAccAsset != null) {
        // Estaba equipado pero la categoría ahora está vacía (todos los items de esa categoría fueron "vendidos" hipotéticamente)
        if (accCategory == 'Sombrero')
          sombreroEquipado = null;
        else if (accCategory == 'Cara')
          caraEquipada = null;
        else if (accCategory == 'Cuerpo')
          cuerpoEquipado = null;
      }
    });
    setState(() {
      itemsPorCategoria = tempOwnedItems; // Actualiza el mapa que usa la UI
      _isLoading = false; // Finalizar carga
    });
    actualizarRecientes(); // Actualiza la categoría 'Reciente' con los seleccionados/equipados
  }

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
      // Asegúrate de que `itemsPorCategoria` se está modificando correctamente.
      // Si `itemsPorCategoria` es el mapa que usa la UI, esta es la forma.
      Map<String, List<Map<String, dynamic>>> updatedItems = Map.from(
        itemsPorCategoria,
      );
      updatedItems['Reciente'] = recientes;
      itemsPorCategoria = updatedItems;
    });
  }

  Future<void> _saveEquippedItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'equipped_planta',
      plantaEquipada,
    ); // plantaEquipada ya es un String

    if (sombreroEquipado != null) {
      await prefs.setString('equipped_sombrero', sombreroEquipado!);
    } else {
      await prefs.remove('equipped_sombrero');
    }

    if (caraEquipada != null) {
      await prefs.setString('equipped_cara', caraEquipada!);
    } else {
      await prefs.remove('equipped_cara');
    }

    if (cuerpoEquipado != null) {
      await prefs.setString('equipped_cuerpo', cuerpoEquipado!);
    } else {
      await prefs.remove('equipped_cuerpo');
    }
    print("ARMARIO: Estado equipado guardado en SharedPreferences.");
  }

  final List<String> categorias = [
    'Reciente',
    'Planta',
    'Sombrero',
    'Cara',
    'Cuerpo',
  ];

  final Map<String, List<Map<String, dynamic>>> _baseItemsPorCategoria = {
    'Reciente': [],
    'Planta': [
      {
        'id': 'plant1',
        'img': 'assets/plantas/plantauno.svg',
        'selected': false,
        'display': 'assets/plantas/cactus.svg',
      },
      {
        'id': 'plant4',
        'img': 'assets/plantas/plantados.svg',
        'selected': false,
        'display': 'assets/plantas/Girasol.svg',
      },
      {
        'id': 'plant6',
        'img': 'assets/plantas/plantatres.svg',
        'selected': false,
        'display': 'assets/plantas/sprout.svg',
      },
      {
        'id': 'plant2',
        'img': 'assets/plantas/plantacuatro.svg',
        'selected': false,
        'display': 'assets/plantas/carnivora.svg',
      },
      {
        'id': 'plant3',
        'img': 'assets/plantas/plantacinco.svg',
        'selected': false,
        'display': 'assets/plantas/bambu.svg',
      },
      {
        'id': 'plant5',
        'img': 'assets/plantas/plantaseis.svg',
        'selected': false,
        'display': 'assets/plantas/lotus.svg',
      },
      {
        'id': 'Plant7',
        'img': 'assets/plantas/plantasiete.svg',
        'selected': false,
        'display': 'assets/plantas/Planeta.svg',
      },
      // Add more items if needed for testing layout
    ],
    'Sombrero': [
      {'id': 'Hat1', 'img': 'assets/sombreros/cono.svg', 'selected': false},
      {'id': 'Hat2', 'img': 'assets/sombreros/beanie.svg', 'selected': false},
      {'id': 'Hat3', 'img': 'assets/sombreros/cowboy.svg', 'selected': false},
      {'id': 'Hat4', 'img': 'assets/sombreros/halo.svg', 'selected': false},
      {'id': 'Hat5', 'img': 'assets/sombreros/monho.svg', 'selected': false},
    ],
    'Cara': [
      // ASIGNA IDs a estos que coincidan con los IDs de tus ShopItems de cara
      {
        'id': 'face5',
        'img': 'assets/cara/gadas.svg',
        'selected': false,
      }, // Gafas de Sol
      {
        'id': 'face1',
        'img': 'assets/cara/curita.svg',
        'selected': false,
      }, // Curita
      {
        'id': 'face4',
        'img': 'assets/cara/payaso.svg',
        'selected': false,
      }, // Payaso
      {
        'id': 'face2',
        'img': 'assets/cara/pestenegra.svg',
        'selected': false,
      }, // Peste Negra
      {
        'id': 'face3',
        'img': 'assets/cara/tapabocasvr1.svg',
        'selected': false,
      }, // Tapabocas
    ],
    'Cuerpo': [
      // ASIGNA IDs a estos que coincidan con los IDs de tus ShopItems de cuerpo
      {
        'id': 'body4',
        'img': 'assets/cuerpo/alas.svg',
        'selected': false,
      }, // Alas
      {
        'id': 'body1',
        'img': 'assets/cuerpo/bufanda.svg',
        'selected': false,
      }, // Bufanda
      {
        'id': 'body3',
        'img': 'assets/cuerpo/canguro.svg',
        'selected': false,
      }, // Canguro
      {
        'id': 'body2',
        'img': 'assets/cuerpo/capa.svg',
        'selected': false,
      }, // Capa
      {
        'id': 'body5',
        'img': 'assets/cuerpo/corbata.svg',
        'selected': false,
      }, // Corbata
    ],
  };
  Map<String, List<Map<String, dynamic>>> itemsPorCategoria = {
    'Reciente': [],
    'Planta': [],
    'Sombrero': [],
    'Cara': [],
    'Cuerpo': [],
  };

  final Map<String, List<Map<String, dynamic>>> multiSlotSombreroConfigs = {
    'assets/plantas/bambu.svg': [
      {'top': -20, 'left': 84.0 + 90, 'scale': 2.0, 'rotation': 0.6},
      {'top': 48.0, 'left': 124.0 + 90, 'scale': 2.0, 'rotation': 0.0},
    ],
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCaraConfigs = {
    'assets/plantas/bambu.svg': [
      {'top': 80, 'left': -94.0 + 96, 'scale': .1, 'rotation': 0},
      {'top': 168.0, 'left': -44.0 + 96, 'scale': .1, 'rotation': 0.0},
    ],
  };
  final Map<String, List<Map<String, dynamic>>> multiSlotCuerpoConfigs = {
    'assets/plantas/bambu.svg': [
      {
        'top': 188,
        'left': 84.0 + 96,
        'scale': 2.0,
        'rotation': 0.0,
        'isBehind': false,
      },
      {
        'top': 288,
        'left': 138.0 + 96,
        'scale': 2.0,
        'rotation': 0.0,
        'isBehind': false,
      },
    ],
  };

  final Map<String, Map<String, Map<String, dynamic>>> sombreroConfigs = {
    'assets/plantas/cactus.svg': {
      // Plant: Cactus
      'assets/sombreros/cono.svg': {
        // Accessory: Cono
        'top': -.0, 'left': 188.0, 'scale': 3.5, 'rotation': 0.0,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -10.0,
        'left': 182.0,
        'scale': 3.2,
        'rotation': -0.32, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': 8.0,
        'left': 152.0,
        'scale': 2.8,
        'rotation': 0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -25.0,
        'left': 160.0,
        'scale': 2,
        'rotation': 0.0,
      },
      'assets/sombreros/monho.svg': {
        'top': 8.0,
        'left': 210.0,
        'scale': 2,
        'rotation': 0.3,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 218.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -10.0,
        'left': 188.0,
        'scale': 3.2,
        'rotation': -0.32, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': 24.0,
        'left': 192.0,
        'scale': 3.0,
        'rotation': 0.3,
      },
      'assets/sombreros/halo.svg': {
        'top': -10.0,
        'left': 192.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
      'assets/sombreros/monho.svg': {
        'top': 20.0,
        'left': 210.0,
        'scale': 3.0,
        'rotation': 0.15,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/sombreros/cono.svg': {
        'top': -24.0,
        'left': 138.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -24.0,
        'left': 138.0,
        'scale': 2.5,
        'rotation': -0.1, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': -24.0,
        'left': 138.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/halo.svg': {
        'top': -24.0,
        'left': 138.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
      'assets/sombreros/monho.svg': {
        'top': -24.0,
        'left': 138.0,
        'scale': 2.5,
        'rotation': -0.1,
      },
    },

    'assets/plantas/carnivora.svg': {
      'assets/sombreros/cono.svg': {
        'top': -4.0,
        'left': 214.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -4.0,
        'left': 214.0,
        'scale': 2.0,
        'rotation': 0.6, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': 12.0,
        'left': 208.0,
        'scale': 2.0,
        'rotation': 1,
      },
      'assets/sombreros/halo.svg': {
        'top': -4.0,
        'left': 214.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
      'assets/sombreros/monho.svg': {
        'top': 24.0,
        'left': 220.0,
        'scale': 2.0,
        'rotation': 0.6,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/sombreros/cono.svg': {
        'top': -20.0,
        'left': 266.0,
        'scale': 4.0,
        'rotation': 0.3,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -20.0,
        'left': 266.0,
        'scale': 4.0,
        'rotation': 0.3, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': -12.0,
        'left': 270.0,
        'scale': 3.0,
        'rotation': 0.6,
      },
      'assets/sombreros/halo.svg': {
        'top': -20.0,
        'left': 276.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
      'assets/sombreros/monho.svg': {
        'top': 24.0,
        'left': 276.0,
        'scale': 2.0,
        'rotation': 0.3,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/sombreros/cono.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 6.0,
        'rotation': 0.6,
      },
      'assets/sombreros/beanie.svg': {
        // Accessory: Beanie
        'top': -30.0,
        'left': 294.0,
        'scale': 5.0,
        'rotation': 0.3, // Example different values
      },
      'assets/sombreros/cowboy.svg': {
        'top': 10.0,
        'left': 294.0,
        'scale': 3.0,
        'rotation': 1,
      },
      'assets/sombreros/halo.svg': {
        'top': -30.0,
        'left': 294.0,
        'scale': 3.0,
        'rotation': 0.6,
      },
      'assets/sombreros/monho.svg': {
        'top': 10.0,
        'left': 294.0,
        'scale': 3.0,
        'rotation': 0.6,
      },
    },
  };

  final Map<String, Map<String, Map<String, dynamic>>> caraConfigs = {
    'assets/plantas/cactus.svg': {
      'assets/cara/gadas.svg': {
        'top': 50,
        'left': -60.0 + 90,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/curita.svg': {
        'top': 25,
        'left': 44.0 + 90,
        'scale': .3,
        'rotation': 0.6,
      },
      'assets/cara/payaso.svg': {
        'top': -50,
        'left': -60.0 + 90,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 32,
        'left': 20.0 + 90,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 28,
        'left': -120.0 + 90,
        'scale': .3,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/cara/gadas.svg': {
        'top': 45,
        'left': -60 + 90,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 25,
        'left': 44.0 + 90,
        'scale': .3,
        'rotation': 0.6,
      },
      'assets/cara/payaso.svg': {
        'top': -50,
        'left': -60.0 + 90,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 32,
        'left': 20.0 + 90,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 0,
        'left': -126.0 + 90,
        'scale': .2,
        'rotation': 0.0,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cara/gadas.svg': {
        'top': 196,
        'left': -24.0 + 60,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 175,
        'left': 72.0 + 60,
        'scale': .15,
        'rotation': 1.5,
      },
      'assets/cara/payaso.svg': {
        'top': 100,
        'left': -26.0 + 60,
        'scale': .1,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 188,
        'left': 20.0 + 60,
        'scale': .2,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 136,
        'left': -94.0 + 60,
        'scale': .08,
        'rotation': 0,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/cara/gadas.svg': {
        'top': -36,
        'left': -80 + 90,
        'scale': .3,
        'rotation': 0.4,
      },
      'assets/cara/curita.svg': {
        'top': -44,
        'left': -12 + 90,
        'scale': .3,
        'rotation': 0.1,
      },
      'assets/cara/payaso.svg': {
        'top': -84,
        'left': -114 + 90,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': -20,
        'left': -16 + 90,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': -56,
        'left': -172 + 90,
        'scale': 0.4,
        'rotation': 0,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cara/gadas.svg': {
        'top': 45,
        'left': -32 + 70,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/curita.svg': {
        'top': 16,
        'left': 54 + 78,
        'scale': .3,
        'rotation': .6,
      },
      'assets/cara/payaso.svg': {
        'top': -68,
        'left': -32 + 70,
        'scale': .3,
        'rotation': 0.0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 24,
        'left': 34 + 70,
        'scale': .6,
        'rotation': 0.0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 0,
        'left': -96 + 50,
        'scale': .2,
        'rotation': 0.0,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cara/gadas.svg': {
        'top': 94,
        'left': 16 + 10,
        'scale': .5,
        'rotation': 0,
      },
      'assets/cara/curita.svg': {
        'top': 94,
        'left': 136 + 10,
        'scale': .5,
        'rotation': -0.6,
      },
      'assets/cara/payaso.svg': {
        'top': 64,
        'left': 16 + 0,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/pestenegra.svg': {
        'top': 124,
        'left': 124 + 10,
        'scale': 1,
        'rotation': 0,
      },
      'assets/cara/tapabocasvr1.svg': {
        'top': 124,
        'left': -44 + 0,
        'scale': .5,
        'rotation': 0,
      },
    },
  };

  final Map<String, Map<String, Map<String, dynamic>>> cuerpoConfigs = {
    'assets/plantas/cactus.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 188,
        'left': 110 + 90,
        'scale': 2.5,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 188,
        'left': 82 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 270,
        'left': 92 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 212,
        'left': 64 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 156,
        'left': 32 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
    },
    'assets/plantas/Girasol.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 196,
        'left': 110 + 90,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 196,
        'left': 82 + 90,
        'scale': 1.7,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 192,
        'left': 92 + 90,
        'scale': 2,
        'rotation': 0.0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 212,
        'left': 64 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 156,
        'left': 32 + 90,
        'scale': 1.8,
        'rotation': 0.0,
        'isBehind': true,
      },
    },
    'assets/plantas/sprout.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 300,
        'left': 146 + 90,
        'scale': 2,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 284,
        'left': 116 + 90,
        'scale': 1,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 284,
        'left': 124 + 90,
        'scale': 1,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 196,
        'left': 86 + 90,
        'scale': 1,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 196,
        'left': 54 + 90,
        'scale': 1,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/carnivora.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 104,
        'left': 144.0 + 90,
        'scale': 3,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 162,
        'left': 124.0 + 90,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 232,
        'left': 64 + 90,
        'scale': 2.8,
        'rotation': 1,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 162,
        'left': 124.0 + 90,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 162,
        'left': 32.0 + 90,
        'scale': 1.8,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/lotus.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 204,
        'left': 142 + 90,
        'scale': 3.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 240,
        'left': 112 + 90,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 232,
        'left': 120 + 90,
        'scale': 3.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 150,
        'left': 100 + 90,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 150,
        'left': 54 + 90,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': true,
      },
    },
    'assets/plantas/Planeta.svg': {
      'assets/cuerpo/corbata.svg': {
        'top': 360.0,
        'left': 194.0 + 90,
        'scale': 5.0,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/bufanda.svg': {
        'top': 360.0,
        'left': 168.0 + 90,
        'scale': 2.5,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/canguro.svg': {
        'top': 360.0,
        'left': 172.0 + 90,
        'scale': 5.0,
        'rotation': 0,
        'isBehind': false,
      },
      'assets/cuerpo/capa.svg': {
        'top': 124.0,
        'left': 96.0 + 90,
        'scale': 3,
        'rotation': 0,
        'isBehind': true,
      },
      'assets/cuerpo/alas.svg': {
        'top': 124.0,
        'left': 96.0 + 90,
        'scale': 3,
        'rotation': 0,
        'isBehind': true,
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
    final items = itemsPorCategoria[categoriaActual] ?? [];

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

        final double heightScaleFactor =
            actualPlantDisplayHeight / designPlantDisplayHeight;
        final double widthScaleFactor =
            actualPlantDisplayWidth / designPlantDisplayWidth;
        final double accessoryScaleFactor = heightScaleFactor;

        // --- NEW: Determine if current body item should be behind ---
        Map<String, dynamic>? currentSingleSlotCuerpoConfig;
        bool isCuerpoBehind = false;

        if (cuerpoEquipado != null &&
            !multiSlotCuerpoConfigs.containsKey(
              plantaEquipada,
            ) && // Only for single-slot
            cuerpoConfigs.containsKey(plantaEquipada) &&
            cuerpoConfigs[plantaEquipada]!.containsKey(cuerpoEquipado!)) {
          currentSingleSlotCuerpoConfig =
              cuerpoConfigs[plantaEquipada]![cuerpoEquipado!]!;
          isCuerpoBehind =
              (currentSingleSlotCuerpoConfig['isBehind'] as bool?) ?? false;
        }
        // --- END NEW ---

        return Scaffold(
          backgroundColor: const Color.fromRGBO(247, 246, 235, 1),
          body: Container(
            clipBehavior: Clip.none,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.70,
                  child: SvgPicture.asset(
                    'assets/armariobk.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      SizedBox(height: relHeight(24 + 64 + 10)),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            // The AnimatedSwitcher's child is now correctly structured:
                            child: SizedBox(
                              key: ValueKey(
                                plantaEquipada +
                                    (cuerpoEquipado ?? "") +
                                    (sombreroEquipado ?? "") +
                                    (caraEquipada ?? ""),
                              ), // More robust key for AnimatedSwitcher
                              height: actualPlantDisplayHeight,
                              width: actualPlantDisplayWidth,
                              child: Stack(
                                // This is where layering happens
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  // --- 1. RENDER "BEHIND" CUERPO ITEMS ---
                                  if (cuerpoEquipado != null &&
                                      isCuerpoBehind &&
                                      currentSingleSlotCuerpoConfig != null)
                                    () {
                                      // Using self-invoking function for clarity
                                      final Map<String, dynamic> itemConfig =
                                          currentSingleSlotCuerpoConfig!;
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
                                            accessoryScaleFactor,
                                        rotationValue: originalRotation,
                                        typeKey: 'cuerpo_single_behind',
                                      );
                                    }(),

                                  // --- 2. RENDER PLANT ---
                                  SvgPicture.asset(
                                    plantaEquipada,
                                    key: ValueKey(
                                      "plant_display_$plantaEquipada",
                                    ),
                                    height: relHeight(
                                      400,
                                    ), // Consider using actualPlantDisplayHeight
                                  ),

                                  // --- 3. RENDER SOMBRERO (always in front of plant) ---
                                  if (sombreroEquipado != null)
                                    if (multiSlotSombreroConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotSombreroConfigs[plantaEquipada] ??
                                              [])
                                          .map((slotConfig) {
                                            // ... (your existing multi-slot sombrero logic)
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
                                                  accessoryScaleFactor,
                                              rotationValue: originalRotation,
                                              typeKey:
                                                  'sombrero_multi_${slotConfig.hashCode}',
                                            );
                                          })
                                          .toList()
                                    else if (sombreroConfigs.containsKey(
                                          plantaEquipada,
                                        ) &&
                                        sombreroConfigs[plantaEquipada]!
                                            .containsKey(sombreroEquipado!))
                                      () {
                                        // ... (your existing single-slot sombrero logic)
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
                                              accessoryScaleFactor,
                                          rotationValue: originalRotation,
                                          typeKey: 'sombrero_single',
                                        );
                                      }(),

                                  // --- 4. RENDER CARA (always in front of plant) ---
                                  if (caraEquipada != null)
                                    if (multiSlotCaraConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotCaraConfigs[plantaEquipada] ??
                                              [])
                                          .map((slotConfig) {
                                            // ... (your existing multi-slot cara logic)
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
                                                  accessoryScaleFactor,
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
                                        // ... (your existing single-slot cara logic)
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
                                              accessoryScaleFactor,
                                          rotationValue: originalRotation,
                                          typeKey: 'cara_single',
                                        );
                                      }(),

                                  // --- 5. RENDER "FRONT" or MULTI-SLOT CUERPO ITEMS ---
                                  if (cuerpoEquipado != null &&
                                      !isCuerpoBehind) // Render if NOT behind (i.e., front or multi-slot)
                                    if (multiSlotCuerpoConfigs.containsKey(
                                      plantaEquipada,
                                    ))
                                      ...(multiSlotCuerpoConfigs[plantaEquipada] ?? []).map((
                                        slotConfig,
                                      ) {
                                        // Multi-slot cuerpo items. Assumed to be in front.
                                        // If a multi-slot body item could be behind, each slotConfig would need 'isBehind'.
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
                                        // bool isSlotBehind = (slotConfig['isBehind'] as bool?) ?? false; // Future: if needed
                                        return _buildAccessoryWidget(
                                          accessoryPath: cuerpoEquipado!,
                                          responsiveTopPx:
                                              originalTop * heightScaleFactor,
                                          responsiveLeftPx:
                                              originalLeft * widthScaleFactor,
                                          responsiveScale:
                                              originalScale *
                                              accessoryScaleFactor,
                                          rotationValue: originalRotation,
                                          typeKey:
                                              'cuerpo_multi_front_${slotConfig.hashCode}',
                                        );
                                      }).toList()
                                    else if (cuerpoConfigs.containsKey(
                                          plantaEquipada,
                                        ) &&
                                        cuerpoConfigs[plantaEquipada]!
                                            .containsKey(cuerpoEquipado!))
                                      () {
                                        // Single-slot cuerpo items that are configured to be in front (or default to front)
                                        final Map<String, dynamic> itemConfig =
                                            currentSingleSlotCuerpoConfig ??
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
                                              accessoryScaleFactor,
                                          rotationValue: originalRotation,
                                          typeKey: 'cuerpo_single_front',
                                        );
                                      }(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ... (rest of your Column for buttons and items grid - no changes needed here for layering)
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
                                                // Categoria: categoriaActual, // Corrected to lowercase 'c'
                                                categoria: categoriaActual,
                                                onTap: () {
                                                  setState(() {
                                                    // ... (Your existing onTap logic for ItemEquipado)
                                                    // This part was fine, just make sure 'isBehind' doesn't affect selection logic.
                                                    // Selection logic should purely be about what's equipped, not its render order.
                                                    final String tappedItemImg =
                                                        item['img'];
                                                    final String?
                                                    tappedItemDisplayPath =
                                                        item['display'];

                                                    if (categoriaActual ==
                                                        'Planta') {
                                                      if (plantaEquipada !=
                                                              tappedItemDisplayPath &&
                                                          tappedItemDisplayPath !=
                                                              null) {
                                                        for (var p
                                                            in itemsPorCategoria['Planta']!) {
                                                          p['selected'] =
                                                              (p['display'] ==
                                                                  tappedItemDisplayPath);
                                                        }
                                                        plantaEquipada =
                                                            tappedItemDisplayPath;
                                                        actualizarRecientes();
                                                        _saveEquippedItems();
                                                      }
                                                    } else if (categoriaActual ==
                                                            'Sombrero' ||
                                                        categoriaActual ==
                                                            'Cara' ||
                                                        categoriaActual ==
                                                            'Cuerpo') {
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
                                                        // Unequip
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
                                                        item['selected'] =
                                                            false;
                                                      } else {
                                                        // Equip new
                                                        for (var otherItem
                                                            in itemsPorCategoria[categoriaActual]!) {
                                                          otherItem['selected'] =
                                                              false;
                                                        }
                                                        item['selected'] = true;
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
                                                      _saveEquippedItems();
                                                    } else if (categoriaActual ==
                                                        'Reciente') {
                                                      final String
                                                      originalCategory =
                                                          item['originalCategory'];
                                                      final String
                                                      itemIdentifierInReciente =
                                                          (originalCategory ==
                                                                  'Planta')
                                                              ? item['display']
                                                              : item['img'];

                                                      if (originalCategory ==
                                                          'Planta') {
                                                        return; // Tapping plant in reciente does nothing here
                                                      } else {
                                                        // Accessory in Reciente: Unequip
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
                                                          if (itemsPorCategoria
                                                              .containsKey(
                                                                originalCategory,
                                                              )) {
                                                            for (var originalItem
                                                                in itemsPorCategoria[originalCategory]!) {
                                                              if (originalItem['img'] ==
                                                                  itemIdentifierInReciente) {
                                                                // Match by img for accessories
                                                                originalItem['selected'] =
                                                                    false;
                                                                break;
                                                              }
                                                            }
                                                          }
                                                          actualizarRecientes();
                                                          _saveEquippedItems();
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
                // ... (rest of your header and side buttons - no changes needed here)
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
                              color: Color.fromRGBO(247, 246, 235, 1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.eco_rounded,
                                  color: const Color(0xFF355E3B),
                                  size: relWidth(20),
                                ),
                                SizedBox(width: relWidth(4)),
                                Text(
                                  '1500', // This should probably be dynamic
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
                  bottom: relHeight(350),
                  right: relWidth(4),
                  child: SideButtons(
                    showArmario: false,
                    onTiendaTap: () {
                      Navigator.pushNamed(context, '/tienda').then((value) {
                        _loadAndFilterOwnedItems();
                      });
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

  // ... _iconoCategoria remains the same
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
} // End of _ArmarioScreenState

class ItemEquipado extends StatelessWidget {
  final String imagen;
  final bool seleccionado;
  final VoidCallback onTap;
  // final String Categoria; // Corrected to lowercase 'c'
  final String categoria;

  const ItemEquipado({
    super.key,
    required this.imagen,
    required this.seleccionado,
    required this.onTap,
    // required this.Categoria, // Corrected
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // A more robust way to calculate itemSize to fit, for example, 3 items per row with spacing
    final double totalSpacing = 12.0 * (3 - 1); // spacing * (itemsPerRow - 1)
    final double availableWidth =
        screenWidth -
        (16 * 2) -
        totalSpacing; // screenWidth - padding - totalSpacing
    final itemSize =
        availableWidth /
        3.2; // Divide by itemsPerRow (adjust 3.2 for desired size)

    final double
    scaleFactor = // Renamed 'scale' to 'scaleFactor' to avoid confusion
        (categoria == 'Sombrero' ||
                categoria == 'Cara' ||
                categoria == 'Cuerpo')
            ? 0.2 // This seems very small, check if it's intended
            : 0.8;

    final Widget imageWidget =
        imagen.toLowerCase().endsWith('.svg')
            ? SvgPicture.asset(
              imagen,
              width: itemSize * 0.8, // Use a portion of itemSize
              height: itemSize * 0.8, // Use a portion of itemSize
              fit: BoxFit.contain, // Added fit
            )
            : Image.asset(
              // For non-SVG, using scaleFactor as before
              imagen,
              width: 80 * scaleFactor,
              height: 80 * scaleFactor,
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
                  (categoria == 'Sombrero' || // Used corrected 'categoria'
                          categoria == 'Cara' ||
                          categoria == 'Cuerpo')
                      ? Alignment.center
                      : Alignment.bottomCenter,
              child: Padding(
                // Added padding for better visual appearance of the image inside the box
                padding: const EdgeInsets.all(4.0),
                child: imageWidget,
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
      ),
    );
  }
}
