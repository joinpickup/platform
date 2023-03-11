import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/places/views/places_app_bar.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final _searchController = TextEditingController(text: "");
  Set<Marker> places = ({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PlacesAppBar(
          searchController: _searchController,
        ),
      ),
      body: SafeArea(
        child: PlatformMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.3326, 73.2073),
            zoom: 16.0,
          ),
          markers: places,
          mapType: MapType.satellite,
          compassEnabled: true,
        ),
      ),
    );
  }
}
