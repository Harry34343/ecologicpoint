import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/shopitem.dart'; // Assuming your ShopItem class is here
import 'package:a/widgets/button.dart' as button;
import 'package:a/widgets/item_detail_popup.dart';
import 'dart:ui' as ui;

// --- Re-using your NoGlowScrollBehavior ---
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

// (Keep your shelvesData and ShopItem class definition as they are)
// ... your shelvesData ...
// ... your ShopItem class ...
final List<List<ShopItem>> shelvesData = [
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
      price: 0,
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
  ],
];

class BoutiqueScreen extends StatelessWidget {
  const BoutiqueScreen({super.key});

  final int userCurrency = 1;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 956);

    const Color priceChipColor = Color(0xFFE6D0A4);
    const Color textBrownColor = Color(0xFF6A4B3A);
    const Color greenAccent = Color(0xFF6B8E23);

    // Height of the fixed header (awning part)
    final double fixedHeaderHeight = screenHeight * 0.15;
    // Get top padding for SafeArea, which will be applied to the fixed header.
    // The scrollable content will then need to be padded by this amount + header height.
    final double topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final double totalTopOffsetForScrollableContent =
        fixedHeaderHeight + topSafeAreaPadding;

    return Scaffold(
      backgroundColor: Color(
        0xFFE9C982,
      ), // Base color if tiendabk2.svg has transparency
      // We don't use AppBar here, manually managing the top area.
      body: Stack(
        // MASTER STACK: Layers everything
        children: [
          // --- LAYER 1: SCROLLABLE BACKGROUND (tiendabk2.svg) & SCROLLABLE CONTENT (Title, Shelves) ---
          ScrollConfiguration(
            behavior: const NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              // This padding ensures the scrollable content STARTS below the fixed header area.
              padding: EdgeInsets.only(top: totalTopOffsetForScrollableContent),
              child: Stack(
                // Inner stack for layering tiendabk2.svg behind content
                children: [
                  // 1a. Main SCROLLABLE Background SVG (tiendabk2.svg)
                  // This needs to appear as if it starts from the very top of the screen.
                  // So, we use Positioned.fill and give it a negative top offset
                  // equal to the padding we added to the SingleChildScrollView.
                  Positioned.fill(
                    top:
                        -totalTopOffsetForScrollableContent, // Offset SVG upwards
                    child: SvgPicture.asset(
                      'assets/tiendabk2.svg',
                      fit:
                          BoxFit
                              .cover, // Ensure it covers the entire scrollable area
                      // (which can be taller than the screen)
                    ),
                  ),

                  // 1b. Actual SCROLLABLE content (Title + Shelves)
                  // This Column is the content that scrolls.
                  // It's already effectively padded by the SingleChildScrollView's padding.
                  Column(
                    children: [
                      // "Boutique Botánica" Title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 44.0),
                        child: Text(
                          'Boutique Botánica',
                          style: GoogleFonts.agbalumo(
                            fontSize: 32,
                            color: Color.fromRGBO(122, 101, 69, 1),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Shelves ListView
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        itemCount: shelvesData.length,
                        itemBuilder: (context, shelfIndex) {
                          final List<ShopItem> currentShelfItems =
                              shelvesData[shelfIndex];
                          return _ShelfWidget(
                            items: currentShelfItems,
                            shelfColor: Colors.transparent,
                            shelfAccentDark: Colors.transparent,
                            priceChipColor: priceChipColor,
                            textBrownColor: textBrownColor,
                            greenAccent: greenAccent,
                            onItemTap: (ShopItem itemData) {
                              print(
                                'Tapped on: ${itemData.name} for ${itemData.price}',
                              );
                              // Usamos el helper _showAppDialog que está ahora en ItemDetailPopup,
                              // pero podríamos moverlo a un archivo de utilidades si se usa en más sitios.
                              // Aquí directamente creamos el ItemDetailPopup.
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
                                      ItemDetailPopup(
                                        item: itemData,
                                        userCurrency:
                                            userCurrency, // <<< PASA LA MONEDA AQUÍ
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
                      // Padding at the bottom of scrollable content
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- LAYER 2: FIXED TOP HEADER (Awning and Buttons) ---
          // This is positioned at the top of the master Stack, thus appearing above Layer 1.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              // Apply SafeArea to the fixed header for status bar insets
              bottom:
                  false, // Only top SafeArea is relevant for this fixed element
              child: SizedBox(
                height: fixedHeaderHeight,
                child: Stack(
                  children: [
                    // Header Awning Background (partedearribatienda.svg)
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/partedearribatienda.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Header Content (Back button and Currency)
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          // No explicit top padding here, SafeArea handles the status bar space.
                          // The content within the awning is centered.
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                    Icons.monetization_on,
                                    color: Color(0xFF355E3B),
                                    size: relWidth(20),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    userCurrency.toString(),
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

// --- Custom Shelf Widget ---
class _ShelfWidget extends StatelessWidget {
  final List<ShopItem> items;
  final Color shelfColor;
  final Color shelfAccentDark;
  final Color priceChipColor;
  final Color textBrownColor;
  final Color greenAccent;
  final Function(ShopItem) onItemTap;

  const _ShelfWidget({
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
    // Adjust availableWidth for item calculation based on outer paddings and shelf paddings
    final double outerHorizontalPadding = 40 * 2; // ListView.builder padding
    final double shelfInternalHorizontalPadding =
        10 * 2; // _ShelfWidget padding
    // final double totalHorizontalPadding = outerHorizontalPadding + shelfInternalHorizontalPadding; // This was for old logic
    final double availableWidthForShelfContent =
        screenWidth - outerHorizontalPadding - shelfInternalHorizontalPadding;
    // Assuming 3 items and approx 10px spacing between them (2 gaps)
    final double spacingBetweenItems = 10 * 2;
    final double itemContainerWidth =
        (availableWidthForShelfContent - spacingBetweenItems) / 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      // Padding is now inside the _ShelfWidget
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        // Was 0.3, making it fully transparent
        borderRadius: BorderRadius.circular(12),
        border: Border(
          // Keeping borders transparent as per your original code
          top: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 3),
          left: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 2),
          right: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 2),
          bottom: BorderSide(color: shelfAccentDark.withOpacity(0.0), width: 5),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween, // Use spaceBetween for more control with exact widths
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items.map((itemData) {
              return GestureDetector(
                onTap: () => onItemTap(itemData),
                child: SizedBox(
                  width:
                      itemContainerWidth > 0
                          ? itemContainerWidth
                          : 80, // Ensure positive width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 80, // Fixed height for images
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Transform.scale(
                          scale:
                              1.15, // <<--- INCREASE THIS VALUE (e.g., 1.1 for 10% bigger, 1.2 for 20%)
                          alignment:
                              Alignment
                                  .center, // Scale from the center of the SVG
                          child: SvgPicture.asset(
                            itemData.imageAsset,
                            fit:
                                BoxFit
                                    .contain, // Fit.contain will respect the original 80-padding space
                            // before the Transform.scale is applied.
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _PriceChip(
                        price: itemData.price,
                        chipColor: priceChipColor,
                        textColor: textBrownColor,
                        leafColor: greenAccent,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

// --- Custom Price Chip Widget ---
class _PriceChip extends StatelessWidget {
  final int price;
  final Color chipColor;
  final Color textColor;
  final Color leafColor;

  const _PriceChip({
    required this.price,
    required this.chipColor,
    required this.textColor,
    required this.leafColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 246, 235, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
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

// Ensure you have your ShopItem class defined
// class ShopItem { ... }
