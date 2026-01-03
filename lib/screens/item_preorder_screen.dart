import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'slot_booking_screen.dart';

class ItemPreorderScreen extends StatefulWidget {
  final String language;

  const ItemPreorderScreen({super.key, required this.language});

  @override
  State<ItemPreorderScreen> createState() => _ItemPreorderScreenState();
}

class _ItemPreorderScreenState extends State<ItemPreorderScreen> {
  List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'name': 'Rice',
      'tamilName': 'அரிசி',
      'icon': Icons.grain,
      'unit': 'kg',
      'maxQty': 20,
      'price': 3,
      'quantity': 0,
    },
    {
      'id': 2,
      'name': 'Sugar',
      'tamilName': 'சர்க்கரை',
      'icon': Icons.local_drink,
      'unit': 'kg',
      'maxQty': 2,
      'price': 40,
      'quantity': 0,
    },
    {
      'id': 3,
      'name': 'Cooking Oil',
      'tamilName': 'சமையல் எண்ணெய்',
      'icon': Icons.opacity_outlined,
      'unit': 'L',
      'maxQty': 2,
      'price': 120,
      'quantity': 0,
    },
    {
      'id': 4,
      'name': 'Wheat',
      'tamilName': 'கோதுமை',
      'icon': Icons.grain,
      'unit': 'kg',
      'maxQty': 5,
      'price': 2,
      'quantity': 0,
    },
  ];

  void _increaseQuantity(int id) {
    setState(() {
      final index = items.indexWhere((item) => item['id'] == id);
      if (items[index]['quantity'] < items[index]['maxQty']) {
        items[index]['quantity']++;
      }
    });
  }

  void _decreaseQuantity(int id) {
    setState(() {
      final index = items.indexWhere((item) => item['id'] == id);
      if (items[index]['quantity'] > 0) {
        items[index]['quantity']--;
      }
    });
  }

  int get totalWeight => items.fold(0, (sum, item) => sum + (item['quantity'] as int));
  
  int get totalPrice => items.fold(
    0,
    (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as int)),
  );
  
  bool get hasItems => items.any((item) => item['quantity'] > 0);

  @override
  Widget build(BuildContext context) {
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
                            'Pre-Order Items',
                            style: AppTextStyles.heading2En.copyWith(color: Colors.white),
                          ),
                          Text(
                            'பொருட்களை முன்பதிவு செய்க',
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.warningBackground,
                          border: Border.all(color: AppColors.warningBorder),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📋 Select items within your monthly quota',
                              style: AppTextStyles.bodyEn.copyWith(
                                color: AppColors.warningText,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'உங்கள் மாதாந்திர ஒதுக்கீட்டிற்குள் பொருட்களைத் தேர்ந்தெடுக்கவும்',
                              style: AppTextStyles.captionTa.copyWith(
                                color: AppColors.warningText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Title
                      Text(
                        'Available Commodities',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'கிடைக்கக்கூடிய பொருட்கள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      // Items List
                      ...items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildItemCard(item),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomSummary(context),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final quantity = item['quantity'] as int;
    final maxQty = item['maxQty'] as int;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: quantity > 0 ? AppColors.primaryGreen : AppColors.borderColor,
          width: quantity > 0 ? 2 : 1,
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item['icon'],
                size: 32,
                color: AppColors.primaryGreen,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: AppTextStyles.heading3En,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['tamilName'],
                      style: AppTextStyles.heading3Ta,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Max: $maxQty ${item['unit']} • ₹${item['price']}/${item['unit']}',
                      style: AppTextStyles.captionEn,
                    ),
                  ],
                ),
              ),
              if (quantity > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.15),
                    border: Border.all(color: AppColors.primaryGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹${quantity * item['price']}',
                    style: AppTextStyles.bodyBoldEn.copyWith(
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Stepper
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Decrease Button
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: quantity == 0 ? AppColors.borderColor : AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: quantity == 0 ? null : () => _decreaseQuantity(item['id']),
                      icon: const Icon(Icons.remove, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Quantity Display
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      border: Border.all(color: AppColors.borderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$quantity',
                          style: AppTextStyles.heading1En.copyWith(fontSize: 28),
                        ),
                        Text(
                          item['unit'],
                          style: AppTextStyles.captionEn,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Increase Button
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: quantity >= maxQty ? AppColors.borderColor : AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: quantity >= maxQty ? null : () => _increaseQuantity(item['id']),
                      icon: const Icon(Icons.add, color: Colors.white, size: 28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummary(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 2),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Total',
                    style: AppTextStyles.captionEn,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'மதிப்பிடப்பட்ட மொத்தம்',
                    style: AppTextStyles.captionTa.copyWith(fontSize: 13),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹$totalPrice',
                    style: AppTextStyles.heading2En.copyWith(
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  Text(
                    '$totalWeight items',
                    style: AppTextStyles.captionEn,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hasItems
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SlotBookingScreen(language: widget.language),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasItems ? AppColors.primaryGreen : AppColors.borderColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(double.infinity, 64),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Confirm Items',
                    style: AppTextStyles.buttonEn,
                  ),
                  Text(
                    'பொருட்களை உறுதிப்படுத்தவும்',
                    style: AppTextStyles.buttonTa,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
