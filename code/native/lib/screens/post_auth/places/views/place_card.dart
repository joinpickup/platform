import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local/repos/data/models/location/place.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/discover/views/post_options/post_options_screen.dart';
import 'package:local/screens/post_auth/post/post_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          opacity = 0.6;
        });
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                PostScreen(postID: widget.place.placeID as int),
          ),
        );
      },
      onTapUp: (details) {
        setState(() {
          opacity = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          opacity = 1;
        });
      },
      onLongPress: () {
        HapticFeedback.heavyImpact();
        showPostOptionsModal(
          context,
        );
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostCardHeader(context, widget.place),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardContent(context, widget.place),
              const SizedBox(
                height: 8,
              ),
              _buildPostCardFooter(context, widget.place),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCardHeader(BuildContext context, Place place) {
    return Row(
      children: [
        // avatar
        const SizedBox(
          width: 8,
        ),
        // poster information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name
            // location / visbility
          ],
        )
      ],
    );
  }

  Widget _buildPostCardContent(BuildContext context, Place place) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildPostCardFooter(BuildContext context, Place place) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          format(place.createdAt),
          style: TextStyle(
            fontSize: 12,
            color: TW3Colors.gray.shade500,
          ),
        ),
      ],
    );
  }
}
