import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/shopitem.dart'; // Asegúrate que ShopItem tenga isPurchased
import 'package:a/widgets/button.dart' as button;
import 'package:a/widgets/item_detail_popup.dart'; // Modificaremos este
import 'package:a/widgets/statusPopup.dart'; // <-- Asegúrate de importar donde está StatusPopup
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

// --- NoGlowScrollBehavior (sin cambios) ---
class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

// --- Datos Iniciales de la Tienda (sin cambios en la estructura, pero ShopItem ahora tiene isPurchased) ---
// Nota: Ya no será 'final' dentro del estado del widget, sino una copia.
// Esta definición global puede seguir siendo 'final' para la data original.
final List<List<ShopItem>> initialShelvesData = [
  // Shelf 1 (Plants)
  [
    ShopItem(
      id: 'plant1',
      name: 'Cactus',
      imageAsset: 'assets/plantas/cactus.svg',
      price: 250,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant2',
      name: 'Planta Carnívora',
      imageAsset: 'assets/plantas/carnivora.svg',
      price: 250,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant3',
      name: 'Bambú',
      imageAsset: 'assets/plantas/bambu.svg',
      price: 300,
      category: 'Plants',
    ),
  ],
  // ... (resto de tus shelvesData, asegúrate que cada ShopItem se cree sin isPurchased o con isPurchased: false)
  // Shelf 2 (Face/Head)
  [
    ShopItem(
      id: 'plant4',
      name: 'Girasol',
      imageAsset: 'assets/plantas/Girasol.svg',
      price: 200,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant5',
      name: 'Flor de Loto',
      imageAsset: 'assets/plantas/lotus.svg',
      price: 250,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant6',
      name: 'Planta Brote',
      imageAsset: 'assets/plantas/sprout.svg',
      price: 0, // ¡Gratis! Se podrá "comprar" igual para marcarlo.
      category: 'Plants',
    ),
  ],
  // Shelf 3 (Face/Body)
  [
    ShopItem(
      id: 'Plant7',
      name: 'Planeta Tierra',
      imageAsset: 'assets/plantas/Planeta.svg',
      price: 400,
      category: 'Plants',
    ),
    ShopItem(
      id: 'face1',
      name: 'Curita',
      imageAsset: 'assets/cara/curita.svg',
      price: 300,
      category: 'Head',
    ),
    ShopItem(
      id: 'face2',
      name: 'Peste Negra',
      imageAsset: 'assets/cara/pestenegra.svg',
      price: 100,
      category: 'Face',
    ),
  ],
  // Shelf 4 (Body)
  [
    ShopItem(
      id: 'face3',
      name: 'Tapabocas',
      imageAsset: 'assets/cara/tapabocasvr1.svg',
      price: 75,
      category: 'Face',
    ),
    ShopItem(
      id: 'face4',
      name: 'Payaso',
      imageAsset: 'assets/cara/payaso.svg',
      price: 100,
      category: 'Face',
    ),
    ShopItem(
      id: 'face5',
      name: 'Gafas de Sol',
      imageAsset: 'assets/cara/gadas.svg',
      price: 150,
      category: 'Face',
    ),
  ],
  [
    ShopItem(
      id: 'body1',
      name: 'Bufanda',
      imageAsset: 'assets/cuerpo/bufanda.svg',
      price: 50,
      category: 'Body',
    ),
    ShopItem(
      id: 'body2',
      name: 'Capa',
      imageAsset: 'assets/cuerpo/capa.svg',
      price: 50,
      category: 'Body',
    ),
    ShopItem(
      id: 'body3',
      name: 'Canguro',
      imageAsset: 'assets/cuerpo/canguro.svg',
      price: 75,
      category: 'Body',
    ),
  ],
  [
    ShopItem(
      id: 'body4',
      name: 'Alas',
      imageAsset: 'assets/cuerpo/alas.svg',
      price: 150,
      category: 'Body',
    ),
    ShopItem(
      id: 'body5',
      name: 'Corbata',
      imageAsset: 'assets/cuerpo/corbata.svg',
      price: 100,
      category: 'Body',
    ),
    ShopItem(
      id: 'Hat1',
      name: 'Cono',
      imageAsset: 'assets/sombreros/cono.svg',
      price: 100,
      category: 'Body',
    ),
  ],
  [
    ShopItem(
      id: 'Hat2',
      name: 'Beanie',
      imageAsset: 'assets/sombreros/beanie.svg',
      price: 100,
      category: 'Body',
    ),
    ShopItem(
      id: 'Hat3',
      name: 'Sombrero de Vaquero',
      imageAsset: 'assets/sombreros/cowboy.svg',
      price: 100,
      category: 'Body',
    ),
    ShopItem(
      id: 'Hat4',
      name: 'Aureola',
      imageAsset: 'assets/sombreros/halo.svg',
      price: 100,
      category: 'Body',
    ),
  ],
  [
    ShopItem(
      id: 'Hat5',
      name: 'Moño',
      imageAsset: 'assets/sombreros/monho.svg',
      price: 100,
      category: 'Body',
    ),
  ],
];

