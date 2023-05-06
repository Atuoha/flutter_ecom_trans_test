class CartItem {
  final String productId;
  final String id;
  final String name;
  final double price;
  final double previousPrice;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.id,
    required this.name,
    required this.price,
    required this.previousPrice,
    required this.quantity,
    required this.imageUrl,
  });
}