# 🛍️ Wear-Well — Premium Fashion E-Commerce App

Wear-Well is a state-of-the-art Flutter e-commerce application designed with a **"Dark Luxury"** aesthetic. It provides a seamless shopping experience for fashion enthusiasts, featuring a curated product catalog, advanced order tracking, and a premium user interface.

## ✨ Key Features

- **Premium UI/UX**: Modern dark-themed design with glassmorphism, smooth animations (via `flutter_staggered_animations`), and Google Fonts (`Outfit`/`Inter`).
- **Comprehensive Catalog**: Dedicated sections for **Men, Women, Kids, and Accessories**.
- **Real-time Backend**: Integrated with **Firebase** for Authentication, Firestore for product/order data, and Realtime Database.
- **Smart Shopping**:
    - **Cart & Wishlist**: Manage your favorite items easily.
    - **Form Validation**: Robust validation for secure checkout and registration.
- **Order Management**:
    - **Order Tracking**: Real-time tracking of order status.
    - **Order History**: View past purchases with detailed summaries.
- **Admin Dashboard**: Specialized interface for managing products, inventory, and orders.
- **Localization**: Tailored for the **Pakistani market** with PKR currency support and culturally relevant products.
- **Personalization**: Theme toggle support (Dark/Light modes) and user profile management.

## 🚀 Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Backend**: [Firebase](https://firebase.google.com) (Auth, Firestore, Realtime Database)
- **Animations**: `flutter_staggered_animations`
- **Typography**: [Google Fonts](https://fonts.google.com/specimen/Outfit)

## 📂 Project Structure

```text
lib/
├── models/         # Data models (Product, Order, CartItem)
├── providers/      # State management (Auth, Cart, Order, Theme, Wishlist)
├── screens/        # UI Screens (Login, Home, Admin, Checkout, etc.)
├── theme/          # App-wide styling and color palettes
├── utils/          # Helper functions and constants
└── widgets/        # Reusable UI components
```

## 🛠️ Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.8 or higher)
- [Firebase CLI](https://firebase.google.com/docs/cli) (configured for your project)
- An Android/iOS Emulator or Physical Device

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Shehryar313/wear_well_app.git
   cd wear_well_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   Run the FlutterFire CLI to generate `firebase_options.dart`:
   ```bash
   flutterfire configure
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 🎨 Design Philosophy
The app follows a **Dark Luxury** design language:
- **Colors**: Deep blacks, charcoal greys, and accented golds/whites for a premium feel.
- **Shapes**: Soft rounded corners (20dp+) and subtle borders.
- **Motion**: Every screen transition and list entry is animated to feel alive.

---
Developed with ❤️ by Shehryar.
