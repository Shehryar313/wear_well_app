/// Product model representing a clothing/accessory item.
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final String imageUrl;
  final double rating;
  final bool isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.imageUrl,
    this.rating = 4.0,
    this.isFeatured = false,
  });

  /// Converts this product to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'sizes': sizes,
      'colors': colors,
      'imageUrl': imageUrl,
      'rating': rating,
      'isFeatured': isFeatured,
    };
  }

  /// Creates a Product from a Firestore document map.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 4.0).toDouble(),
      isFeatured: map['isFeatured'] ?? false,
    );
  }
}

/// Sample product catalog — Pakistani fashion with prices in PKR.
List<Product> sampleProducts = [
  // ── Men ──
  Product(
    id: '1',
    name: 'Premium Shalwar Kameez',
    price: 4500,
    category: 'Men',
    description:
        'Classic Pakistani shalwar kameez in premium wash-and-wear fabric. Comfortable straight-cut design with embroidered collar and cuff details. Perfect for daily and semi-formal wear.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Sky Blue', 'Off White'],
    imageUrl: 'https://images.pexels.com/photos/8692253/pexels-photo-8692253.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
    isFeatured: true,
  ),
  Product(
    id: '2',
    name: 'Designer Waistcoat Kurta',
    price: 8500,
    category: 'Men',
    description:
        'Elegant designer waistcoat paired with matching kurta for weddings, Eid, and formal events. Rich fabric with detailed embroidery work and modern slim fit.',
    sizes: ['M', 'L', 'XL'],
    colors: ['Black/Gold', 'Navy/Silver'],
    imageUrl: 'https://images.pexels.com/photos/31340436/pexels-photo-31340436/free-photo-of-traditional-pakistani-male-fashion-portrait.png?auto=compress&cs=tinysrgb&w=400',
    rating: 4.8,
    isFeatured: true,
  ),
  Product(
    id: '3',
    name: 'Cotton Kurta Pajama',
    price: 3200,
    category: 'Men',
    description:
        'Soft cotton kurta pajama set with minimalist embroidery on front placket. Breathable fabric ideal for Pakistani summers. Available in soothing pastel tones.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Cream', 'Light Green', 'Powder Blue'],
    imageUrl: 'https://images.pexels.com/photos/16170055/pexels-photo-16170055.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.4,
  ),
  Product(
    id: '4',
    name: 'Polo T-Shirt',
    price: 2200,
    category: 'Men',
    description:
        'Comfortable cotton polo t-shirt with classic collar. Pre-shrunk fabric with reinforced stitching. Perfect for casual outings and weekends.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Black', 'Navy', 'Maroon'],
    imageUrl: 'https://images.pexels.com/photos/6311392/pexels-photo-6311392.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.2,
  ),
  Product(
    id: '5',
    name: 'Leather Jacket',
    price: 12500,
    category: 'Men',
    description:
        'Premium quality genuine leather jacket with sleek design. Asymmetric zip closure, quilted shoulders, and zippered pockets. Ideal for Islamabad and Murree winters.',
    sizes: ['M', 'L', 'XL'],
    colors: ['Black', 'Dark Brown'],
    imageUrl: 'https://images.pexels.com/photos/16170060/pexels-photo-16170060.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    isFeatured: true,
  ),

  // ── Women ──
  Product(
    id: '6',
    name: 'Embroidered Lawn Suit',
    price: 5800,
    category: 'Women',
    description:
        'Beautiful 3-piece lawn suit with intricate embroidery on shirt front, sleeves, and dupatta borders. Ideal for Pakistani summers with breathable fabric and vibrant prints.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Pink Floral', 'Blue Print', 'Green Motif'],
    imageUrl: 'https://images.pexels.com/photos/29413592/pexels-photo-29413592/free-photo-of-elegant-pakistani-dress-fashion-portrait.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    isFeatured: true,
  ),
  Product(
    id: '7',
    name: 'Chiffon Dupatta Collection',
    price: 3500,
    category: 'Women',
    description:
        'Luxurious chiffon dupatta with delicate embroidered borders and spray work. Can be paired with any outfit for an elegant Pakistani look.',
    sizes: ['Free Size'],
    colors: ['Ivory', 'Blush Pink', 'Deep Red'],
    imageUrl: 'https://images.pexels.com/photos/34251604/pexels-photo-34251604/free-photo-of-traditional-punjabi-woman-in-orange-dupatta.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
  ),
  Product(
    id: '8',
    name: 'Stitched Khaddar Suit',
    price: 4200,
    category: 'Women',
    description:
        'Warm khaddar 2-piece suit with printed design. Pre-stitched for convenience with modern cuts. Best for winter season in Lahore and northern areas.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Maroon', 'Teal', 'Mustard'],
    imageUrl: 'https://images.pexels.com/photos/8872436/pexels-photo-8872436.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
    isFeatured: true,
  ),
  Product(
    id: '9',
    name: 'Pashmina Shawl',
    price: 7500,
    category: 'Women',
    description:
        'Pure pashmina shawl with traditional Kashmiri embroidery. Lightweight yet warm — a must-have luxury accessory for Pakistani winters and formal events.',
    sizes: ['Free Size'],
    colors: ['Beige', 'Black', 'Maroon'],
    imageUrl: 'https://images.pexels.com/photos/6567607/pexels-photo-6567607.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
  ),

  // ── Kids ──
  Product(
    id: '10',
    name: 'Kids Eid Kurta Set',
    price: 2800,
    category: 'Kids',
    description:
        'Adorable kids kurta pajama set designed for Eid celebrations. Soft cotton fabric with festive embroidery. Comfortable and easy to wear for little ones.',
    sizes: ['2-3Y', '4-5Y', '6-7Y', '8-9Y'],
    colors: ['White/Gold', 'Sky Blue', 'Peach'],
    imageUrl: 'https://images.pexels.com/photos/3771679/pexels-photo-3771679.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.4,
    isFeatured: true,
  ),
  Product(
    id: '11',
    name: 'Kids Printed T-Shirt',
    price: 1200,
    category: 'Kids',
    description:
        'Fun and colorful graphic t-shirt for kids in 100% organic cotton. Cricket and truck themed prints that boys love. Machine washable and durable.',
    sizes: ['2-3Y', '4-5Y', '6-7Y'],
    colors: ['White', 'Yellow', 'Green'],
    imageUrl: 'https://images.pexels.com/photos/5559986/pexels-photo-5559986.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.1,
  ),
  Product(
    id: '12',
    name: 'Kids Winter Hoodie',
    price: 2500,
    category: 'Kids',
    description:
        'Warm fleece hoodie with kangaroo pocket for kids. Perfect for chilly Lahore and Islamabad winters. Adjustable hood with soft inner lining.',
    sizes: ['3-4Y', '5-6Y', '7-8Y', '9-10Y'],
    colors: ['Pink', 'Navy', 'Red'],
    imageUrl: 'https://images.pexels.com/photos/5559989/pexels-photo-5559989.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
  ),

  // ── Accessories ──
  Product(
    id: '13',
    name: 'Ajrak Print Scarf',
    price: 1500,
    category: 'Accessories',
    description:
        'Traditional Sindhi Ajrak print scarf in premium cotton. Block-printed with natural dyes. A statement piece celebrating Pakistani heritage and culture.',
    sizes: [],
    colors: ['Red/Blue', 'Indigo/White', 'Maroon/Gold'],
    imageUrl: 'https://images.pexels.com/photos/36703926/pexels-photo-36703926/free-photo-of-traditional-fashion-portrait-outdoors.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.4,
  ),
  Product(
    id: '14',
    name: 'Classic Leather Watch',
    price: 6500,
    category: 'Accessories',
    description:
        'Elegant analog watch with genuine leather strap. Minimalist dial with date display. Water resistant. Japanese quartz movement — perfect gift item.',
    sizes: [],
    colors: ['Brown Strap', 'Black Strap'],
    imageUrl: 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    isFeatured: true,
  ),
  Product(
    id: '15',
    name: 'Peshawari Chappal',
    price: 3800,
    category: 'Accessories',
    description:
        'Handcrafted genuine leather Peshawari chappal from the craftsmen of Peshawar. Traditional Pakistani footwear with a modern touch. Comfortable and durable.',
    sizes: ['7', '8', '9', '10', '11'],
    colors: ['Brown', 'Tan', 'Black'],
    imageUrl: 'https://images.pexels.com/photos/35633190/pexels-photo-35633190/free-photo-of-colorful-display-of-decorative-sandals-on-shelf.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
  ),
  Product(
    id: '16',
    name: 'Aviator Sunglasses',
    price: 2200,
    category: 'Accessories',
    description:
        'Classic aviator sunglasses with UV400 protection. Lightweight metal frame with adjustable nose pads. Stylish look for sunny Pakistani days.',
    sizes: [],
    colors: ['Gold/Green', 'Silver/Blue'],
    imageUrl: 'https://images.pexels.com/photos/701877/pexels-photo-701877.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.3,
  ),
];