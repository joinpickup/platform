import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/screens/post_auth/core/places_screen/places_app_bar.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PlacesScreen extends HookWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: "");
    final places = useState<Set<Marker>>({});

    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PlacesAppbar(
          searchController: searchController,
        ),
      ),
      body: SafeArea(
        child: PlatformMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.3326, 73.2073),
            zoom: 16.0,
          ),
          markers: places.value,
          polygons: {
            Polygon(
              fillColor: Colors.blue,
              points: [
                LatLng(41.3326, 73.2073),
              ],
              polygonId: PolygonId("test"),
            ),
          },
          mapType: MapType.satellite,
          compassEnabled: true,
          onMapCreated: (controller) async {
            await addPlaces(places, context);
          },
        ),
      ),
    );
  }
}

Future addPlaces(
    ValueNotifier<Set<Marker>> places, BuildContext context) async {
  BitmapDescriptor icon =
      await _bitmapDescriptorFromSvgAsset(context, "assets/pin.svg");
  Marker place = Marker(
    markerId: MarkerId('marker_1'),
    position: const LatLng(41.3326, 73.2073),
    consumeTapEvents: true,
    infoWindow: const InfoWindow(
      title: 'PlatformMarker',
      snippet: "Hi I'm a Platform Marker",
    ),
    icon: icon,
    onTap: () {
      print("Marker tapped");
    },
  );

  places.value.add(place);
}

Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName) async {
  // Read SVG file as String
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  // Create DrawableRoot from SVG String
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "123");

  // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;
  double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
  double height = 32 * devicePixelRatio; // same thing

  // Convert to ui.Picture
  ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

  // Convert to ui.Image. toImage() takes width and height as parameters
  // you need to find the best size to suit your needs and take into account the
  // screen DPI
  ui.Image image = await picture.toImage(width.round(), height.round());
  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}
