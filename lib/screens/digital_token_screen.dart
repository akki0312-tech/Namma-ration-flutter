import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class DigitalTokenScreen extends StatelessWidget {
  final String language;
  final String bookingDate;
  final String bookingTime;

  const DigitalTokenScreen({
    super.key,
    required this.language,
    required this.bookingDate,
    required this.bookingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              // Success Header
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.statusSuccess,
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
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 32),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 72,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Booking Confirmed!',
                      style: AppTextStyles.heading1En.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'முன்பதிவு உறுதி செய்யப்பட்டது!',
                      style: AppTextStyles.heading2Ta.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
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
                      // Token Number Card
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primaryGreen, Color(0xFF004d38)],
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
                        child: Column(
                          children: [
                            Text(
                              'Your Token Number',
                              style: AppTextStyles.bodyEn.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'உங்கள் டோக்கன் எண்',
                              style: AppTextStyles.captionTa.copyWith(
                                color: Colors.white.withOpacity(0.85),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'A-142',
                              style: AppTextStyles.heading1En.copyWith(
                                color: Colors.white,
                                fontSize: 64,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.schedule, size: 24, color: Colors.white),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Time Slot / நேர இடைவெளி',
                                        style: AppTextStyles.captionEn.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    bookingTime,
                                    style: AppTextStyles.heading2En.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    bookingDate,
                                    style: AppTextStyles.bodyEn.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // QR Code Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                            Text(
                              'Digital Token',
                              style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'டிஜிட்டல் டோக்கன்',
                              style: AppTextStyles.bodyTa,
                            ),
                            const SizedBox(height: 16),
                            
                            // QR Code
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                border: Border.all(color: AppColors.primaryGreen, width: 4),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: QrImageView(
                                data: 'NAMMA_RATION_TOKEN_A142_$bookingDate',
                                version: QrVersions.auto,
                                size: 240,
                                backgroundColor: Colors.white,
                                eyeStyle: const QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: AppColors.primaryGreen,
                                ),
                                dataModuleStyle: const QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: AppColors.textPrimary,
                                ),
                                embeddedImage: null,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Warning Banner
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.warningBackground,
                                border: Border.all(color: AppColors.warningBorder),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '⚠️ Show this at the counter',
                                    style: AppTextStyles.bodyBoldEn.copyWith(
                                      color: AppColors.warningText,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'இதை கவுண்டரில் காட்டவும்',
                                    style: AppTextStyles.bodyTa.copyWith(
                                      color: AppColors.warningText,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Shop Details
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                              children: [
                                const Icon(Icons.store, size: 28, color: AppColors.primaryGreen),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shop Location',
                                      style: AppTextStyles.captionEn,
                                    ),
                                    Text(
                                      'கடை இருப்பிடம்',
                                      style: AppTextStyles.captionTa.copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Shop #402, Anna Nagar',
                              style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Anna Nagar West Extension, Chennai - 600101',
                              style: AppTextStyles.bodyEn.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            minimumSize: const Size(double.infinity, 64),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.download, size: 28),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Save to Gallery',
                                    style: AppTextStyles.buttonEn,
                                  ),
                                  Text(
                                    'கேலரியில் சேமிக்கவும்',
                                    style: AppTextStyles.buttonTa,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryGreen,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            side: const BorderSide(color: AppColors.primaryGreen, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 64),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Back to Home',
                                style: AppTextStyles.buttonEn.copyWith(
                                  color: AppColors.primaryGreen,
                                ),
                              ),
                              Text(
                                'முகப்புக்குத் திரும்பு',
                                style: AppTextStyles.buttonTa.copyWith(
                                  color: AppColors.primaryGreen,
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
            ],
          ),
        ),
      ),
    );
  }
}