// --- BoutiqueScreen ahora es StatefulWidget ---
class BoutiqueScreen extends StatefulWidget {
  const BoutiqueScreen({super.key});

  @override
  State<BoutiqueScreen> createState() => _BoutiqueScreenState();
}

class _BoutiqueScreenState extends State<BoutiqueScreen> {
  late int _userCurrency;
  late List<List<ShopItem>> _shelvesDataState; // Estado mutable de los ítems

  @override
  void initState() {
    super.initState();
    _userCurrency = 1000;
    _shelvesDataState =
        initialShelvesData.map((shelf) {
          return shelf.map((item) {
            return ShopItem(
              id: item.id,
              name: item.name,
              imageAsset: item.imageAsset,
              price: item.price,
              category: item.category,
              isPurchased: item.isPurchased,
            );
          }).toList();
        }).toList();
    _loadPurchasedItemsFromPrefs(); // <--- NUEVO: Cargar items ya comprados al iniciar
  }

  Future<void> _loadPurchasedItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> purchasedItemIds = prefs.getStringList('purchasedItems') ?? [];
    if (purchasedItemIds.isNotEmpty) {
      setState(() {
        for (var shelf in _shelvesDataState) {
          for (var item in shelf) {
            if (purchasedItemIds.contains(item.id)) {
              item.isPurchased = true;
            }
          }
        }
      });
      print(
        "TIENDA: Estado isPurchased cargado desde SharedPreferences para IDs: $purchasedItemIds",
      );
    }
  }

  Future<T?> _showAppStatusDialog<T>(
    BuildContext context,
    Widget dialogContent,
  ) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true, // Permite cerrar tocando fuera
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.2), // Color del fondo oscurecido
      transitionDuration: const Duration(
        milliseconds: 250,
      ), // Duración de la animación
      pageBuilder: (
        BuildContext buildContext, // Contexto para el contenido del diálogo
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        // Contenido principal del diálogo
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 3.5,
                sigmaY: 3.5,
              ), // Efecto blur
              child: Container(color: Colors.transparent),
            ),
            dialogContent, // Tu StatusPopup
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animación de entrada/salida
        final scaleTween = Tween<double>(begin: 0.9, end: 1.0);
        final curveForScale = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack, // Curva para la animación de escala
          reverseCurve: Curves.easeInCubic,
        );
        final finalScaleAnimation = scaleTween.animate(curveForScale);
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(scale: finalScaleAnimation, child: child),
        );
      },
    );
  }

  Future<void> _handlePurchase(ShopItem purchasedItem) async {
    // <--- El tipo debe ser ShopItem
    // Tu lógica de compra...
    if (_userCurrency >= purchasedItem.price && !purchasedItem.isPurchased) {
      setState(() {
        _userCurrency -= purchasedItem.price;
        // Encuentra el ítem en _shelvesDataState y actualiza isPurchased
        for (var shelf in _shelvesDataState) {
          for (var itemInShelf in shelf) {
            // Renombrado para evitar confusión con purchasedItem
            if (itemInShelf.id == purchasedItem.id) {
              itemInShelf.isPurchased = true;
              break;
            }
          }
        }
      });
      final prefs = await SharedPreferences.getInstance();
      List<String> purchasedItemIds =
          prefs.getStringList('purchasedItems') ?? [];
      if (!purchasedItemIds.contains(purchasedItem.id)) {
        purchasedItemIds.add(purchasedItem.id);
        await prefs.setStringList('purchasedItems', purchasedItemIds);
        // ESTE PRINT ES CLAVE PARA DEPURAR:
        print(
          "TIENDA: Guardado en SharedPreferences. ID: ${purchasedItem.id}, Lista actual: $purchasedItemIds",
        );
      }
      Navigator.of(context).pop(); // Cierra el ItemDetailPopup
      _showAppStatusDialog(
        // Usa el helper definido arriba
        context, // El contexto de BoutiqueScreen
        StatusPopup(
          type:
              StatusPopupType
                  .success, // Asegúrate que tu StatusPopup maneja este tipo
          title: "¡Compra realizada!",
          message: "Tu artículo se ha añadido con éxito. ¡Disfrútalo!",
          actions: [
            StatusPopupButton(
              text: "Aceptar",
              isPrimary: true,
              onPressed: () {
                // Cierra el StatusPopup de éxito
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      // Opcional: Manejar el caso donde la compra falla aquí también, aunque ItemDetailPopup ya lo previene.
      // Esto podría ser un fallback o si se llama _handlePurchase desde otro lugar.
      Navigator.of(context).pop(); // Cierra el ItemDetailPopup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            purchasedItem.isPurchased
                ? '${purchasedItem.name} ya había sido comprado.'
                : 'No se pudo completar la compra.',
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  // Dentro de la clase _BoutiqueScreenState en BoutiqueScreen.dart

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 956);

    const Color priceChipColor = Color.fromRGBO(229, 233, 228, 1);
    const Color textBrownColor = Color(0xFF6A4B3A);
    const Color greenAccent = Color(0xFF6B8E23);

    final double fixedHeaderHeight = screenHeight * 0.15;
    final double topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final double totalTopOffsetForScrollableContent =
        fixedHeaderHeight + topSafeAreaPadding;

    return Scaffold(
      backgroundColor: const Color(0xFFE9C982),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: const NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: totalTopOffsetForScrollableContent),
              child: Stack(
                children: [
                  Positioned.fill(
                    top: -totalTopOffsetForScrollableContent,
                    child: SvgPicture.asset(
                      'assets/tiendabk2.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Text(
                          'Boutique Botánica',
                          style: GoogleFonts.agbalumo(
                            fontSize: 32,
                            color: const Color.fromRGBO(122, 101, 69, 1),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        itemCount: _shelvesDataState.length, // Usar el estado
                        itemBuilder: (context, shelfIndex) {
                          final List<ShopItem> currentShelfItems =
                              _shelvesDataState[shelfIndex]; // Usar el estado
                          return _ShelfWidget(
                            items: currentShelfItems,
                            shelfColor: Colors.transparent,
                            shelfAccentDark: Colors.transparent,
                            priceChipColor: priceChipColor,
                            textBrownColor: textBrownColor,
                            greenAccent: greenAccent,
                            onItemTap: (ShopItem itemData) {
                              // No abrir popup si ya está comprado, o mostrar uno diferente
                              // Por ahora, lo abrimos igual pero el popup manejará el estado "comprado"
                              print(
                                'Tapped on: ${itemData.name} for ${itemData.price} (Purchased: ${itemData.isPurchased})',
                              );
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel:
                                    MaterialLocalizations.of(
                                      context,
                                    ).modalBarrierDismissLabel,
                                barrierColor: Colors.black.withOpacity(0.2),
                                transitionDuration: const Duration(
                                  milliseconds: 300,
                                ),
                                pageBuilder: (
                                  BuildContext buildContext,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                ) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      BackdropFilter(
                                        filter: ui.ImageFilter.blur(
                                          sigmaX: 3.5,
                                          sigmaY: 3.5,
                                        ),
                                        child: Container(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      // PASAMOS LA FUNCIÓN _handlePurchase y el estado actual de userCurrency
                                      ItemDetailPopup(
                                        item: itemData,
                                        userCurrency:
                                            _userCurrency, // El estado actual de la moneda
                                        onPurchaseConfirmed:
                                            _handlePurchase, // La función del _BoutiqueScreenState
                                      ),
                                    ],
                                  );
                                },
                                transitionBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  final scaleTween = Tween<double>(
                                    begin: 0.85,
                                    end: 1.0,
                                  );
                                  final curveForScale = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.elasticOut,
                                    reverseCurve: Curves.easeInExpo,
                                  );
                                  final finalScaleAnimation = scaleTween
                                      .animate(curveForScale);
                                  return FadeTransition(
                                    opacity: CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOutCubic,
                                    ),
                                    child: ScaleTransition(
                                      scale: finalScaleAnimation,
                                      child: child,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: fixedHeaderHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/partedearribatienda.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
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
                                    _userCurrency.toString(), // Usar el estado
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Shelf Widget (modificado para opacidad si está comprado) ---
class _ShelfWidget extends StatelessWidget {
  final List<ShopItem> items;
  final Color shelfColor;
  final Color shelfAccentDark;
  final Color priceChipColor;
  final Color textBrownColor;
  final Color greenAccent;
  final Function(ShopItem) onItemTap;

  const _ShelfWidget({
    super.key, // Añadido Key
    required this.items,
    required this.shelfColor,
    required this.shelfAccentDark,
    required this.priceChipColor,
    required this.textBrownColor,
    required this.greenAccent,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double outerHorizontalPadding = 44 * 2;
    final double shelfInternalHorizontalPadding = 10 * 2;
    final double availableWidthForShelfContent =
        screenWidth - outerHorizontalPadding - shelfInternalHorizontalPadding;
    final double spacingBetweenItems = 10 * 2;
    final double itemContainerWidth =
        (availableWidthForShelfContent - spacingBetweenItems) / 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border(
          top: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 3),
          left: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 2),
          right: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 2),
          bottom: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items.map((itemData) {
              return GestureDetector(
                // Si ya está comprado, podríamos deshabilitar el onTap o cambiar su comportamiento
                onTap:
                    () => onItemTap(
                      itemData,
                    ), // Mantenemos el tap, el popup lo gestionará
                child: Opacity(
                  opacity:
                      itemData.isPurchased
                          ? 0.6
                          : 1.0, // Opacidad si está comprado
                  child: SizedBox(
                    width: itemContainerWidth > 0 ? itemContainerWidth : 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 80,
                          width: double.infinity,
                          padding: const EdgeInsets.all(5),
                          child: Transform.scale(
                            scale: 1.15,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              itemData.imageAsset,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _PriceChip(
                          price: itemData.price,
                          isPurchased: itemData.isPurchased, // <--- NUEVO
                          chipColor: priceChipColor,
                          textColor: textBrownColor,
                          leafColor: greenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

// --- Custom Price Chip Widget (modificado para mostrar "Comprado") ---
class _PriceChip extends StatelessWidget {
  final int price;
  final bool isPurchased; // <--- NUEVO
  final Color chipColor;
  final Color textColor;
  final Color leafColor;

  const _PriceChip({
    super.key, // Añadido Key
    required this.price,
    required this.isPurchased, // <--- NUEVO
    required this.chipColor,
    required this.textColor,
    required this.leafColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(247, 246, 235, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child:
          isPurchased // <--- Condición NUEVA
              ? Text(
                'Comprado',
                style: GoogleFonts.poppins(
                  color: textColor.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 13, // Un poco más pequeño para que quepa bien
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco_rounded, color: leafColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    price.toString(),
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
    );
  }
}
