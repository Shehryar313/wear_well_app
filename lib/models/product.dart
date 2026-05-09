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
    imageUrl: 'https://images.pexels.com/photos/8692254/pexels-photo-8692254.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/24012944/pexels-photo-24012944.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/8692253/pexels-photo-8692253.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/297933/pexels-photo-297933.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/1124468/pexels-photo-1124468.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/7148621/pexels-photo-7148621.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/8154295/pexels-photo-8154295.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/25184999/pexels-photo-25184999.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
    isFeatured: true,
  ),
  Product(
    id: '9',
    name: 'Sneaker',
    price: 7500,
    category: 'Women',
    description:
        'Pure pashmina shawl with traditional Kashmiri embroidery. Lightweight yet warm — a must-have luxury accessory for Pakistani winters and formal events.',
    sizes: ['Free Size'],
    colors: ['Beige', 'Black', 'Maroon'],
    imageUrl: 'https://images.pexels.com/photos/4996966/pexels-photo-4996966.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/34976597/pexels-photo-34976597.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/6347888/pexels-photo-6347888.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/6347887/pexels-photo-6347887.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/36703928/pexels-photo-36703928.jpeg?auto=compress&cs=tinysrgb&w=400',
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
    imageUrl: 'https://images.pexels.com/photos/1032110/pexels-photo-1032110.jpeg?auto=compress&cs=tinysrgb&w=400',
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

  // ── Men (extra) ──
  Product(
    id: '17',
    name: 'Denim Jeans',
    price: 3500,
    category: 'Men',
    description:
        'Slim-fit denim jeans in premium stretch fabric. Classic 5-pocket design with dark-wash finish. Versatile enough for casual and smart-casual outfits.',
    sizes: ['28', '30', '32', '34', '36'],
    colors: ['Dark Blue', 'Black', 'Light Blue'],
    imageUrl: 'https://images.pexels.com/photos/23947014/pexels-photo-23947014.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.4,
  ),
  Product(
    id: '18',
    name: 'Embroidered Sherwani',
    price: 18500,
    category: 'Men',
    description:
        'Luxurious sherwani with hand-embroidered detailing on the front and cuffs. Perfect for weddings and Eid festivities. Comes with matching churidar.',
    sizes: ['M', 'L', 'XL'],
    colors: ['Ivory', 'Black', 'Royal Blue'],
    imageUrl: 'https://images.pexels.com/photos/24549155/pexels-photo-24549155.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
    isFeatured: true,
  ),
  Product(
    id: '19',
    name: 'Casual Linen Shirt',
    price: 2800,
    category: 'Men',
    description:
        'Breathable linen shirt with a relaxed cut — ideal for hot Pakistani summers. Button-down collar with a chest pocket. Easy-iron fabric.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['White', 'Beige', 'Olive'],
    imageUrl: 'https://images.pexels.com/photos/17251247/pexels-photo-17251247.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.3,
  ),
  Product(
    id: '20',
    name: 'Fleece Tracksuit',
    price: 5500,
    category: 'Men',
    description:
        'Comfortable fleece tracksuit set with elastic waistband and side pockets. Great for morning workouts, indoor wear, and cold winter evenings.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Charcoal', 'Navy', 'Burgundy'],
    imageUrl: 'https://images.pexels.com/photos/18078019/pexels-photo-18078019.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.2,
  ),

  // ── Women (extra) ──
  Product(
    id: '21',
    name: 'Silk Formal Gown',
    price: 14500,
    category: 'Women',
    description:
        'Elegant full-length silk gown with flared sleeves and intricate zari work. Perfect for formal dinners, mehndi nights, and walima events.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Emerald Green', 'Burgundy', 'Midnight Blue'],
    imageUrl: 'https://images.pexels.com/photos/33960085/pexels-photo-33960085.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.8,
    isFeatured: true,
  ),
  Product(
    id: '22',
    name: 'Printed Kurti',
    price: 2200,
    category: 'Women',
    description:
        'Casual printed kurti in soft lawn fabric. Straight cut with side slits and round neck. Great for everyday wear paired with jeans or tights.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Yellow Print', 'Blue Floral', 'Orange Block'],
    imageUrl: 'https://images.pexels.com/photos/28512787/pexels-photo-28512787.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.3,
  ),
  Product(
    id: '23',
    name: 'Winter Woollen Shawl',
    price: 4800,
    category: 'Women',
    description:
        'Thick woollen shawl with geometric woven patterns. Warm and stylish for winters in Peshawar and Murree. Can double as a wrap.',
    sizes: ['Free Size'],
    colors: ['Grey', 'Dark Red', 'Camel Brown'],
    imageUrl: 'https://images.pexels.com/photos/35170027/pexels-photo-35170027.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
  ),
  Product(
    id: '24',
    name: 'Bridal Lehenga Set',
    price: 32000,
    category: 'Women',
    description:
        'Stunning bridal lehenga with heavy embroidery and sequin work. Includes choli and dupatta. Crafted from premium velvet and silk blend for a regal look.',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Red/Gold', 'Pink/Silver'],
    imageUrl: 'https://images.pexels.com/photos/12796883/pexels-photo-12796883.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
    isFeatured: true,
  ),

  // ── Kids (extra) ──
  Product(
    id: '25',
    name: 'Kids Denim Dungaree',
    price: 2200,
    category: 'Kids',
    description:
        'Cute denim dungaree for toddlers with adjustable straps and bib pocket. Soft inner lining for sensitive skin. Easy snap-button for quick changes.',
    sizes: ['1-2Y', '2-3Y', '3-4Y', '4-5Y'],
    colors: ['Light Blue', 'Dark Denim'],
    imageUrl: 'https://images.pexels.com/photos/8421946/pexels-photo-8421946.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
  ),
  Product(
    id: '26',
    name: 'Girls Frock Set',
    price: 1800,
    category: 'Kids',
    description:
        'Colorful printed frock set for girls with matching headband. Soft cotton blend with elastic waist. Ideal for birthday parties and casual outings.',
    sizes: ['2-3Y', '4-5Y', '6-7Y', '8-9Y'],
    colors: ['Pink Stars', 'Purple Flowers', 'Yellow Dots'],
    imageUrl: 'https://images.pexels.com/photos/36046025/pexels-photo-36046025.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
    isFeatured: true,
  ),
  Product(
    id: '27',
    name: 'Kids Track Pants',
    price: 900,
    category: 'Kids',
    description:
        'Elastic-waist jersey track pants for active kids. Durable fabric with reinforced knees. Perfect for school, sports, or play.',
    sizes: ['3-4Y', '5-6Y', '7-8Y', '9-10Y'],
    colors: ['Black', 'Navy', 'Grey'],
    imageUrl: 'https://images.pexels.com/photos/9661972/pexels-photo-9661972.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.1,
  ),
  Product(
    id: '28',
    name: 'Boys Waistcoat Kurta Set',
    price: 3200,
    category: 'Kids',
    description:
        'Festive kurta with embroidered waistcoat for boys. Perfect for Eid and family gatherings. Pre-stitched and easy to wear with soft breathable fabric.',
    sizes: ['4-5Y', '6-7Y', '8-9Y', '10-11Y'],
    colors: ['Cream/Gold', 'Sky Blue/Silver', 'Green/Gold'],
    imageUrl: 'https://images.pexels.com/photos/17015449/pexels-photo-17015449.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    isFeatured: true,
  ),

  // ── Accessories (extra) ──
  Product(
    id: '29',
    name: 'Leather Handbag',
    price: 8500,
    category: 'Accessories',
    description:
        'Structured leather handbag with gold-tone hardware and top zip closure. Spacious interior with card slots and a detachable shoulder strap.',
    sizes: [],
    colors: ['Tan', 'Black', 'Burgundy'],
    imageUrl: 'https://images.pexels.com/photos/35666033/pexels-photo-35666033.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    isFeatured: true,
  ),
  Product(
    id: '30',
    name: 'Casual Canvas Belt',
    price: 950,
    category: 'Accessories',
    description:
        'Durable canvas belt with metal pin buckle. Fits waist sizes 28–40 inches. Great for casual and smart-casual everyday outfits.',
    sizes: [],
    colors: ['Olive', 'Navy', 'Khaki'],
    imageUrl: 'https://images.pexels.com/photos/35222039/pexels-photo-35222039.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.1,
  ),
  Product(
    id: '31',
    name: 'Silver Jhumka Earrings',
    price: 1800,
    category: 'Accessories',
    description:
        'Traditional silver-plated jhumka earrings with intricate filigree work. Lightweight and comfortable for all-day wear. Perfect gift for Pakistani women.',
    sizes: [],
    colors: ['Silver', 'Gold-plated'],
    imageUrl: 'https://images.pexels.com/photos/35137273/pexels-photo-35137273.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
  ),
  Product(
    id: '32',
    name: 'Wool Kufi Cap',
    price: 750,
    category: 'Accessories',
    description:
        'Traditional Pakistani kufi cap knitted from fine wool. Keeps you warm during winter prayers and casual outings. Fits most adult head sizes.',
    sizes: [],
    colors: ['White', 'Black', 'Camel'],
    imageUrl: 'https://images.pexels.com/photos/7557854/pexels-photo-7557854.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.2,
  ),
];