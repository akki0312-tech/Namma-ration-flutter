import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class MapLocatorScreen extends StatelessWidget {
  final String language;

  const MapLocatorScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final shops = [
      {
        'name': 'Shop #402, Anna Nagar',
        'address': 'Anna Nagar West Extension, Chennai - 600101',
        'distance': '0.2 km',
        'status': 'open',
        'phone': '+91 98765 43210',
        'isRegistered': true,
      },
      {
        'name': 'Shop #405, Aminjikarai',
        'address': 'Aminjikarai Main Road, Chennai - 600029',
        'distance': '1.2 km',
        'status': 'open',
        'phone': '+91 98765 43211',
        'isRegistered': false,
      },
      {
        'name': 'Shop #410, Kilpauk',
        'address': 'Kilpauk Garden Road, Chennai - 600010',
        'distance': '2.5 km',
        'status': 'open',
        'phone': '+91 98765 43212',
        'isRegistered': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              // Header
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find Nearby Shops',
                            style: AppTextStyles.heading2En.copyWith(color: Colors.white),
                          ),
                          Text(
                            'அருகிலுள்ள கடைகளைக் கண்டறியவும்',
                            style: AppTextStyles.heading3Ta.copyWith(
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Map View
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFbfdbfe), Color(0xFFdbeafe), Color(0xFFe0f2fe)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Grid pattern
                            CustomPaint(
                              size: const Size(double.infinity, 280),
                              painter: GridPatternPainter(),
                            ),
                            
                            // Your location
                            Positioned(
                              top: 125,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryOrange.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.my_location,
                                        size: 40,
                                        color: AppColors.primaryOrange,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'You are here',
                                      style: AppTextStyles.captionEn.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Shop pins
                            const Positioned(
                              top: 80,
                              left: 120,
                              child: Icon(Icons.store, size: 32, color: AppColors.primaryGreen),
                            ),
                            const Positioned(
                              top: 165,
                              right: 80,
                              child: Icon(Icons.store, size: 32, color: AppColors.primaryGreen),
                            ),
                            const Positioned(
                              top: 65,
                              right: 70,
                              child: Icon(Icons.store, size: 32, color: AppColors.primaryGreen),
                            ),
                            
                            // My Location Button
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.my_location,
                                    color: AppColors.primaryGreen,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Shops List
                      Text(
                        'Nearby Fair Price Shops',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'அருகிலுள்ள நியாய விலைக் கடைகள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      ...shops.map((shop) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildShopCard(context, shop),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopCard(BuildContext context, Map<String, dynamic> shop) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: shop['isRegistered'] ? AppColors.primaryGreen : AppColors.borderColor,
          width: shop['isRegistered'] ? 2 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store, size: 24, color: AppColors.primaryGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            shop['name'],
                            style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      shop['address'],
                      style: AppTextStyles.bodyEn.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.directions_walk, size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(
                          '${shop['distance']} away',
                          style: AppTextStyles.bodyBoldEn.copyWith(
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (shop['isRegistered'])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.15),
                    border: Border.all(color: AppColors.primaryGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Registered',
                    style: AppTextStyles.captionEn.copyWith(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Check Stock',
                        style: AppTextStyles.buttonEn.copyWith(fontSize: 16),
                      ),
                      Text(
                        'இருப்பைச் சரிபார்க்கவும்',
                        style: AppTextStyles.buttonTa.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryGreen.withOpacity(0.2)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const gridSize = 40.0;
    
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
