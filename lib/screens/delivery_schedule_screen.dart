import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'delivery_review_screen.dart';

class DeliveryScheduleScreen extends StatefulWidget {
  final String language;
  final Map<String, dynamic> userCard;
  final bool isEligibleForFree;
  final Map<String, String> deliveryAddress;
  final Map<String, int> selectedItems;
  final Map<String, int> itemPrices;

  const DeliveryScheduleScreen({
    super.key,
    required this.language,
    required this.userCard,
    required this.isEligibleForFree,
    required this.deliveryAddress,
    required this.selectedItems,
    required this.itemPrices,
  });

  @override
  State<DeliveryScheduleScreen> createState() => _DeliveryScheduleScreenState();
}

class _DeliveryScheduleScreenState extends State<DeliveryScheduleScreen> {
  int? _selectedDeliveryDate;
  int? _selectedDeliverySlot;

  final List<Map<String, dynamic>> _deliveryDates = [
    {
      'date': 'Sat, Jan 4',
      'available': true,
      'routeId': 'ANW-01',
      'deliveries': 12
    },
    {
      'date': 'Sun, Jan 5',
      'available': true,
      'routeId': 'ANW-01',
      'deliveries': 8
    },
    {
      'date': 'Sat, Jan 11',
      'available': true,
      'routeId': 'ANW-01',
      'deliveries': 15
    },
    {
      'date': 'Sun, Jan 12',
      'available': false,
      'routeId': 'ANW-01',
      'deliveries': 30
    },
  ];

  final List<Map<String, dynamic>> _deliveryTimeSlots = [
    {'time': '09:00 AM - 01:00 PM', 'label': 'Morning Slot', 'available': true},
    {
      'time': '02:00 PM - 06:00 PM',
      'label': 'Afternoon Slot',
      'available': true
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
                            'Schedule Delivery',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'டெலிவரி திட்டமிடவும்',
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
                              Icons.calendar_today,
                              color: Color(0xFFFFC107),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deliveries operate on fixed routes. Select available date and time window.',
                                    style: AppTextStyles.bodyEn
                                        .copyWith(fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'டெலிவரிகள் நிலையான வழித்தடங்களில் செயல்படுகின்றன.',
                                    style: AppTextStyles.bodyTa
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Delivery Dates
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Delivery Dates',
                            style:
                                AppTextStyles.heading3En.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'கிடைக்கக்கூடிய டெலிவரி தேதிகள்',
                            style:
                                AppTextStyles.heading3Ta.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          ..._deliveryDates.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final dateObj = entry.value;
                            return _buildDateCard(idx, dateObj);
                          }),
                        ],
                      ),

                      if (_selectedDeliveryDate != null) ...[
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Time Window',
                              style: AppTextStyles.heading3En
                                  .copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'நேர இடைவெளியைத் தேர்ந்தெடுக்கவும்',
                              style: AppTextStyles.heading3Ta
                                  .copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: _deliveryTimeSlots.length,
                              itemBuilder: (context, idx) {
                                return _buildTimeSlotCard(
                                    idx, _deliveryTimeSlots[idx]);
                              },
                            ),
                          ],
                        ),
                      ],

                      if (_selectedDeliveryDate != null &&
                          _selectedDeliverySlot != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F4FD),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 20,
                                color: Color(0xFF6366F1),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'You will receive SMS updates on delivery day with live tracking link and agent contact.',
                                      style: AppTextStyles.bodyEn
                                          .copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'டெலிவரி நாளில் நேரலை கண்காணிப்பு இணைப்புடன் SMS புதுப்பிப்புகளைப் பெறுவீர்கள்.',
                                      style: AppTextStyles.bodyTa
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),
                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (_selectedDeliveryDate != null &&
                                  _selectedDeliverySlot != null)
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DeliveryReviewScreen(
                                        language: widget.language,
                                        userCard: widget.userCard,
                                        isEligibleForFree:
                                            widget.isEligibleForFree,
                                        deliveryAddress: widget.deliveryAddress,
                                        selectedItems: widget.selectedItems,
                                        itemPrices: widget.itemPrices,
                                        selectedDate: _deliveryDates[
                                            _selectedDeliveryDate!],
                                        selectedSlot: _deliveryTimeSlots[
                                            _selectedDeliverySlot!],
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
                            disabledBackgroundColor: const Color(0xFFCCCCCC),
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
                                'Review Order',
                                style: AppTextStyles.buttonEn,
                              ),
                              Text(
                                'ஆர்டரை மதிப்பாய்வு செய்யவும்',
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

  Widget _buildDateCard(int idx, Map<String, dynamic> dateObj) {
    final bool isSelected = _selectedDeliveryDate == idx;
    final bool isAvailable = dateObj['available'];

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                _selectedDeliveryDate = idx;
                _selectedDeliverySlot = null;
              });
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6366F1) : const Color(0xFFE0E0E0),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Opacity(
          opacity: isAvailable ? 1.0 : 0.5,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Color(0xFF2D5F4F),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      dateObj['date'],
                      style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 16),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: Color(0xFF2D5F4F),
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_shipping,
                        size: 14,
                        color: Color(0xFF666666),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Route: ${dateObj['routeId']}',
                        style: AppTextStyles.bodyEn.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? const Color(0xFFD4EDDA)
                          : const Color(0xFFF8D7DA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isAvailable
                          ? '${30 - (dateObj['deliveries'] as int)} slots available'
                          : 'Fully Booked',
                      style: AppTextStyles.captionEn.copyWith(
                        color: isAvailable
                            ? const Color(0xFF155724)
                            : const Color(0xFF721C24),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlotCard(int idx, Map<String, dynamic> slot) {
    final bool isSelected = _selectedDeliverySlot == idx;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeliverySlot = idx;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6366F1) : const Color(0xFFE0E0E0),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Color(0xFF2D5F4F),
                ),
                const SizedBox(height: 8),
                Text(
                  slot['label'],
                  style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  slot['time'],
                  style: AppTextStyles.bodyEn.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (isSelected)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check,
                  color: Color(0xFF2D5F4F),
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
