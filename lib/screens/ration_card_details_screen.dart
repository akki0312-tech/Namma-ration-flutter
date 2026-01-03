import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class RationCardDetailsScreen extends StatelessWidget {
  final String language;

  const RationCardDetailsScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final quotaItems = [
      {'item': 'Rice / அரிசி', 'quantity': '20 kg'},
      {'item': 'Sugar / சர்க்கரை', 'quantity': '2 kg'},
      {'item': 'Cooking Oil / சமையல் எண்ணெய்', 'quantity': '2 L'},
      {'item': 'Wheat / கோதுமை', 'quantity': '5 kg'},
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
                            'My Ration Card',
                            style: AppTextStyles.heading2En.copyWith(color: Colors.white),
                          ),
                          Text(
                            'எனது ரேஷன் அட்டை',
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
                    children: [
                      // Card Preview
                      Container(
                        padding: const EdgeInsets.all(24),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Card Number / அட்டை எண்',
                                      style: AppTextStyles.captionEn.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '01/G/0123456',
                                      style: AppTextStyles.heading1En.copyWith(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.credit_card,
                                  size: 40,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Card Type / அட்டை வகை',
                                    style: AppTextStyles.captionEn.copyWith(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Priority Household (PHH)',
                                    style: AppTextStyles.bodyBoldEn.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'முன்னுரிமை குடும்ப அட்டை',
                                    style: AppTextStyles.bodyTa.copyWith(
                                      color: Colors.white.withOpacity(0.95),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Head of Family
                      _buildInfoCard(
                        icon: Icons.person,
                        title: 'Head of Family',
                        tamilTitle: 'குடும்பத் தலைவர்',
                        content: 'Smt. Lakshmi Sundaram',
                        tamilContent: 'திருமதி. லக்ஷ்மி சுந்தரம்',
                      ),
                      const SizedBox(height: 16),
                      
                      // Registered Shop
                      _buildInfoCard(
                        icon: Icons.store,
                        title: 'Registered Shop',
                        tamilTitle: 'பதிவு செய்யப்பட்ட கடை',
                        content: 'Shop #402, Anna Nagar',
                        subtitle: 'Anna Nagar West Extension, Chennai - 600101',
                      ),
                      const SizedBox(height: 16),
                      
                      // Monthly Quota
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
                            Text(
                              'Monthly Quota Entitlement',
                              style: AppTextStyles.heading3En,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'மாதாந்திர ஒதுக்கீடு உரிமை',
                              style: AppTextStyles.heading3Ta,
                            ),
                            const SizedBox(height: 16),
                            ...quotaItems.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  border: Border.all(color: AppColors.borderColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['item']!,
                                      style: AppTextStyles.bodyBoldEn,
                                    ),
                                    Text(
                                      item['quantity']!,
                                      style: AppTextStyles.bodyBoldEn.copyWith(
                                        color: AppColors.primaryGreen,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // View Family Members Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
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
                              const Icon(Icons.people, size: 28),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View Family Members',
                                    style: AppTextStyles.buttonEn,
                                  ),
                                  Text(
                                    'குடும்ப உறுப்பினர்களைக் காண்க',
                                    style: AppTextStyles.buttonTa,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String tamilTitle,
    required String content,
    String? tamilContent,
    String? subtitle,
  }) {
    return Container(
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
              Icon(icon, size: 28, color: AppColors.primaryGreen),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.captionEn,
                  ),
                  Text(
                    tamilTitle,
                    style: AppTextStyles.captionTa.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: AppTextStyles.heading3En.copyWith(fontSize: 20),
          ),
          if (tamilContent != null) ...[
            const SizedBox(height: 4),
            Text(
              tamilContent,
              style: AppTextStyles.heading3Ta,
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodyEn.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
