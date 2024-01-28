import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/providers.dart';
import '../widgets/venue_card.dart';
import '../utils/helpers.dart' as helpers;

class VenueScreen extends ConsumerStatefulWidget {
  const VenueScreen({super.key});

  @override
  ConsumerState<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends ConsumerState<VenueScreen> {
  @override
  void initState() {
    super.initState();
    helpers.updateCoordinates(ref);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final venueFuture = ref.watch(venueFutureProvider);

    if (venueFuture.isLoading) {
      return Scaffold(
        body: Center(
          child: SpinKitFadingCircle(
            size: 160,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? const Color.fromARGB(199, 27, 141, 166)
                      : const Color.fromARGB(198, 42, 143, 166),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
            width: 90,
            height: 90,
            'assets/wolt_logo_white.png',
            fit: BoxFit.contain),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 76, 178, 225),
      ),
      body: GestureDetector(
        onDoubleTap: () => {
          helpers.updateScreen(ref),
        },
        child: venueFuture.when(
          loading: () => const Text(
            "Loading...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 35.0,
            ),
          ),
          error: (err, stack) => const Text(
            "Error loading venues",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 35.0),
          ),
          data: (venues) => ListView(
            children: venues
                .map((venue) => VenueCard(
                      name: venue.name,
                      description: venue.description,
                      imageURL: venue.imageURL,
                      id: venue.id,
                      distance: venue.distance,
                      rating: venue.rating,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
