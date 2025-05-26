// models/shop_item.dart (create this file)
class ShopItem {
  final String id; // Unique ID for the item
  final String name; // e.g., "Lotus Flower", "Plague Doctor Mask"
  final String imageAsset; // e.g., 'assets/items/lotus.svg'
  final int price;
  final String category; // Could be "Plants", "Face", "Body", "Head"

  ShopItem({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.price,
    required this.category,
  });
}
