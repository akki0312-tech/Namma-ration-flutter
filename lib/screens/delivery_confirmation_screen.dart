import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'track_delivery_screen.dart';
import 'home_dashboard_screen.dart';

class DeliveryConfirmationScreen extends StatefulWidget {
  final String language;
  final Map<String, String> deliveryAddress;
  final Map<String, dynamic> selectedDate;
  final Map<String, dynamic> selectedSlot;
  final int totalAmount;
  final String orderId;

  const DeliveryConfirmationScreen({
    super.key,
    required this.language,
    required this.deliveryAddress,
    required this.selectedDate,
    required this.selectedSlot,
    required this.totalAmount,
    required this.orderId,
  });

  @override
  State<DeliveryConfirmationScreen> createState() =>
      _DeliveryConfirmationScreenState();
}

class _DeliveryConfirmationScreenState
    extends State<DeliveryConfirmationScreen> {
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
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2D5F4F), Color(0xFF4A8B76)],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Delivery Confirmed!',
                      style: AppTextStyles.heading2En
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'டெலிவரி உறுதிப்படுத்தப்பட்டது!',
                      style: AppTextStyles.bodyTa.copyWith(
                        color: Colors.white.withOpacity(0.9),
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
                      // Truck Icon
                      const Icon(
                        Icons.local_shipping,
                        size: 64,
                        color: Color(0xFF6366F1),
                      ),
                      const SizedBox(height: 20),

                      // Order ID Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Delivery Order ID / டெலிவரி ஆர்டர் எண்',
                              style: AppTextStyles.bodyEn.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.orderId,
                              style: AppTextStyles.heading1En.copyWith(
                                color: Colors.white,
                                fontSize: 36,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Details Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              Icons.calendar_today,
                              'Scheduled Delivery / திட்டமிட்ட டெலிவரி',
                              [
                                widget.selectedDate['date'],
                                widget.selectedSlot['time'],
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child:
                                  Divider(height: 1, color: Color(0xFFE0E0E0)),
                            ),
                            _buildDetailRow(
                              Icons.location_on,
                              'Delivery Address / டெலிவரி முகவரி',
                              [
                                widget.deliveryAddress['line1']!,
                                widget.deliveryAddress['line2']!,
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child:
                                  Divider(height: 1, color: Color(0xFFE0E0E0)),
                            ),
                            _buildDetailRow(
                              Icons.phone,
                              'Contact Number / தொடர்பு எண்',
                              [widget.deliveryAddress['phone']!],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Next Steps
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
                            Text(
                              'Next Steps / அடுத்த படிகள்',
                              style: AppTextStyles.bodyBoldEn.copyWith(
                                color: const Color(0xFF2D5F4F),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildStepItem(
                                'You will receive SMS confirmation shortly'),
                            _buildStepItem(
                                '24 hours before: Delivery reminder SMS'),
                            _buildStepItem(
                                'On delivery day: Live tracking link & agent contact'),
                            _buildStepItem(
                                'After delivery: Digital receipt via SMS'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Buttons
                      Column(
                        children: [
                          // Track Delivery Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackDeliveryScreen(
                                      language: widget.language,
                                      orderId: widget.orderId,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.navigation, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Track Delivery',
                                        style: AppTextStyles.buttonEn,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'டெலிவரியைக் கண்காணிக்கவும்',
                                    style: AppTextStyles.buttonTa,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Back to Home Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeDashboardScreen(
                                        language: widget.language),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF2D5F4F),
                                side: const BorderSide(
                                    color: Color(0xFF2D5F4F), width: 2),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Back to Home',
                                    style: AppTextStyles.buttonEn.copyWith(
                                        color: const Color(0xFF2D5F4F)),
                                  ),
                                  Text(
                                    'முகப்புக்குத் திரும்பு',
                                    style: AppTextStyles.buttonTa.copyWith(
                                        color: const Color(0xFF2D5F4F)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildDetailRow(IconData icon, String label, List<String> values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6C757D)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyBoldEn.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF2D5F4F),
                ),
              ),
              const SizedBox(height: 4),
              ...values.map((v) => Text(
                    v,
                    style: AppTextStyles.bodyEn.copyWith(
                      fontSize: 13,
                      color: const Color(0xFF495057),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 16,
            color: Color(0xFF2D5F4F),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyEn.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
