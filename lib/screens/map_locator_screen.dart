import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class MapLocatorScreen extends StatefulWidget {
  final String language;

  const MapLocatorScreen({super.key, required this.language});

  @override
  State<MapLocatorScreen> createState() => _MapLocatorScreenState();
}

class _MapLocatorScreenState extends State<MapLocatorScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isLoading = true;
  Set<Marker> _markers = {};
  List<Map<String, dynamic>> _shops = [];

  // Using the API Key provided by user
  final String _apiKey = 'AIzaSyBElGwzZ4vmeqxF57lcn9k7RX2ey6MGk-4';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    bool serviceEnabled;
    LocationPermission permission;

    // 0. Debug Log
    debugPrint('LOCATION: Starting _getCurrentLocation');

    // 1. Check if service is enabled
    debugPrint('LOCATION: Checking service status...');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint('LOCATION: Service enabled: $serviceEnabled');

    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    // 2. Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')),
          );
        }
        setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Location permissions are permanently denied.')),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    // 3. Get position with specific settings for Web
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      setState(() {
        _currentPosition = position;
      });

      // Move camera to user location
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
        ),
      );

      // Fetch nearby shops
      await _fetchNearbyShops(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('Error getting location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _fetchNearbyShops(double lat, double lng) async {
    debugPrint('PLACES: Fetching nearby shops (Text Search API)...');

    // Places API (New) - Text Search
    // This is better for "Ration Shop" because it's a specific term, not just a category.
    const url = 'https://places.googleapis.com/v1/places:searchText';

    // Request Body
    // Request Body
    final body = jsonEncode({
      "textQuery": "Fair Price Shop Ration Shop",
      "maxResultCount": 20,
      "locationBias": {
        "circle": {
          "center": {"latitude": lat, "longitude": lng},
          "radius": 10000.0
        }
      }
    });

    // Headers
    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': _apiKey,
      'X-Goog-FieldMask':
          'places.id,places.displayName,places.formattedAddress,places.location,places.regularOpeningHours,places.rating'
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      debugPrint('PLACES: Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['places'] as List?;

        if (results == null || results.isEmpty) {
          debugPrint('PLACES: No results found.');
          setState(() {
            _shops = []; // Clear previous if any
            _markers = {};
          });
          return;
        }

        List<Map<String, dynamic>> loadedShops = [];
        Set<Marker> newMarkers = {};

        for (var place in results) {
          final location = place['location'];
          final placeLat = location['latitude'] as double;
          final placeLng = location['longitude'] as double;

          final name = place['displayName']?['text'] ?? 'Unknown Shop';
          final address = place['formattedAddress'] ?? '';

          // Check opening status (simplified)
          final isOpen = place['regularOpeningHours']?['openNow'] ?? false;

          final rating = place['rating']?.toString() ?? 'N/A';
          final placeId = place['id'];

          // Add shop data
          loadedShops.add({
            'id': placeId,
            'name': name,
            'address': address,
            'lat': placeLat,
            'lng': placeLng,
            'status': isOpen ? 'Open' : 'Closed',
            'rating': rating,
            'isRegistered':
                true, // Assume mostly registered given the specific query
          });

          // Add marker
          newMarkers.add(
            Marker(
              markerId: MarkerId(placeId),
              position: LatLng(placeLat, placeLng),
              infoWindow: InfoWindow(
                title: name,
                snippet: address,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen, // Green for registered
              ),
            ),
          );
        }

        setState(() {
          _shops = loadedShops;
          _markers = newMarkers;
        });
        debugPrint(
            'PLACES: Loaded ${_shops.length} shops using Text Search API');
      } else {
        debugPrint('PLACES: Request failed: ${response.body}');
        if (mounted) {
          final error = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'API Error: ${error['error']['message'] ?? 'Unknown'}')),
          );
        }
      }
    } catch (e) {
      debugPrint('PLACES: Exception: $e');
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
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 28),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find Nearby Shops',
                            style: AppTextStyles.heading2En
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            'அருகிலுள்ள கடைகளைக் கண்டறியவும்',
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
                      // Map View
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: const CameraPosition(
                                  target: LatLng(
                                      13.0827, 80.2707), // Default Chennai
                                  zoom: 12.0,
                                ),
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                markers: _markers,
                                onMapCreated: (controller) {
                                  _mapController = controller;
                                  if (_currentPosition != null) {
                                    _mapController?.moveCamera(
                                      CameraUpdate.newLatLng(
                                        LatLng(_currentPosition!.latitude,
                                            _currentPosition!.longitude),
                                      ),
                                    );
                                  }
                                },
                              ),
                              if (_isLoading)
                                Container(
                                  color: Colors.white.withOpacity(0.8),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Your Location Status
                      if (_currentPosition != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F4FD),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    const Color(0xFF6366F1).withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.my_location,
                                  color: Color(0xFF6366F1)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Showing shops near your location',
                                  style: AppTextStyles.bodyBoldEn.copyWith(
                                    color: const Color(0xFF6366F1),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Shops List Header
                      Text(
                        'Nearby Fair Price Shops',
                        style: AppTextStyles.heading3En,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'அருகிலுள்ள நியாய விலைக் கடைகள்',
                        style: AppTextStyles.heading3Ta,
                      ),
                      const SizedBox(height: 16),

                      // Shops Data
                      if (_shops.isEmpty && !_isLoading)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Icon(Icons.search_off,
                                    size: 48, color: Colors.grey),
                                const SizedBox(height: 12),
                                Text(
                                  _currentPosition == null
                                      ? 'Waiting for location...'
                                      : 'No shops found nearby.',
                                  style: AppTextStyles.bodyEn
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ..._shops.map((shop) {
                          // Calculate real distance
                          String distance = 'N/A';
                          if (_currentPosition != null) {
                            double distInMeters = Geolocator.distanceBetween(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                              shop['lat'],
                              shop['lng'],
                            );
                            distance =
                                '${(distInMeters / 1000).toStringAsFixed(1)} km';
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildShopCard(context, shop, distance),
                          );
                        }),

                      if (_shops.isEmpty && _isLoading)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        )
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

  Widget _buildShopCard(
      BuildContext context, Map<String, dynamic> shop, String distance) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: shop['isRegistered']
              ? AppColors.primaryGreen
              : AppColors.borderColor,
          width: shop['isRegistered'] ? 2 : 1,
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store,
                            size: 24, color: AppColors.primaryGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            shop['name'],
                            style:
                                AppTextStyles.bodyBoldEn.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      shop['address'],
                      style: AppTextStyles.bodyEn.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.directions_walk,
                            size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(
                          '$distance away',
                          style: AppTextStyles.bodyBoldEn.copyWith(
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        if (shop['rating'] != 'N/A') ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            shop['rating'],
                            style: AppTextStyles.bodyEn.copyWith(fontSize: 13),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (shop['isRegistered'])
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.15),
                        border: Border.all(
                            color: AppColors.primaryGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Registered',
                        style: AppTextStyles.captionEn.copyWith(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: shop['status'] == 'Open'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      shop['status'],
                      style: AppTextStyles.captionEn.copyWith(
                        color: shop['status'] == 'Open'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Check Stock',
                        style: AppTextStyles.buttonEn.copyWith(fontSize: 16),
                      ),
                      Text(
                        'இருப்பைச் சரிபார்க்கவும்',
                        style: AppTextStyles.buttonTa.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
