import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/shopitem.dart';
import 'package:a/widgets/button.dart' as button;
// Import your ShopItem model if you created one
// import 'models/shop_item.dart';

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
      name: 'Carnivorous',
      imageAsset: 'assets/plantas/carnivora.svg',
      price: 250,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant3',
      name: 'Bamboo',
      imageAsset: 'assets/plantas/bambu.svg',
      price: 300,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant4',
      name: 'Sunflower',
      imageAsset: 'assets/plantas/Girasol.svg',
      price: 200,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant5',
      name: 'lotusflower',
      imageAsset: 'assets/plantas/lotus.svg',
      price: 250,
      category: 'Plants',
    ),
    ShopItem(
      id: 'plant6',
      name: 'sprout',
      imageAsset: 'assets/plantas/sprout.svg',
      price: 0,
      category: 'Plants',
    ),
    ShopItem(
      id: 'Plant7',
      name: 'Earth',
      imageAsset: 'assets/planras/Planeta.svg',
      price: 400,
      category: 'Plants',
    ),
  ],
  // Shelf 2 (Face/Head)
  [
    ShopItem(
      id: 'head1',
      name: 'Planet Head',
      imageAsset: 'assets/items/planet_head.svg',
      price: 300,
      category: 'Head',
    ),
    ShopItem(
      id: 'face1',
      name: 'Plague Mask',
      imageAsset: 'assets/items/plague_mask.svg',
      price: 100,
      category: 'Face',
    ),
    ShopItem(
      id: 'face2',
      name: 'Face Mask',
      imageAsset: 'assets/items/face_mask.svg',
      price: 75,
      category: 'Face',
    ),
  ],
  // Shelf 3 (Face/Body)
  [
    ShopItem(
      id: 'face3',
      name: 'Clown Face',
      imageAsset: 'assets/items/clown_face.svg',
      price: 100,
      category: 'Face',
    ),
    ShopItem(
      id: 'body1',
      name: 'Ghost Cape',
      imageAsset: 'assets/items/ghost_cape.svg',
      price: 50,
      category: 'Body',
    ),
    ShopItem(
      id: 'body2',
      name: 'Red Scarf',
      imageAsset: 'assets/items/red_scarf.svg',
      price: 50,
      category: 'Body',
    ),
  ],
  // Shelf 4 (Body)
  [
    ShopItem(
      id: 'body3',
      name: 'Angel Wings',
      imageAsset: 'assets/items/angel_wings.svg',
      price: 150,
      category: 'Body',
    ),
    ShopItem(
      id: 'body4',
      name: 'Fanny Pack',
      imageAsset: 'assets/items/fanny_pack.svg',
      price: 75,
      category: 'Body',
    ),
  ],
];
// --- Dummy Data (or import from your data file) ---
// (Paste the shelvesData list here if not importing)
// For example:
// final List<List<Map<String, dynamic>>> shelvesData = [ ... item maps ... ];
// Or if using the ShopItem class:
// final List<List<ShopItem>> shelvesData = [ ... ShopItem instances ... ];
// Make sure your dummy data item structure matches how you use it below.
// For simplicity in this example, I'll assume item is a Map.
// If using ShopItem class, access fields like item.imageAsset, item.price

class BoutiqueScreen extends StatelessWidget {
  const BoutiqueScreen({super.key});

  // Placeholder for actual user currency
  final int userCurrency = 1500;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double relWidth(double w) => MediaQuery.of(context).size.width * (w / 440);
    double relHeight(double h) =>
        MediaQuery.of(context).size.height * (h / 956);

