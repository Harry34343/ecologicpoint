// En ItemDetailPopup.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/shopitem.dart'; // Tu modelo ShopItem con isPurchased
import 'dart:ui' as ui; // Para ImageFilter
import 'package:a/widgets/statusPopup.dart'; // El popup de estado

// _PopupPriceChip (sin cambios, puedes mantenerlo como está)
class _PopupPriceChip extends StatelessWidget {
  final int price;
  final Color chipColor;
  final Color textColor;
  final Color leafColor;

  const _PopupPriceChip({
    super.key, // Añadido Key
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

class ItemDetailPopup extends StatelessWidget {
  final ShopItem item;
  final int userCurrency;
  final Function(ShopItem) onPurchaseConfirmed; // <--- NUEVO CALLBACK

  final Color popupBackgroundColor = const Color.fromRGBO(247, 246, 235, 1);
  final Color buttonColor = const Color.fromRGBO(
    53,
    94,
    59,
    1,
  ); // Verde para comprar
  final Color disabledButtonColor =
      Colors.grey.shade400; // Gris para deshabilitado
  final Color purchasedButtonColor =
      Colors.blueGrey.shade300; // Otro color para "Comprado"
  final Color textBrownColor = const Color.fromRGBO(31, 31, 31, 1);
  final Color priceChipColorPopup = const Color.fromRGBO(229, 233, 228, 1);
  final Color greenAccentPopup = const Color.fromRGBO(53, 94, 59, 1);

  ItemDetailPopup({
    super.key,
    required this.item,
    required this.userCurrency,
    required this.onPurchaseConfirmed, // <--- NUEVO
  });

  Widget _buildItemPreview(ShopItem item) {
    // String baseCharacterAsset = 'a'; // Esto parece un placeholder o error.
    // Debería ser una ruta válida a un SVG, ej: 'assets/personajes/base_character.svg'
    // Por ahora lo dejo, pero revísalo.
    String baseCharacterAsset =
        'assets/personajes/tu_personaje_base.svg'; // CAMBIA ESTO por tu asset real
    // Si no tienes un personaje base para previsualizar, puedes comentar esta parte
    // y solo mostrar el SvgPicture.asset(item.imageAsset, ...)
    double itemVisualHeight = 80;
    Offset itemOffset = Offset.zero;

    // Lógica de posicionamiento (igual que la tenías)
    if (item.id == 'body1') {
      itemVisualHeight = 100;
      itemOffset = const Offset(0, 25);
    } else if (item.category == 'Face' || item.category == 'Head') {
      itemVisualHeight = 60;
      itemOffset = const Offset(0, -35);
    } else if (item.category == 'Body' && item.id != 'body1') {
      itemVisualHeight = 70;
      itemOffset = const Offset(0, 10);
    }

    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Descomenta y ajusta si tienes un personaje base para la previsualización
          /*
          SvgPicture.asset(
            baseCharacterAsset, // ASEGÚRATE QUE ESTE ARCHIVO EXISTE
            height: 200,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => Icon(Icons.person, size: 150), // Placeholder si falla
          ),
          Transform.translate(
            offset: itemOffset,
            child: SvgPicture.asset(
              item.imageAsset,
              height: itemVisualHeight,
              fit: BoxFit.contain,
            ),
          ),
          */
          // Si no tienes personaje base, solo muestra el ítem:
          SvgPicture.asset(
            item.imageAsset,
            height:
                itemVisualHeight > 100
                    ? itemVisualHeight
                    : 120, // Ajusta tamaño mínimo
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Future<T?> _showStatusDialog<T>(BuildContext context, Widget dialogContent) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
              child: Container(color: Colors.transparent),
            ),
            dialogContent,
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween = Tween<double>(begin: 0.9, end: 1.0);
        final curveForScale = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
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

  @override
  Widget build(BuildContext context) {
    final bool alreadyPurchased = item.isPurchased;
    final bool canAfford = userCurrency >= item.price;
    final bool isFree = item.price == 0;

    String buttonText;
    Color currentButtonColor;
    VoidCallback? purchaseAction;

    if (alreadyPurchased) {
      buttonText = 'Ya lo tienes';
      currentButtonColor = purchasedButtonColor;
      purchaseAction = null; // Deshabilitado
    } else if (isFree) {
      buttonText = 'Obtener Gratis';
      currentButtonColor = buttonColor; // Verde para "Obtener Gratis"
      purchaseAction = () async {
        // Para ítems gratis, podemos llamar directamente a onPurchaseConfirmed
        // o también mostrar confirmación si se prefiere.
        // Por simplicidad, llamamos directamente:
        onPurchaseConfirmed(item);
        // BoutiqueScreen._handlePurchase se encargará de cerrar este popup
      };
    } else if (canAfford) {
      buttonText = 'Comprar (${item.price})';
      currentButtonColor = buttonColor; // Verde
      purchaseAction = () async {
        bool? confirmed = await _showStatusDialog<bool>(
          context, // Contexto del ItemDetailPopup
          StatusPopup(
            type: StatusPopupType.confirmation,
            title: "¿Confirmar Compra?",
            message:
                "Vas a comprar ${item.name} por ${item.price} Ecopoints.", // Mensaje más específico
            itemPrice: item.price, // Ya lo tienes
            actions: [
              StatusPopupButton(
                text: "Cancelar",
                onPressed:
                    () => Navigator.of(
                      context,
                    ).pop(false), // Cierra StatusPopup, retorna false
              ),
              StatusPopupButton(
                text: "Comprar",
                isPrimary: true,
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop(true); // Cierra StatusPopup, retorna true
                },
              ),
            ],
          ),
        );

        if (confirmed == true) {
          // El usuario confirmó. Llamamos al callback.
          // BoutiqueScreen._handlePurchase se encargará de la lógica de compra,
          // actualizar estado, y CERRAR ESTE ItemDetailPopup.
          onPurchaseConfirmed(item);
        }
      };
    } else {
      // No está comprado, no es gratis, y no puede pagarlo
      buttonText =
          'Comprar (${item.price})'; // Podrías mantener el texto "Comprar" o cambiarlo
      currentButtonColor =
          buttonColor; // Mantener el color verde para que parezca activo
      // o usar 'disabledButtonColor' si quieres que se vea diferente
      // pero siga siendo presionable.
      purchaseAction = () async {
        // Muestra el popup de error de Ecopoints insuficientes
        _showStatusDialog(
          context, // Usa el contexto del ItemDetailPopup
          StatusPopup(
            type: StatusPopupType.error,
            title: "¡Ups! EcoPoints Insuficientes",
            message:
                "Necesitas ${item.price - userCurrency} Ecopoints más para hacer esta compra. ¡Completa retos y vuelve pronto!",
            actions: [
              StatusPopupButton(
                text: "Aceptar",
                isPrimary: true,
                onPressed:
                    () =>
                        Navigator.of(
                          context,
                        ).pop(), // Cierra el StatusPopup de error
              ),
            ],
          ),
        );
      };
    }
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: popupBackgroundColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textBrownColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        if (item.price >
                            0) // Solo muestra el precio si no es gratis
                          _PopupPriceChip(
                            price: item.price,
                            chipColor: priceChipColorPopup,
                            textColor: textBrownColor,
                            leafColor: greenAccentPopup,
                          )
                        else if (!alreadyPurchased) // Si es gratis y no comprado
                          Text(
                            "¡Gratis!",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: greenAccentPopup,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.close,
                      color: textBrownColor.withOpacity(0.7),
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildItemPreview(item),
              const SizedBox(height: 25),

              // Mostrar los Ecopoints del usuario si el ítem no está comprado y no es gratis
              if (!alreadyPurchased && !isFree && item.price > 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Tus Ecopoints: $userCurrency',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: textBrownColor.withOpacity(0.8),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: purchaseAction != null ? 2 : 0,
                  ),
                  onPressed:
                      purchaseAction, // Aquí se usa la acción definida arriba
                  child: Text(
                    buttonText,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
