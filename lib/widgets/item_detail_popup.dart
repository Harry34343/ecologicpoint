// En ItemDetailPopup.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/shopitem.dart'; // Tu modelo ShopItem
import 'dart:ui' as ui; // Para ImageFilter
import 'package:a/widgets/statusPopup.dart'; // El popup de estado que creamos

// Re-usa o adapta tu _PriceChip widget si lo necesitas para el popup
class _PopupPriceChip extends StatelessWidget {
  final int price;
  final Color chipColor;
  final Color textColor;
  final Color leafColor;

  const _PopupPriceChip({
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
  final int userCurrency; // Necesario para la lógica de compra

  // Define colores similares a tu imagen original
  final Color popupBackgroundColor = const Color.fromRGBO(247, 246, 235, 1);
  final Color buttonColor = const Color.fromRGBO(53, 94, 59, 1);
  final Color textBrownColor = const Color.fromRGBO(31, 31, 31, 1);
  final Color priceChipColorPopup = const Color.fromRGBO(229, 233, 228, 1);
  final Color greenAccentPopup = const Color.fromRGBO(53, 94, 59, 1);

  const ItemDetailPopup({
    super.key,
    required this.item,
    required this.userCurrency, // Asegúrate de pasarlo desde BoutiqueScreen
  });

  Widget _buildItemPreview(ShopItem item) {
    // ... (tu lógica de _buildItemPreview con el cactus y el ítem superpuesto) ...
    // Pega aquí tu versión funcional de _buildItemPreview
    String baseCharacterAsset = 'assets/plantas/cactus.svg';
    double itemVisualHeight = 80;
    Offset itemOffset = Offset.zero;
    if (item.id == 'body1') {
      // Red Scarf
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
          SvgPicture.asset(
            baseCharacterAsset,
            height: 200,
            fit: BoxFit.contain,
          ),
          Transform.translate(
            offset: itemOffset,
            child: SvgPicture.asset(
              item.imageAsset,
              height: itemVisualHeight,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // Helper para mostrar los popups de estado (confirmación, éxito, error)
  // Este es el mismo helper que definimos antes.
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

  Future<void> _processPurchase(BuildContext mainScreenContext) async {
    // Este método se llama DESPUÉS de que el usuario confirma en el StatusPopup de confirmación.
    // mainScreenContext es el contexto de la BoutiqueScreen, necesario para mostrar
    // los popups de éxito/error después de que ItemDetailPopup se cierre.

    bool purchaseSuccessful = userCurrency >= item.price;

    // Asumimos que ItemDetailPopup ya fue cerrado por la acción del StatusPopup de confirmación.

    if (purchaseSuccessful) {
      // TODO: Lógica real para actualizar la moneda y el inventario del usuario
      // Esto debería hacerse a través de un State Management.
      print(
        "Compra exitosa para ${item.name}! Moneda antes: $userCurrency, Precio: ${item.price}",
      );

      _showStatusDialog(
        mainScreenContext, // Usa el contexto de la pantalla principal
        StatusPopup(
          type: StatusPopupType.success,
          title: "¡Compra realizada!",
          message: "Tu artículo se ha añadido con éxito. ¡Disfrútalo!",
          actions: [
            StatusPopupButton(
              text: "Aceptar",
              isPrimary: true,
              onPressed: () => Navigator.of(mainScreenContext).pop(),
            ),
          ],
        ),
      );
    } else {
      _showStatusDialog(
        mainScreenContext, // Usa el contexto de la pantalla principal
        StatusPopup(
          type: StatusPopupType.error,
          title: "¡Ups! EcoPoints Insuficientes",
          message:
              "Necesitas más puntos para hacer esta compra. ¡Completa retos y vuelve pronto!",
          actions: [
            StatusPopupButton(
              text: "Aceptar",
              isPrimary: true,
              onPressed: () => Navigator.of(mainScreenContext).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Guardamos el contexto de BoutiqueScreen para usarlo después de cerrar este popup
    final BuildContext boutiqueScreenContext = context;

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
              // Top row: Item Name & Price en la izquierda, Botón X en la derecha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start, // Alinea X con la parte superior del nombre
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
                        _PopupPriceChip(
                          // El precio del ítem como antes
                          price: item.price,
                          chipColor: priceChipColorPopup,
                          textColor: textBrownColor,
                          leafColor: greenAccentPopup,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    // El botón X para cerrar este ItemDetailPopup
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(), // Para quitar padding extra del IconButton
                    icon: Icon(
                      Icons.close,
                      color: textBrownColor.withOpacity(0.7),
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop(); // Cierra ESTE ItemDetailPopup
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildItemPreview(item), // Previsualización del cactus
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity, // Botón ocupa todo el ancho disponible
                child: ElevatedButton(
                  // Botón "Comprar"
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    // 1. Muestra el popup de CONFIRMACIÓN
                    bool? confirmed = await _showStatusDialog<bool>(
                      context, // Usa el contexto actual del ItemDetailPopup para mostrar el de confirmación
                      StatusPopup(
                        type: StatusPopupType.confirmation,
                        title: "¿Confirmar Compra?",
                        message:
                            "", // El mensaje se genera dentro de StatusPopup
                        itemPrice: item.price,
                        actions: [
                          StatusPopupButton(
                            text: "Cancelar",
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          StatusPopupButton(
                            text: "Comprar",
                            isPrimary: true,
                            onPressed: () {
                              // Cierra el popup de confirmación y retorna true
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      // El usuario confirmó.
                      // Ahora, cierra ESTE ItemDetailPopup
                      // y luego llama a _processPurchase con el contexto de BoutiqueScreen.
                      // Esto asegura que los popups de éxito/error se muestren sobre la pantalla principal.
                      Navigator.of(
                        boutiqueScreenContext,
                      ).pop(); // Cierra ItemDetailPopup
                      _processPurchase(
                        boutiqueScreenContext,
                      ); // Procesa la compra y muestra éxito/error
                    }
                    // Si es false o null, no hacemos nada, el popup de confirmación se cerró.
                  },
                  child: Text(
                    'Comprar',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(247, 246, 235, 1),
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
