import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class HelpSupportScreen extends StatefulWidget {
  final String language;

  const HelpSupportScreen({super.key, required this.language});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  bool voiceAssistant = false;

  final List<Map<String, dynamic>> faqs = [
    {
      'icon': Icons.schedule,
      'question': 'How to Book a Slot?',
      'tamilQuestion': 'இடைவெளியை எவ்வாறு முன்பதிவு செய்வது?',
      'answer': 'Go to Pre-Order Items → Select quantities → Book Time Slot',
    },
    {
      'icon': Icons.store,
      'question': 'Check Stock Availability',
      'tamilQuestion': 'இருப்பு நிலையைச் சரிபார்க்கவும்',
      'answer': 'View real-time inventory on the Home Dashboard',
    },
    {
      'icon': Icons.report,
      'question': 'Report an Issue',
      'tamilQuestion': 'சிக்கலைப் புகாரளிக்கவும்',
      'answer': 'Call 1967 helpline or use the complaint form',
    },
    {
      'icon': Icons.info,
      'question': 'About Ration Card',
      'tamilQuestion': 'ரேஷன் அட்டையைப் பற்றி',
      'answer': 'View card details, quota, and family members in My Card section',
    },
  ];

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
                            'Help & Support',
                            style: AppTextStyles.heading2En.copyWith(color: Colors.white),
                          ),
                          Text(
                            'உதவி & ஆதரவு',
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
                      // Emergency Helpline
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primaryOrange, Color(0xFFe68a2e)],
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
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 36, color: Colors.white),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '24/7 Helpline',
                                      style: AppTextStyles.captionEn.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '24/7 உதவி எண்',
                                      style: AppTextStyles.captionTa.copyWith(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '1967',
                              style: AppTextStyles.heading1En.copyWith(
                                color: Colors.white,
                                fontSize: 48,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.primaryOrange,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: const Size(double.infinity, 64),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.phone, size: 28),
                                    const SizedBox(width: 12),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'One-Tap Call',
                                          style: AppTextStyles.buttonEn.copyWith(
                                            color: AppColors.primaryOrange,
                                          ),
                                        ),
                                        Text(
                                          'ஒரு தட்டு அழைப்பு',
                                          style: AppTextStyles.buttonTa.copyWith(
                                            color: AppColors.primaryOrange,
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
                      const SizedBox(height: 24),
                      
                      // Voice Assistant
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
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.volume_up, size: 28, color: AppColors.primaryGreen),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Voice Assistant Help',
                                        style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'குரல் உதவியாளர் உதவி',
                                        style: AppTextStyles.bodyTa,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Get audio guidance in Tamil',
                                        style: AppTextStyles.captionEn,
                                      ),
                                      Text(
                                        'தமிழில் ஆடியோ வழிகாட்டுதலைப் பெறுங்கள்',
                                        style: AppTextStyles.captionTa.copyWith(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      voiceAssistant = !voiceAssistant;
                                    });
                                  },
                                  child: Container(
                                    width: 68,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: voiceAssistant ? AppColors.statusAvailable : AppColors.borderColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 200),
                                      alignment: voiceAssistant ? Alignment.centerRight : Alignment.centerLeft,
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (voiceAssistant) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.statusAvailable.withOpacity(0.15),
                                  border: Border.all(color: AppColors.statusAvailable, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '✓ Voice Assistant Enabled',
                                      style: AppTextStyles.bodyBoldEn.copyWith(
                                        color: const Color(0xFF16a34a),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'குரல் உதவியாளர் இயக்கப்பட்டது',
                                      style: AppTextStyles.bodyTa.copyWith(
                                        color: const Color(0xFF16a34a),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // FAQ Section
                      Row(
                        children: [
                          const Icon(Icons.help, size: 28, color: AppColors.primaryGreen),
                          const SizedBox(width: 8),
                          Text(
                            'Frequently Asked Questions',
                            style: AppTextStyles.heading3En,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'அடிக்கடி கேட்கப்படும் கேள்விகள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      ...faqs.map((faq) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderColor),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(faq['icon'], size: 28, color: AppColors.primaryGreen),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      faq['question'],
                                      style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 17),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      faq['tamilQuestion'],
                                      style: AppTextStyles.bodyTa,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      faq['answer'],
                                      style: AppTextStyles.bodyEn.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 15,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 24),
                      
                      // Additional Resources
                      Text(
                        'Additional Resources',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'கூடுதல் வளங்கள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      _buildResourceButton(
                        'User Guide & Tutorials',
                        'பயனர் வழிகாட்டி & பயிற்சிகள்',
                        Icons.info,
                      ),
                      const SizedBox(height: 12),
                      _buildResourceButton(
                        'Submit Complaint',
                        'புகாரை சமர்ப்பிக்கவும்',
                        Icons.report,
                      ),
                      const SizedBox(height: 32),
                      
                      // App Info
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Namma Ration App v1.0.0',
                              style: AppTextStyles.captionEn,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'தமிழ்நாடு பொது விநியோக அமைப்பு',
                              style: AppTextStyles.captionTa.copyWith(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '© 2025 Government of Tamil Nadu',
                              style: AppTextStyles.captionEn.copyWith(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ],
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

  Widget _buildResourceButton(String title, String tamilTitle, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          side: const BorderSide(color: AppColors.borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: const Size(double.infinity, 68),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.primaryGreen),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 17),
                  ),
                  Text(
                    tamilTitle,
                    style: AppTextStyles.bodyTa.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
