import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'delivery_confirmation_screen.dart';

class DeliveryReviewScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> userCard;
  final bool isEligibleForFree;
  final Map<String, String> deliveryAddress;
  final Map<String, int> selectedItems;
  final Map<String, int> itemPrices;
  final Map<String, dynamic> selectedDate;
  final Map<String, dynamic> selectedSlot;

  const DeliveryReviewScreen({
    super.key,
    required this.language,
    required this.userCard,
    required this.isEligibleForFree,
    required this.deliveryAddress,
    required this.selectedItems,
    required this.itemPrices,
    required this.selectedDate,
    required this.selectedSlot,
  });

  @override
  State<DeliveryReviewScreen> createState() => _DeliveryReviewScreenState();
}

class _DeliveryReviewScreenState extends State<DeliveryReviewScreen> {
  int _calculateTotal() {
    int total = 0;
    widget.selectedItems.forEach((key, quantity) {
      total += quantity * widget.itemPrices[key]!;
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
                            'Review & Confirm Delivery',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'மதிப்பாய்வு மற்றும் உறுதிப்படுத்தவும்',
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
                      // Order Summary
                      _buildReviewSection(
                        title: 'Order Summary / ஆர்டர் சுருக்கம்',
                        icon: Icons.shopping_basket,
                        child: Column(
                          children: [
                            if (widget.selectedItems['rice']! > 0)
                              _buildReviewItem('Rice / அரிசி',
                                  '${widget.selectedItems['rice']} kg'),
                            if (widget.selectedItems['sugar']! > 0)
                              _buildReviewItem('Sugar / சர்க்கரை',
                                  '${widget.selectedItems['sugar']} kg'),
                            if (widget.selectedItems['cookingOil']! > 0)
                              _buildReviewItem('Cooking Oil / சமையல் எண்ணெய்',
                                  '${widget.selectedItems['cookingOil']} L'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Delivery Address
                      _buildReviewSection(
                        title: 'Delivery Address / டெலிவரி முகவரி',
                        icon: Icons.location_on,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.deliveryAddress['line1']}, ${widget.deliveryAddress['line2']}',
                              style:
                                  AppTextStyles.bodyEn.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.deliveryAddress['city']} - ${widget.deliveryAddress['pincode']}',
                              style:
                                  AppTextStyles.bodyEn.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Landmark: ${widget.deliveryAddress['landmark']}',
                              style: AppTextStyles.bodyEn.copyWith(
                                fontSize: 13,
                                color: const Color(0xFF6C757D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Delivery Schedule
                      _buildReviewSection(
                        title: 'Delivery Schedule / டெலிவரி அட்டவணை',
                        icon: Icons.calendar_today,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedDate['date'],
                              style: AppTextStyles.bodyBoldEn
                                  .copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.selectedSlot['time'],
                              style:
                                  AppTextStyles.bodyEn.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Route: ${widget.selectedDate['routeId']}',
                              style: AppTextStyles.bodyEn.copyWith(
                                fontSize: 13,
                                color: const Color(0xFF6C757D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Payment Summary
                      _buildReviewSection(
                        title: 'Payment Summary / கட்டண சுருக்கம்',
                        icon: Icons.currency_rupee,
                        isPayment: true,
                        child: Column(
                          children: [
                            _buildPaymentRow(
                                'Items Total', '₹${_calculateTotal()}'),
                            const SizedBox(height: 8),
                            _buildPaymentRow(
                              'Delivery Fee',
                              _calculateDeliveryFee() == 0
                                  ? 'FREE'
                                  : '₹${_calculateDeliveryFee()}',
                              isFree: _calculateDeliveryFee() == 0,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child:
                                  Divider(height: 1, color: Color(0xFFDEE2E6)),
                            ),
                            _buildPaymentRow(
                              'Total Payable',
                              '₹${_calculateTotal() + _calculateDeliveryFee()}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Terms Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF856404),
                              size: 16,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cancellation Policy / ரத்து கொள்கை',
                                    style: AppTextStyles.bodyBoldEn
                                        .copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTermItem(
                                      'Free cancellation up to 48 hours before delivery'),
                                  _buildTermItem(
                                      '50% refund for 24-48 hours before'),
                                  _buildTermItem('No refund within 24 hours'),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                builder: (context) =>
                                    DeliveryConfirmationScreen(
                                  language: widget.language,
                                  deliveryAddress: widget.deliveryAddress,
                                  selectedDate: widget.selectedDate,
                                  selectedSlot: widget.selectedSlot,
                                  totalAmount: _calculateTotal() +
                                      _calculateDeliveryFee(),
                                  orderId: 'DL-2025-0142',
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
                                'Confirm & Place Order',
                                style: AppTextStyles.buttonEn,
                              ),
                              Text(
                                'உறுதிப்படுத்தி ஆர்டர் செய்யவும்',
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

  Widget _buildReviewSection({
    required String title,
    required IconData icon,
    required Widget child,
    bool isPayment = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPayment ? const Color(0xFFF8F9FA) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF2D5F4F)),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.bodyBoldEn.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF2D5F4F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, String qty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: AppTextStyles.bodyEn.copyWith(fontSize: 14)),
          Text(qty, style: AppTextStyles.bodyEn.copyWith(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value,
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
                    fontSize: 20,
                    color: const Color(0xFF2D5F4F),
                  )
                : AppTextStyles.bodyEn.copyWith(fontSize: 14),
          ),
      ],
    );
  }

  Widget _buildTermItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyEn.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
