import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'delivery_pre_order_screen.dart';

class DeliveryAddressScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> userCard;
  final bool isEligibleForFree;

  const DeliveryAddressScreen({
    super.key,
    required this.language,
    required this.userCard,
    required this.isEligibleForFree,
  });

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final TextEditingController _instructionsController = TextEditingController();

  final Map<String, String> _deliveryAddress = {
    'line1': '24, Lakshmi Street',
    'line2': 'Anna Nagar West Extension',
    'city': 'Chennai',
    'pincode': '600101',
    'landmark': 'Near Corporation Primary School',
    'phone': '+91 98765 43210',
  };

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
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
                            'Delivery Address',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'டெலிவரி முகவரி',
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
                    children: [
                      // Info Box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(
                            left:
                                BorderSide(color: Color(0xFFFFC107), width: 4),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFFFFC107),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify your delivery address. Must be within 5km of registered shop.',
                                    style: AppTextStyles.bodyEn
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'உங்கள் டெலிவரி முகவரியை சரிபார்க்கவும்.',
                                    style: AppTextStyles.bodyTa
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Address Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFFE0E0E0), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Color(0xFF2D5F4F),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Registered Address / பதிவு செய்யப்பட்ட முகவரி',
                                  style: AppTextStyles.bodyBoldEn
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _deliveryAddress['line1']!,
                              style: AppTextStyles.bodyBoldEn
                                  .copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _deliveryAddress['line2']!,
                              style:
                                  AppTextStyles.bodyEn.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_deliveryAddress['city']} - ${_deliveryAddress['pincode']}',
                              style:
                                  AppTextStyles.bodyEn.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.navigation,
                                  size: 14,
                                  color: Color(0xFF6C757D),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Landmark: ${_deliveryAddress['landmark']}',
                                  style: AppTextStyles.bodyEn.copyWith(
                                    fontSize: 13,
                                    color: const Color(0xFF6C757D),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 14,
                                  color: Color(0xFF6C757D),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Contact: ${_deliveryAddress['phone']}',
                                  style: AppTextStyles.bodyEn.copyWith(
                                    fontSize: 13,
                                    color: const Color(0xFF6C757D),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Edit address functionality
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF6366F1),
                                  side: const BorderSide(
                                      color: Color(0xFF6366F1)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Edit Address / முகவரியைத் திருத்தவும்',
                                  style: AppTextStyles.bodyBoldEn.copyWith(
                                    fontSize: 14,
                                    color: const Color(0xFF6366F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Map Preview
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE8F4F0), Color(0xFFD4EDE4)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 32,
                                color: Color(0xFF2D5F4F),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Anna Nagar West Extension',
                                style: AppTextStyles.bodyBoldEn.copyWith(
                                  color: const Color(0xFF2D5F4F),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '0.8 km from Shop #402',
                                  style: AppTextStyles.bodyEn
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Delivery Instructions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Instructions (Optional)',
                            style:
                                AppTextStyles.heading3En.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _instructionsController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText:
                                  'Add any special instructions for delivery personnel...\nடெலிவரி பணியாளருக்கான சிறப்பு வழிமுறைகளைச் சேர்க்கவும்...',
                              hintStyle: AppTextStyles.bodyEn.copyWith(
                                fontSize: 13,
                                color: const Color(0xFF999999),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0), width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xFFE0E0E0), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xFF6366F1), width: 2),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            style: AppTextStyles.bodyEn.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryPreOrderScreen(
                                  language: widget.language,
                                  userCard: widget.userCard,
                                  isEligibleForFree: widget.isEligibleForFree,
                                  deliveryAddress: _deliveryAddress,
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
                                'Confirm Address & Continue',
                                style: AppTextStyles.buttonEn,
                              ),
                              Text(
                                'முகவரியை உறுதிப்படுத்தி தொடரவும்',
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
}
