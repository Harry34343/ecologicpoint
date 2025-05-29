import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActivated;

  const FilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isActivated
                ? const Color(0xFF355E3B)
                : const Color.fromRGBO(158, 179, 169, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
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
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
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
