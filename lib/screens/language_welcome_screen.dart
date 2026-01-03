import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'home_dashboard_screen.dart';

class LanguageWelcomeScreen extends StatelessWidget {
  const LanguageWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tamil Nadu Emblem
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(64),
                ),
                child: Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: const Center(
                      child: Text(
                        '🏛️',
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // App Title
              Text(
                'Namma Ration',
                style: AppTextStyles.heading1En.copyWith(
                  color: AppColors.primaryGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'நம்ம ரேஷன்',
                style: AppTextStyles.heading2Ta,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Public Distribution System',
                style: AppTextStyles.bodyEn,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'பொது விநியோக அமைப்பு',
                style: AppTextStyles.bodyTa,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Language Buttons
              _buildLanguageButton(
                context,
                'English',
                'ஆங்கிலம்',
                AppColors.primaryGreen,
                'en',
              ),
              const SizedBox(height: 16),
              _buildLanguageButton(
                context,
                'தமிழ்',
                'Tamil',
                AppColors.primaryOrange,
                'ta',
              ),
              const SizedBox(height: 32),
              
              // Footer Text
              Text(
                'Select your preferred language',
                style: AppTextStyles.captionEn,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'உங்கள் விருப்ப மொழியைத் தேர்ந்தெடுக்கவும்',
                style: AppTextStyles.captionTa,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    String primaryText,
    String secondaryText,
    Color color,
    String language,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDashboardScreen(language: language),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          minimumSize: const Size(double.infinity, 68),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              primaryText,
              style: AppTextStyles.buttonEn.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              secondaryText,
              style: AppTextStyles.buttonTa.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
