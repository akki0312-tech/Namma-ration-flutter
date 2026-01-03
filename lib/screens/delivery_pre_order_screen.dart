import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'delivery_schedule_screen.dart';

class DeliveryPreOrderScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> userCard;
  final bool isEligibleForFree;
  final Map<String, String> deliveryAddress;

  const DeliveryPreOrderScreen({
    super.key,
    required this.language,
    required this.userCard,
    required this.isEligibleForFree,
    required this.deliveryAddress,
  });

  @override
  State<DeliveryPreOrderScreen> createState() => _DeliveryPreOrderScreenState();
}

class _DeliveryPreOrderScreenState extends State<DeliveryPreOrderScreen> {
  final Map<String, int> _selectedItems = {
    'rice': 1,
    'sugar': 0,
    'cookingOil': 1,
  };

  final Map<String, int> _itemPrices = {
    'rice': 0,
    'sugar': 25,
    'cookingOil': 100,
  };

  int _calculateTotal() {
    int total = 0;
    _selectedItems.forEach((key, quantity) {
      total += quantity * _itemPrices[key]!;
    });
    return total;
  }

  int _calculateDeliveryFee() {
    if (widget.isEligibleForFree) return 0;
    return 25;
  }

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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2D5F4F), Color(0xFF3A7563)],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 32),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Items for Delivery',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'டெலிவரிக்கான பொருட்களைத் தேர்ந்தெடுக்கவும்',
                            style: AppTextStyles.captionTa.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
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
                      // Info Box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F4FD),
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(
                            left:
                                BorderSide(color: Color(0xFF6366F1), width: 4),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.local_shipping,
                              color: Color(0xFF6366F1),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Items will be delivered to your doorstep. Select quantities within your quota.',
                                    style: AppTextStyles.bodyEn
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'பொருட்கள் உங்கள் வீட்டு வாசலுக்கு டெலிவரி செய்யப்படும்.',
                                    style: AppTextStyles.bodyTa
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Available Commodities Title
                      Text(
                        'Available Commodities',
                        style: AppTextStyles.heading3En.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'கிடைக்கக்கூடிய பொருட்கள்',
                        style: AppTextStyles.heading3Ta.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 16),

                      // Commodity List
                      Column(
                        children: [
                          _buildCommodityItem(
                            id: 'rice',
                            name: 'Rice / அரிசி',
                            priceTag: 'Free',
                            info: 'Max: 20 kg • Free under NFSA',
                            maxQty: 20,
                            isFree: true,
                          ),
                          const SizedBox(height: 16),
                          _buildCommodityItem(
                            id: 'sugar',
                            name: 'Sugar / சர்க்கரை',
                            priceTag: '₹25/kg',
                            info: 'Max: 2 kg • ₹25/kg',
                            maxQty: 2,
                            isFree: false,
                          ),
                          const SizedBox(height: 16),
                          _buildCommodityItem(
                            id: 'cookingOil',
                            name: 'Cooking Oil / சமையல் எண்ணெய்',
                            priceTag: '₹100/L',
                            info: 'Max: 2 L • ₹100/L',
                            maxQty: 2,
                            isFree: false,
                            unit: 'L',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Total Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildBreakdownRow(
                              'Items Total / பொருட்கள் மொத்தம்',
                              '₹${_calculateTotal()}',
                            ),
                            const SizedBox(height: 12),
                            _buildBreakdownRow(
                              'Delivery Fee / டெலிவரி கட்டணம்',
                              _calculateDeliveryFee() == 0
                                  ? 'FREE'
                                  : '₹${_calculateDeliveryFee()}',
                              isFree: _calculateDeliveryFee() == 0,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child:
                                  Divider(height: 1, color: Color(0xFFDEE2E6)),
                            ),
                            _buildBreakdownRow(
                              'Total Amount / மொத்த தொகை',
                              '₹${_calculateTotal() + _calculateDeliveryFee()}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryScheduleScreen(
                                  language: widget.language,
                                  userCard: widget.userCard,
                                  isEligibleForFree: widget.isEligibleForFree,
                                  deliveryAddress: widget.deliveryAddress,
                                  selectedItems: _selectedItems,
                                  itemPrices: _itemPrices,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Continue to Schedule Delivery',
                                style: AppTextStyles.buttonEn,
                              ),
                              Text(
                                'டெலிவரி திட்டமிட தொடரவும்',
                                style: AppTextStyles.buttonTa,
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildCommodityItem({
    required String id,
    required String name,
    required String priceTag,
    required String info,
    required int maxQty,
    required bool isFree,
    String unit = 'kg',
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 14),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isFree
                      ? const Color(0xFF2D5F4F)
                      : const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  priceTag,
                  style: AppTextStyles.captionEn.copyWith(
                    color: isFree ? Colors.white : const Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            info,
            style: AppTextStyles.bodyEn.copyWith(
              fontSize: 12,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildQtyButton(
                icon: Icons.remove,
                onPressed: () {
                  setState(() {
                    _selectedItems[id] =
                        (_selectedItems[id]! - 1).clamp(0, maxQty);
                  });
                },
              ),
              Expanded(
                child: Text(
                  '${_selectedItems[id]} $unit',
                  style: AppTextStyles.heading3En.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildQtyButton(
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    _selectedItems[id] =
                        (_selectedItems[id]! + 1).clamp(0, maxQty);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D5F4F),
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value,
      {bool isFree = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.bodyBoldEn.copyWith(fontSize: 16)
              : AppTextStyles.bodyEn.copyWith(fontSize: 14),
        ),
        if (isFree && value == 'FREE')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4EDDA),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: AppTextStyles.captionEn.copyWith(
                color: const Color(0xFF155724),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            value,
            style: isTotal
                ? AppTextStyles.heading3En.copyWith(
                    fontSize: 24,
                    color: const Color(0xFF2D5F4F),
                  )
                : AppTextStyles.bodyEn.copyWith(fontSize: 14),
          ),
      ],
    );
  }
}
