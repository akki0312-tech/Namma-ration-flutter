import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'delivery_address_screen.dart';

class DeliveryEligibilityScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> userCard;

  const DeliveryEligibilityScreen({
    super.key,
    required this.language,
    required this.userCard,
  });

  @override
  State<DeliveryEligibilityScreen> createState() =>
      _DeliveryEligibilityScreenState();
}

class _DeliveryEligibilityScreenState extends State<DeliveryEligibilityScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isEligibleForFree = widget.userCard['age'] >= 70;

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
                            'Delivery Eligibility Check',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'டெலிவரி தகுதி சரிபார்ப்பு',
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
                      // Eligibility Card
                      Container(
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
                            const Icon(
                              Icons.local_shipping,
                              size: 48,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Doorstep Delivery Service',
                              style: AppTextStyles.heading2En.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'வீட்டு வாசல் டெலிவரி சேவை',
                              style: AppTextStyles.bodyTa.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Info Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F4FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF6366F1),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Free Delivery Available For:',
                                    style: AppTextStyles.bodyBoldEn
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'இலவச டெலிவரி கிடைக்கும்:',
                                    style: AppTextStyles.bodyTa
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildBulletPoint(
                                      'Senior Citizens (70+ years) / மூத்த குடிமக்கள்'),
                                  _buildBulletPoint(
                                      'Differently-abled / மாற்றுத்திறனாளிகள்'),
                                  _buildBulletPoint(
                                      'Pregnant Women / கர்ப்பிணி பெண்கள்'),
                                  _buildBulletPoint(
                                      'Chronically Ill / நாள்பட்ட நோயாளிகள்'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User Status
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 24,
                              color: Color(0xFF2D5F4F),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Status / உங்கள் நிலை',
                                    style: AppTextStyles.bodyBoldEn
                                        .copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.userCard['headOfFamily']} - Age: ${widget.userCard['age']} years',
                                    style: AppTextStyles.bodyEn
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Eligibility Result
                      if (isEligibleForFree)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4EDDA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 24,
                                color: Color(0xFF155724),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Eligible for Free Delivery',
                                      style: AppTextStyles.bodyBoldEn.copyWith(
                                        fontSize: 14,
                                        color: const Color(0xFF155724),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'இலவச டெலிவரிக்கு தகுதியானவர்',
                                      style: AppTextStyles.bodyTa.copyWith(
                                        fontSize: 13,
                                        color: const Color(0xFF155724),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'As a senior citizen, you qualify for free doorstep delivery',
                                      style: AppTextStyles.bodyEn.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF155724),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                size: 24,
                                color: Color(0xFF856404),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nominal Delivery Fee: ₹25',
                                      style: AppTextStyles.bodyBoldEn.copyWith(
                                        fontSize: 14,
                                        color: const Color(0xFF856404),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'சின்னஞ்சிறு டெலிவரி கட்டணம்',
                                      style: AppTextStyles.bodyTa.copyWith(
                                        fontSize: 13,
                                        color: const Color(0xFF856404),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Covers fuel and delivery personnel costs',
                                      style: AppTextStyles.bodyEn.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF856404),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Service Benefits
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
                              'Service Benefits / சேவை நன்மைகள்',
                              style: AppTextStyles.heading3En
                                  .copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            _buildBenefitItem(
                                'No queue waiting / வரிசை காத்திருப்பு இல்லை'),
                            _buildBenefitItem(
                                'Scheduled delivery to doorstep / திட்டமிட்ட டெலிவரி'),
                            _buildBenefitItem(
                                'Electronic weighing at home / வீட்டில் எலக்ட்ரானிக் எடை'),
                            _buildBenefitItem(
                                'Digital receipt via SMS / SMS மூலம் டிஜிட்டல் ரசீது'),
                            _buildBenefitItem(
                                'Live tracking on delivery day / டெலிவரி நாளில் நேரலை கண்காணிப்பு'),
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
                                builder: (context) => DeliveryAddressScreen(
                                  language: widget.language,
                                  userCard: widget.userCard,
                                  isEligibleForFree: isEligibleForFree,
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
                                'Continue to Address Verification',
                                style: AppTextStyles.buttonEn,
                              ),
                              Text(
                                'முகவரி சரிபார்ப்புக்கு தொடரவும்',
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 13)),
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

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
