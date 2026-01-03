import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
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
  bool _isLoadingLocation = false;

  Map<String, String> _deliveryAddress = {
    'line1': '24, Lakshmi Street',
    'line2': 'Anna Nagar West Extension',
    'city': 'Chennai',
    'pincode': '600101',
    'landmark': 'Near Corporation Primary School',
    'phone': '+91 98765 43210',
  };

  @override
  void initState() {
    super.initState();
    _promptForLocation();
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _promptForLocation() async {
    // Small delay to let UI build
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    // Show dialog asking user if they want to use current location
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Use Current Location?'),
        content: const Text(
          'Do you want to deliver to your current location?\n\nஉங்கள் தற்போதைய இருப்பிடத்திற்கு டெலிவரி செய்ய விரும்புகிறீர்களா?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No / இல்லை'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _detectLocation();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen),
            child:
                const Text('Yes / ஆம்', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _detectLocation() async {
    setState(() => _isLoadingLocation = true);
    debugPrint('LOCATION: Starting _detectLocation');
    try {
      // 1. Check Service
      debugPrint('LOCATION: Checking service status...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint('LOCATION: Service enabled: $serviceEnabled');
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      // 2. Check Permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied.';
      }

      // 3. Get Position
      // Using timeLimit to avoid infinite loading
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // 4. Reverse Geocoding (Direct API for Web reliability)
      // Using the same API Key logic as MapLocatorScreen
      const apiKey = 'AIzaSyBElGwzZ4vmeqxF57lcn9k7RX2ey6MGk-4';
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final results = data['results'] as List;
          if (results.isNotEmpty) {
            final result = results.first;
            final components = result['address_components'] as List;

            // Extract address parts
            String street = '';
            String subLocality = '';
            String locality = '';
            String city = '';
            String pincode = '';

            for (var c in components) {
              final types = c['types'] as List;
              if (types.contains('route'))
                street = c['long_name'];
              else if (types.contains('sublocality'))
                subLocality = c['long_name'];
              else if (types.contains('locality'))
                locality = c['long_name'];
              else if (types.contains('administrative_area_level_2'))
                city = c['long_name'];
              else if (types.contains('postal_code')) pincode = c['long_name'];
            }

            // Fallbacks
            if (street.isEmpty) street = subLocality;
            if (city.isEmpty) city = locality;

            setState(() {
              _deliveryAddress = {
                'line1': '$street, $subLocality',
                'line2': locality,
                'city': city,
                'pincode': pincode,
                'landmark': 'Detected Location',
                'phone': widget.userCard['phone'] ?? '+91 98765 43210',
              };
            });

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location updated successfully!')),
              );
            }
          }
        } else {
          throw 'Geocoding API Error: ${data['status']}';
        }
      } else {
        throw 'Network error: ${response.statusCode}';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to detect location: $e')),
        );
      }
    } finally {
      setState(() => _isLoadingLocation = false);
    }
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
                      if (_isLoadingLocation)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: LinearProgressIndicator(
                              color: AppColors.primaryGreen),
                        ),

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'Delivery Address',
                                      style: AppTextStyles.bodyBoldEn
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: _detectLocation,
                                  icon: const Icon(Icons.my_location,
                                      color: AppColors.primaryGreen),
                                  tooltip: 'Use Current Location',
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
                                  // Edit address functionality (using text fields in a real app)
                                  // For now, we can prompt for manual entry or just keep as mock editing
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Edit feature to be implemented')));
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
