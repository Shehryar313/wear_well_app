class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final String imageUrl; // Placeholder for image

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.sizes,
    required this.colors,
    this.imageUrl = 'https://via.placeholder.com/150', // Dummy image
  });
}

// Sample products (hardcoded for demo, as per proposal categories)
List<Product> sampleProducts = [
  Product(id: '1', name: 'Men Shirt', price: 25, category: 'Men', description: 'Comfortable cotton shirt', sizes: ['S', 'M', 'L', 'XL'], colors: ['Red', 'Blue']),
  Product(id: '2', name: 'Jacket', price: 40, category: 'Men', description: 'Warm winter jacket', sizes: ['M', 'L'], colors: ['Black', 'Grey']),
  Product(id: '3', name: 'Jeans', price: 35, category: 'Women', description: 'Slim fit jeans', sizes: ['S', 'M'], colors: ['Blue', 'Black']),
  Product(id: '4', name: 'Hoodie', price: 45, category: 'Kids', description: 'Cozy hoodie', sizes: ['XS', 'S'], colors: ['Pink', 'Green']),
  Product(id: '5', name: 'Scarf', price: 15, category: 'Accessories', description: 'Wool scarf', sizes: [], colors: ['Red', 'Blue']),
];

class CartItem {
  final Product product;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
    required this.selectedColor,
  });
}