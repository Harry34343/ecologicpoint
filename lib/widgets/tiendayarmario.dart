// Create a new file, e.g., side_buttons.dart, or add it to your Plant1 file if small enough

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SideButtons extends StatelessWidget {
  final Function()? onArmarioTap; // Callback for Armario tap
  final Function()? onTiendaTap; // Callback for Tienda tap
  // Access screenWidth and screenHeight inside the build method using MediaQuery.of(context)

  const SideButtons({super.key, this.onArmarioTap, this.onTiendaTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double relWidth(double w) => screenWidth * (w / 440);
    double relHeight(double h) => screenHeight * (h / 900);

    return Column(
      mainAxisSize: MainAxisSize.min, // Column takes minimum space
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end, // Align to the end (right)
      children: [
        // Armario Button
        GestureDetector(
          onTap: onArmarioTap,
          child: Container(
            // width: double.infinity, // This would make it take full width, we want it on the side
            width: relWidth(
              100,
            ), // EXAMPLE: Set a specific width or use responsive width
            margin: const EdgeInsets.only(bottom: 0), // Space between buttons
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color:
                  Colors.transparent, // Added a background color for visibility
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: relWidth(65),
                  height: relHeight(64.50),
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(), // This container is empty, just for clipping?
                  child: Stack(
                    alignment: Alignment.center, // Center the icon elements
                    children: [
                      // Example: Add your Armario icon SVG as a background or base
                      SvgPicture.asset(
                        'assets/armarioicon.svg',
                        width: relWidth(65),
                        height: relHeight(65),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: relHeight(2)), // Space between icon and text
                Container(
                  // height: relHeight(18), // Let text determine height
                  padding: EdgeInsets.symmetric(
                    horizontal: relWidth(6),
                    vertical: relHeight(4),
                  ), // Added vertical padding
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F6EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    // Removed unnecessary Row
                    'Armario',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1F1F1F),
                      fontSize: relWidth(14),

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tienda Button
        GestureDetector(
          onTap: onTiendaTap,
          child: Container(
            // width: double.infinity,
            width: relWidth(100), // EXAMPLE: Set a specific width
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.transparent, // Added background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: relWidth(65),
                  height: relHeight(65), // Matched width for consistency
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(), // This is empty, are you drawing in it?
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // TODO: Add your Tienda icon here
                      SvgPicture.asset(
                        'assets/tiendaicon.svg', // Example path
                        width: relWidth(65),
                        height: relHeight(65),
                      ), // Placeholder icon
                    ],
                  ),
                ),
                SizedBox(height: relHeight(2)),
                Container(
                  // height: relHeight(18),
                  padding: EdgeInsets.symmetric(
                    horizontal: relWidth(6),
                    vertical: relHeight(4),
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F6EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    // Removed unnecessary Row
                    'Tienda',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1F1F1F),
                      fontSize: relWidth(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