    // Define some colors from the image
    const Color backgroundColor =
        Colors.transparent; // Light brown backgroundShelf shadow/edge
    const Color priceChipColor = Color(0xFFE6D0A4);
    const Color textBrownColor = Color(0xFF6A4B3A);
    const Color greenAccent = Color(0xFF6B8E23); // For leaf icon and price

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. Background SVG (if you have one that covers the whole screen)
          // If your background SVG is simpler, you might not need Positioned.fill
          if (true) // Set to true if you have a full-screen background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/tiendabk.svg', // Replace with your actual background
                fit: BoxFit.cover,
              ),
            ),

          // 2. Main Content Column
          SafeArea(
            bottom: false, // Usually, SafeArea is good for top content
            child: Column(
              children: [
                // 2.1 Custom Header Area
                SizedBox(
                  height: screenHeight * 0.15, // Adjust as needed
                  child: Stack(
                    children: [
                      // Header Awning Background
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/partedearribatienda.svg', // YOUR AWNING SVG
                          fit:
                              BoxFit
                                  .fill, // Or BoxFit.fitWidth and adjust height
                        ),
                      ),
                      // Header Content (Back button and Currency)
                      Align(
                        alignment:
                            Alignment
                                .center, // Vertically center within the awning space
                        child: Padding(
                          padding: EdgeInsets.only(
                            top:
                                screenHeight *
                                0.04, // Push content down a bit from very top
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back Button
                              Container(
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
                              // Currency Display
                              Container(
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
                // 2.2 "Boutique Botánica" Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Boutique Botánica',
                    style: GoogleFonts.agbalumo(
                      // 'Chewy' or 'Fredoka One' are also good playful options
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

                // 2.3 Shelves
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const NoGlowScrollBehavior(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: shelvesData.length,
                      itemBuilder: (context, shelfIndex) {
                        final List<dynamic> currentShelfItems =
                            shelvesData[shelfIndex]; // Use ShopItem if using the class

                        return _ShelfWidget(
                          items: currentShelfItems,
                          shelfColor: Colors.transparent,
                          shelfAccentDark: Colors.transparent,
                          priceChipColor: priceChipColor,
                          textBrownColor: textBrownColor,
                          greenAccent: greenAccent,
                          onItemTap: (itemData) {
                            // Replace dynamic with ShopItem or Map
                            // Handle item tap - e.g., show purchase confirmation
                            print(
                              'Tapped on: ${itemData['name']} for ${itemData['price']}',
                            );
                            // Example: ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(content: Text('Buy ${itemData.name}?')),
                            // );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Shelf Widget ---
class _ShelfWidget extends StatelessWidget {
  final List<dynamic>
  items; // Replace with List<ShopItem> or List<Map<String, dynamic>>
  final Color shelfColor;
  final Color shelfAccentDark;
  final Color priceChipColor;
  final Color textBrownColor;
  final Color greenAccent;
  final Function(dynamic) onItemTap; // Replace dynamic with ShopItem or Map

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
    // Calculate item width based on 3 items per shelf, considering padding
    final double itemContainerWidth =
        (screenWidth - 40 - (items.length - 1) * 10 - 20) / 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 10,
        left: 10,
        right: 10,
      ), // Padding inside the shelf
      decoration: BoxDecoration(
        color: shelfColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          top: BorderSide(color: shelfAccentDark.withOpacity(0.5), width: 3),
          left: BorderSide(color: shelfAccentDark.withOpacity(0.3), width: 2),
          right: BorderSide(color: shelfAccentDark.withOpacity(0.3), width: 2),
          bottom: BorderSide(color: shelfAccentDark.withOpacity(0.7), width: 5),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Distribute items on the shelf
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items.map((itemData) {
              // Replace dynamic with ShopItem or Map
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
                      // Item Image
                      Container(
                        height: 80, // Fixed height for images
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          itemData['imageAsset'], // Use itemData.imageAsset if using ShopItem class
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Price Chip
                      _PriceChip(
                        price: itemData['price'], // Use itemData.price
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
        color: chipColor,
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
          Icon(Icons.eco_rounded, color: leafColor, size: 16), // Leaf icon
          const SizedBox(width: 4),
          Text(
            price.toString(),
            style: GoogleFonts.getFont(
              'Nunito', // A clean font for prices
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
