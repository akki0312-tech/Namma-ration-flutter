# Namma Ration - Flutter App

A bilingual (English/Tamil) Public Distribution System (PDS) mobile application for Tamil Nadu, converted from React to Flutter.

## Features

### 8 Complete Screens

1. **Language Welcome Screen** - Select preferred language (English/Tamil)
2. **Home Dashboard** - Inventory status, queue status, quick actions
3. **Ration Card Details** - Card information, quota entitlement, family details
4. **Map Locator** - Find nearby fair price shops with interactive map
5. **Item Pre-Order** - Select items with quantity steppers and price calculation
6. **Slot Booking** - Date and time slot selection with availability status
7. **Digital Token** - QR code token with booking confirmation
8. **Help & Support** - 24/7 helpline, FAQs, voice assistant toggle

### Key Features

- ✅ **Bilingual Support** - All screens display both English and Tamil text
- ✅ **Beautiful UI** - Matches original React design with Material Design
- ✅ **Interactive Elements** - Quantity steppers, date/time selection, toggles
- ✅ **QR Code Generation** - Digital token with scannable QR code
- ✅ **Bottom Navigation** - Easy navigation between main sections
- ✅ **Responsive Design** - Optimized for mobile devices (max width 480px)
- ✅ **Custom Fonts** - Google Fonts (Inter for English, Noto Sans Tamil for Tamil)

## Design

### Color Scheme

- **Primary Green**: #006A4E (Tamil Nadu government color)
- **Primary Orange**: #FF9933 (Accent color)
- **Status Colors**: Green (Available), Yellow (Limited), Red (Out of Stock)
- **Background**: #F8F9FA (Light gray)

### Typography

- **English**: Inter font family
- **Tamil**: Noto Sans Tamil font family

## Getting Started

### Prerequisites

- Flutter SDK (3.5.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Clone or navigate to the project directory:
```bash
cd namma_ration_flutter
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web
```

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── constants/
│   ├── colors.dart                     # Color constants
│   └── text_styles.dart                # Text style definitions
└── screens/
    ├── language_welcome_screen.dart    # Language selection
    ├── home_dashboard_screen.dart      # Main dashboard
    ├── ration_card_details_screen.dart # Card information
    ├── map_locator_screen.dart         # Shop locator
    ├── item_preorder_screen.dart       # Item selection
    ├── slot_booking_screen.dart        # Time slot booking
    ├── digital_token_screen.dart       # QR token display
    └── help_support_screen.dart        # Help & FAQs
```

## Dependencies

- `google_fonts: ^6.2.1` - For Inter and Noto Sans Tamil fonts
- `qr_flutter: ^4.1.0` - For QR code generation

## Conversion Notes

This Flutter app is a complete conversion of the original React application with:

- **100% Feature Parity** - All screens and features from React app
- **Identical Design** - Matching colors, fonts, spacing, and layout
- **Same User Flow** - Navigation and interactions preserved
- **Enhanced Performance** - Native mobile performance with Flutter

## Screenshots

The app includes:
- Language selection with Tamil Nadu emblem
- Inventory cards with status indicators
- Interactive quantity steppers
- Map view with location pins
- Date/time slot selection
- QR code generation
- Voice assistant toggle
- Bilingual content throughout

## License

© 2025 Government of Tamil Nadu

## Version

v1.0.0
