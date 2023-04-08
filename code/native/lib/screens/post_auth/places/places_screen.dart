import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/repos/data/mocks/location.dart';
import 'package:local/repos/data/models/location/place.dart';
import 'package:local/screens/post_auth/places/views/place_feed.dart';
import 'package:local/screens/post_auth/places/views/places_app_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

enum PlacesScreenType { list, map }

class _PlacesScreenState extends State<PlacesScreen> {
  bool list = true;
  List<Place> places = [
    Place(
      location: eastRock,
      name: "Gather East Rock",
      createdAt: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TW3Colors.gray.shade700,
        floatingActionButtonLocation:
            list ? null : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            setState(() {
              list = !list;
            });
          },
          child: list
              ? const HeroIcon(HeroIcons.map)
              : const HeroIcon(HeroIcons.listBullet),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const PlacesAppBar(),
              list
                  ? PlaceList(
                      places: places,
                    )
                  : const PlaceMap(),
            ],
          ),
        ));
  }
}

class PlaceList extends StatelessWidget {
  const PlaceList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return PlaceFeed(
      canRefresh: false,
      canLoad: false,
      onRefresh: () {},
      onLoad: () {},
      refreshController: RefreshController(),
      scrollController: ScrollController(),
      places: places,
    );
  }
}

class PlaceMap extends StatefulWidget {
  const PlaceMap({
    super.key,
  });

  @override
  State<PlaceMap> createState() => _PlaceMapState();
}

class _PlaceMapState extends State<PlaceMap> {
  MapboxMapController? controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MapboxMap(
        accessToken: const String.fromEnvironment("ACCESS_TOKEN"),
        styleString: "mapbox://styles/joinpickup/cle7dbtal001501lbz3t96fpv",
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.3068, -72.9271),
          zoom: 14.0,
        ),
        onMapClick: (point, coordinates) {},
        onStyleLoadedCallback: () {
          controller!.addCircle(
            const CircleOptions(
              geometry: LatLng(41.3068, -72.9271),
              circleColor: "#FF0000",
            ),
          );
        },
        onMapCreated: (cont) {
          setState(() {
            controller = cont;
          });
        },
      ),
    );
  }
}
