import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'digital_token_screen.dart';

class SlotBookingScreen extends StatefulWidget {
  final String language;

  const SlotBookingScreen({super.key, required this.language});

  @override
  State<SlotBookingScreen> createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  late String selectedDate;
  int? selectedSlot;
  late final List<Map<String, String>> dates;

  @override
  void initState() {
    super.initState();
    dates = _generateDates();
    selectedDate = dates[0]['id']!;
  }

  List<Map<String, String>> _generateDates() {
    final now = DateTime.now();
    final List<Map<String, String>> generatedDates = [];

    for (int i = 0; i < 4; i++) {
      final date = now.add(Duration(days: i));
      String id = i == 0 ? 'today' : (i == 1 ? 'tomorrow' : 'day${i + 1}');
      
      String label;
      String tamilLabel;
      
      if (i == 0) {
        label = 'Today';
        tamilLabel = 'இன்று';
      } else if (i == 1) {
        label = 'Tomorrow';
        tamilLabel = 'நாளை';
      } else {
        label = _getWeekdayName(date.weekday);
        tamilLabel = _getTamilWeekday(date.weekday);
      }

      String dateStr = '${_getMonthName(date.month)} ${date.day}';

      generatedDates.add({
        'id': id,
        'label': label,
        'tamilLabel': tamilLabel,
        'date': dateStr,
      });
    }
    return generatedDates;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getTamilWeekday(int weekday) {
    const days = [
      'திங்கள்', // Mon
      'செவ்வாய்', // Tue
      'புதன்', // Wed
      'வியாழன்', // Thu
      'வெள்ளி', // Fri
      'சனி', // Sat
      'ஞாயிறு' // Sun
    ];
    return days[weekday - 1];
  }

  final List<Map<String, dynamic>> slots = [
    {'id': 1, 'time': '08:00 AM - 09:00 AM', 'status': 'vacant', 'slotsLeft': 12},
    {'id': 2, 'time': '09:00 AM - 10:00 AM', 'status': 'vacant', 'slotsLeft': 8},
    {'id': 3, 'time': '10:00 AM - 11:00 AM', 'status': 'filling', 'slotsLeft': 3},
    {'id': 4, 'time': '11:00 AM - 12:00 PM', 'status': 'filling', 'slotsLeft': 2},
    {'id': 5, 'time': '12:00 PM - 01:00 PM', 'status': 'full', 'slotsLeft': 0},
    {'id': 6, 'time': '02:00 PM - 03:00 PM', 'status': 'vacant', 'slotsLeft': 15},
    {'id': 7, 'time': '03:00 PM - 04:00 PM', 'status': 'vacant', 'slotsLeft': 10},
    {'id': 8, 'time': '04:00 PM - 05:00 PM', 'status': 'filling', 'slotsLeft': 4},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'vacant':
        return AppColors.statusAvailable;
      case 'filling':
        return AppColors.statusLimited;
      case 'full':
        return AppColors.statusOut;
      default:
        return AppColors.textSecondary;
    }
  }

  Map<String, String> _getStatusText(String status, int slotsLeft) {
    switch (status) {
      case 'vacant':
        return {'en': 'Vacant ($slotsLeft slots left)', 'ta': 'காலியாக உள்ளது ($slotsLeft இடங்கள்)'};
      case 'filling':
        return {'en': 'Filling Fast ($slotsLeft left)', 'ta': 'விரைவில் நிரம்பும் ($slotsLeft)'};
      case 'full':
        return {'en': 'Full', 'ta': 'நிரம்பியது'};
      default:
        return {'en': 'Unknown', 'ta': 'தெரியாது'};
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
                            'Book Time Slot',
                            style: AppTextStyles.heading2En.copyWith(color: Colors.white),
                          ),
                          Text(
                            'நேர இடைவெளியை முன்பதிவு செய்யுங்கள்',
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Selection
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 24, color: AppColors.primaryGreen),
                          const SizedBox(width: 8),
                          Text(
                            'Select Date',
                            style: AppTextStyles.heading3En,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'தேதியைத் தேர்ந்தெடுக்கவும்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 120, // Increased height from 100 to 120 to prevent overflow
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dates.length,
                          itemBuilder: (context, index) {
                            final date = dates[index];
                            final isSelected = selectedDate == date['id'];
                            
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = date['id']!;
                                  });
                                },
                                child: Container(
                                  width: 120, // Increased from 115 to 120
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Reduced padding
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primaryGreen : Colors.white,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primaryGreen.withOpacity(0.2),
                                              blurRadius: 6,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : [
                                            const BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        date['label']!,
                                        style: AppTextStyles.bodyBoldEn.copyWith(
                                          color: isSelected ? Colors.white : AppColors.textPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        date['tamilLabel']!,
                                        style: AppTextStyles.bodyTa.copyWith(
                                          color: isSelected ? Colors.white.withOpacity(0.9) : AppColors.textPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        date['date']!,
                                        style: AppTextStyles.captionEn.copyWith(
                                          color: isSelected ? Colors.white.withOpacity(0.85) : AppColors.textSecondary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Time Slots
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 24, color: AppColors.primaryGreen),
                          const SizedBox(width: 8),
                          Text(
                            'Available Time Slots',
                            style: AppTextStyles.heading3En,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'கிடைக்கக்கூடிய நேர இடைவெளிகள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),
                      
                      ...slots.map((slot) {
                        final statusInfo = _getStatusText(slot['status'], slot['slotsLeft']);
                        final isDisabled = slot['status'] == 'full';
                        final isSelected = selectedSlot == slot['id'];
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: isDisabled
                                ? null
                                : () {
                                    setState(() {
                                      selectedSlot = slot['id'];
                                    });
                                  },
                            child: Opacity(
                              opacity: isDisabled ? 0.5 : 1.0,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primaryGreen : Colors.white,
                                  border: Border.all(
                                    color: isSelected ? AppColors.primaryGreen : AppColors.borderColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                size: 24,
                                                color: isSelected ? Colors.white : AppColors.primaryGreen,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                slot['time'],
                                                style: AppTextStyles.bodyBoldEn.copyWith(
                                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 34),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 6),
                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: _getStatusColor(slot['status']),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        statusInfo['en']!,
                                                        style: AppTextStyles.bodyBoldEn.copyWith(
                                                          color: isSelected ? Colors.white : AppColors.textPrimary,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        statusInfo['ta']!,
                                                        style: AppTextStyles.bodyTa.copyWith(
                                                          color: isSelected ? Colors.white.withOpacity(0.9) : AppColors.textPrimary,
                                                          fontSize: 14,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        size: 32,
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomButton(context),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 2),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectedSlot != null
              ? () {
                  final dateItem = dates.firstWhere((d) => d['id'] == selectedDate);
                  final slotItem = slots.firstWhere((s) => s['id'] == selectedSlot);
                  
                  // Format: "Today, Jan 2, 2026"
                  final formattedDate = "${dateItem['label']}, ${dateItem['date']}, ${DateTime.now().year}";
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DigitalTokenScreen(
                        language: widget.language,
                        bookingDate: formattedDate,
                        bookingTime: slotItem['time'],
                      ),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedSlot != null ? AppColors.primaryOrange : AppColors.borderColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 64),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirm Slot & Get Token',
                style: AppTextStyles.buttonEn,
              ),
              Text(
                'இடைவெளியை உறுதிப்படுத்தவும்',
                style: AppTextStyles.buttonTa,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
