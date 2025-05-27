import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum StatusPopupType { confirmation, success, error }

class StatusPopupButton {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary; // To style primary vs secondary buttons

  StatusPopupButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
  });
}

class StatusPopup extends StatelessWidget {
  final StatusPopupType type;
  final String title;
  final String message;
  final List<StatusPopupButton> actions;
  final int? itemPrice; // Only for confirmation type

  // Define colors (puedes ajustarlos)
  final Color popupBackgroundColor = const Color.fromRGBO(247, 246, 235, 1);
  final Color primaryButtonColor = const Color.fromRGBO(
    53,
    94,
    59,
    1,
  ); // Dark green
  final Color secondaryButtonBorderColor = Color.fromRGBO(53, 94, 59, 1);
  final Color primaryButtonTextColor = Color.fromRGBO(247, 246, 235, 1);
  final Color secondaryButtonTextColor = Color.fromRGBO(
    53,
    94,
    59,
    1,
  ); // Dark brown
  final Color titleTextColor = Color.fromRGBO(31, 31, 31, 1);
  final Color messageTextColor = const Color.fromRGBO(95, 105, 100, 1);

  StatusPopup({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.actions,
    this.itemPrice, // For "¿Confirmar Compra? ..."
  });

  Widget _buildIcon() {
    switch (type) {
      case StatusPopupType.confirmation:
        return const Icon(
          Icons.warning_amber_rounded,
          color: Color(0xFFE6A800),
          size: 48,
        );
      case StatusPopupType.success:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50), // Green background for check
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Color.fromRGBO(247, 246, 235, 1),
            size: 32,
          ),
        );
      case StatusPopupType.error:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F), // Red background for cross
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Color.fromRGBO(247, 246, 235, 1),
            size: 32,
          ),
        );
    }
  }

  String _getFormattedMessage() {
    if (type == StatusPopupType.confirmation && itemPrice != null) {
      return "Estás seguro de que quieres gastar ${itemPrice} EcoPoints en este artículo?";
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: popupBackgroundColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: titleTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _getFormattedMessage(),
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: messageTextColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 25),
              if (actions.length == 1)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          actions.first.isPrimary
                              ? primaryButtonColor
                              : popupBackgroundColor,
                      foregroundColor:
                          actions.first.isPrimary
                              ? primaryButtonTextColor
                              : secondaryButtonTextColor,
                      elevation: actions.first.isPrimary ? 2 : 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side:
                            actions.first.isPrimary
                                ? BorderSide.none
                                : BorderSide(
                                  color: secondaryButtonBorderColor,
                                  width: 1.5,
                                ),
                      ),
                    ),
                    onPressed: actions.first.onPressed,
                    child: Text(
                      actions.first.text,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else if (actions.length == 2)
                Row(
                  children:
                      actions.map((action) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    action.isPrimary
                                        ? primaryButtonColor
                                        : popupBackgroundColor,
                                foregroundColor:
                                    action.isPrimary
                                        ? primaryButtonTextColor
                                        : secondaryButtonTextColor,
                                elevation: action.isPrimary ? 2 : 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side:
                                      action.isPrimary
                                          ? BorderSide.none
                                          : BorderSide(
                                            color: secondaryButtonBorderColor,
                                            width: 1.5,
                                          ),
                                ),
                              ),
                              onPressed: action.onPressed,
                              child: Text(
                                action.text,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
