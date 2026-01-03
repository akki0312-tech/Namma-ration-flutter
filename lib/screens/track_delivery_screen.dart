import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class TrackDeliveryScreen extends StatefulWidget {
  final String language;
  final String orderId;

  const TrackDeliveryScreen({
    super.key,
    required this.language,
    required this.orderId,
  });

  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                            'Track Delivery',
                            style: AppTextStyles.bodyBoldEn.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'டெலிவரியைக் கண்காணிக்கவும்',
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
                      // Tracking Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_shipping,
                              size: 32,
                              color: Color(0xFF6366F1),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${widget.orderId}',
                                  style: AppTextStyles.heading3En
                                      .copyWith(fontSize: 18),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Out for Delivery',
                                  style: AppTextStyles.bodyBoldEn.copyWith(
                                    color: const Color(0xFF6366F1),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tracking Map
                      Container(
                        height: 240,
                        width: double.infinity, // Ensure full width
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE8F4F0), Color(0xFFD4EDE4)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _animation.value,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF6366F1)
                                            .withOpacity(1.0 -
                                                (_controller.value * 0.5)),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Icon(
                              Icons.local_shipping,
                              size: 48,
                              color: Color(0xFF2D5F4F),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Delivery vehicle is 2.5 km away',
                                  style: AppTextStyles.bodyBoldEn
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Timeline
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          children: [
                            _buildTimelineItem(
                              'Order Confirmed',
                              'Sat, Jan 4 - 08:00 AM',
                              isCompleted: true,
                              isFirst: true,
                            ),
                            _buildTimelineItem(
                              'Items Packed at Shop',
                              'Sat, Jan 4 - 08:45 AM',
                              isCompleted: true,
                            ),
                            _buildTimelineItem(
                              'Out for Delivery',
                              'Sat, Jan 4 - 09:30 AM',
                              isActive: true,
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person,
                                        size: 16, color: Color(0xFF666666)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Agent: Rajesh Kumar',
                                      style: AppTextStyles.bodyEn
                                          .copyWith(fontSize: 12),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.phone,
                                        size: 16, color: Color(0xFF2D5F4F)),
                                  ],
                                ),
                              ),
                            ),
                            _buildTimelineItem(
                              'Delivered',
                              'ETA: 10:15 AM',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Delivery Route Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFFE0E0E0), width: 2),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.navigation,
                                    size: 20, color: Color(0xFF2D5F4F)),
                                const SizedBox(width: 8),
                                Text(
                                  'Route Progress / வழித்தட முன்னேற்றம்',
                                  style: AppTextStyles.bodyBoldEn.copyWith(
                                    fontSize: 14,
                                    color: const Color(0xFF2D5F4F),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _buildStatItem('8/30', 'Deliveries Completed'),
                                const SizedBox(width: 12),
                                _buildStatItem('22', 'Remaining'),
                                const SizedBox(width: 12),
                                _buildStatItem(
                                    '~45 min', 'ETA to Your Location'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Refresh Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Refresh logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.refresh, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Refresh Location / இடத்தைப் புதுப்பிக்கவும்',
                                style: AppTextStyles.buttonEn,
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

  Widget _buildTimelineItem(
    String title,
    String time, {
    bool isCompleted = false,
    bool isActive = false,
    bool isFirst = false,
    bool isLast = false,
    Widget? child,
  }) {
    Color dotColor = const Color(0xFFE0E0E0);
    if (isCompleted) dotColor = const Color(0xFF28A745);
    if (isActive) dotColor = const Color(0xFF6366F1);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: (isCompleted || isActive) && !isLast
                        ? (isCompleted
                            ? const Color(0xFF28A745)
                            : const Color(0xFF6366F1))
                        : const Color(0xFFE0E0E0),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyBoldEn.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: AppTextStyles.bodyEn.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF6C757D),
                    ),
                  ),
                  if (child != null) child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.heading3En.copyWith(
                fontSize: 20,
                color: const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.captionEn.copyWith(
                color: const Color(0xFF6C757D),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
