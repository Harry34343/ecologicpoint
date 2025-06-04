import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// You can define these constants somewhere accessible or repeat in each button
const double kDesignScreenWidth = 440.0; // Example reference width
const double kDesignScreenHeight =
    956.0; // Example reference height (less commonly used for button scaling)

class FilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActivated;
  final double? responsiveFontSize;
  final double? responsiveBorderRadius;
  final double? responsivePadding;

  const FilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActivated,
    this.responsiveFontSize,
    this.responsivePadding,
    this.responsiveBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final double currentScreenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = currentScreenWidth / kDesignScreenWidth;
    const double baseFontSize = 16.0;
    const double baseVerticalPadding = 8;
    const double baseHorizontalPadding = 16.0;
    const double baseBorderRadius = 24.0;
    final double responsiveFontSize = (baseFontSize * scaleFactor).clamp(
      12.0,
      20.0,
    ); // Min 12, Max 20
    final double responsiveVerticalPadding =
        (baseVerticalPadding * scaleFactor);
    final double responsiveHorizontalPadding =
        (baseHorizontalPadding * scaleFactor);
    final double responsiveBorderRadius = (baseBorderRadius * scaleFactor);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isActivated
                ? const Color(0xFF355E3B)
                : const Color.fromRGBO(158, 179, 169, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
        ),
        padding: EdgeInsets.symmetric(
          vertical: responsiveVerticalPadding,
          horizontal: responsiveHorizontalPadding,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: responsiveFontSize,
          color:
              isActivated
                  ? const Color.fromRGBO(247, 246, 235, 1)
                  : Color.fromRGBO(95, 105, 100, 1),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActivated;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    final double currentScreenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = currentScreenWidth / kDesignScreenWidth;
    const double baseFontSize = 16.0;
    const double baseVerticalPadding = 8;
    const double baseHorizontalPadding = 16.0;
    const double baseBorderRadius = 24.0;
    final double responsiveFontSize = (baseFontSize * scaleFactor).clamp(
      12.0,
      20.0,
    ); // Min 12, Max 20
    final double responsiveVerticalPadding =
        (baseVerticalPadding * scaleFactor);
    final double responsiveHorizontalPadding =
        (baseHorizontalPadding * scaleFactor);
    final double responsiveBorderRadius = (baseBorderRadius * scaleFactor);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color:
              isActivated
                  ? const Color(0xFF355E3B)
                  : const Color.fromRGBO(158, 179, 169, 1),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
        ),
        padding: EdgeInsets.symmetric(
          vertical: responsiveVerticalPadding,
          horizontal: responsiveHorizontalPadding,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: responsiveFontSize,
          color: const Color(0xFF355E3B),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActivated;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    final double currentScreenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = currentScreenWidth / kDesignScreenWidth;
    const double baseFontSize = 16.0;
    const double baseVerticalPadding = 8;
    const double baseHorizontalPadding = 16.0;
    const double baseBorderRadius = 24.0;
    final double responsiveFontSize = (baseFontSize * scaleFactor).clamp(
      12.0,
      20.0,
    ); // Min 12, Max 20
    final double responsiveVerticalPadding =
        (baseVerticalPadding * scaleFactor);
    final double responsiveHorizontalPadding =
        (baseHorizontalPadding * scaleFactor);
    final double responsiveBorderRadius = (baseBorderRadius * scaleFactor);
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: responsiveVerticalPadding,
          horizontal: responsiveHorizontalPadding,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: responsiveFontSize,
          color:
              isActivated
                  ? const Color(0xFF355E3B)
                  : const Color.fromRGBO(158, 179, 169, 1),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isActivated;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color:
            isActivated
                ? const Color(0xFF355E3B)
                : const Color.fromRGBO(158, 179, 169, 1),
      ),
    );
  }
}
