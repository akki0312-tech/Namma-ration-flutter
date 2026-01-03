import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'ration_card_details_screen.dart';
import 'map_locator_screen.dart';
import 'item_preorder_screen.dart';
import 'help_support_screen.dart';
import 'delivery_eligibility_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final String language;

  const HomeDashboardScreen({super.key, required this.language});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _inventoryItems = [
    {
      'name': 'Rice',
      'tamilName': 'அரிசி',
      'icon': Icons.grain,
      'status': 'available',
      'quantity': '250 kg',
      'statusText': 'In Stock',
      'statusTamil': 'கையிருப்பில் உள்ளது',
    },
    {
      'name': 'Sugar',
      'tamilName': 'சர்க்கரை',
      'icon': Icons.local_drink,
      'status': 'limited',
      'quantity': '45 kg',
      'statusText': 'Limited',
      'statusTamil': 'குறைந்த அளவு',
    },
    {
      'name': 'Cooking Oil',
      'tamilName': 'சமையல் எண்ணெய்',
      'icon': Icons.opacity_outlined,
      'status': 'available',
      'quantity': '80 L',
      'statusText': 'In Stock',
      'statusTamil': 'கையிருப்பில் உள்ளது',
    },
    {
      'name': 'Wheat',
      'tamilName': 'கோதுமை',
      'icon': Icons.grain,
      'status': 'out',
      'quantity': '0 kg',
      'statusText': 'Out of Stock',
      'statusTamil': 'கையிருப்பு இல்லை',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return AppColors.statusAvailable;
      case 'limited':
        return AppColors.statusLimited;
      case 'out':
        return AppColors.statusOut;
      default:
        return AppColors.textSecondary;
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RationCardDetailsScreen(language: widget.language),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapLocatorScreen(language: widget.language),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HelpSupportScreen(language: widget.language),
          ),
        );
        break;
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
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
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
                              'Your Shop / உங்கள் கடை',
                              style: AppTextStyles.captionEn.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Shop #402, Anna Nagar',
                              style: AppTextStyles.heading2En.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.store,
                          size: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Queue Status
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 28,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Queue Status',
                                  style: AppTextStyles.bodyBoldEn.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'தற்போதைய வரிசை நிலை',
                                  style: AppTextStyles.captionTa.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Low Wait',
                                style: AppTextStyles.heading3En.copyWith(
                                  color: AppColors.statusAvailable,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'குறைந்த காத்திருப்பு',
                                style: AppTextStyles.captionTa.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                ),
                              ),
                            ],
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Inventory Status
                      Text(
                        'Inventory Status',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'சரக்கு நிலை',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85, // Increased from 0.72 to fit content better
                        ),
                        itemCount: _inventoryItems.length,
                        itemBuilder: (context, index) {
                          final item = _inventoryItems[index];
                          return _buildInventoryCard(item);
                        },
                      ),
                      const SizedBox(height: 32),

                      // Quick Actions
                      Text(
                        'Quick Actions',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'விரைவு செயல்கள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),

                      _buildQuickActionButton(
                        'Pre-Order Items',
                        'பொருட்களை முன்பதிவு செய்க',
                        Icons.shopping_basket,
                        AppColors.primaryGreen,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemPreorderScreen(language: widget.language),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildQuickActionButton(
                        'Book Time Slot',
                        'நேர இடைவெளியை முன்பதிவு செய்யுங்கள்',
                        Icons.access_time,
                        AppColors.primaryOrange,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemPreorderScreen(language: widget.language),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildQuickActionButton(
                        'Request Doorstep Delivery',
                        'வீட்டு வாசல் டெலிவரி கோரவும்',
                        Icons.local_shipping,
                        const Color(0xFF6366F1),
                        () {
                          // Mock user card data
                          final userCard = {
                            'cardNumber': '01/G/0123456',
                            'cardType': 'Priority Household (PHH)',
                            'headOfFamily': 'Smt. Lakshmi Sundaram',
                            'age': 68,
                            'shop': 'Shop #402, Anna Nagar',
                            'entitlements': {
                              'rice': 20,
                              'sugar': 2,
                              'cookingOil': 2,
                              'wheat': 5
                            }
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryEligibilityScreen(
                                language: widget.language,
                                userCard: userCard,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    final statusColor = _getStatusColor(item['status']);

    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding from 20 to 12
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item['icon'],
            size: 40, // Slightly improved size balance
            color: AppColors.primaryGreen,
          ),
          const SizedBox(height: 8),
          Text(
            item['name'],
            style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 17),
            textAlign: TextAlign.center,
            maxLines: 1, 
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            item['tamilName'],
            style: AppTextStyles.bodyTa,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            item['quantity'],
            style: AppTextStyles.bodyEn.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              border: Border.all(color: statusColor, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  item['statusText'],
                  style: AppTextStyles.captionEn.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11, // Slightly smaller font to fit
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['statusTamil'],
                  style: AppTextStyles.captionTa.copyWith(
                    color: statusColor,
                    fontSize: 10, // Slightly smaller font
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    String tamilTitle,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          minimumSize: const Size(double.infinity, 68),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.buttonEn,
                  ),
                  Text(
                    tamilTitle,
                    style: AppTextStyles.buttonTa,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}
