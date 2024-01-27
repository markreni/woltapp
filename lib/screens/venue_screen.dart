import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woltmobile2024/utils/coordinates.dart';
import 'dart:async';
import '../providers/providers.dart';
import '../widgets/venue_card.dart';

class VenueScreen extends ConsumerStatefulWidget {
  const VenueScreen({super.key});

  @override
  ConsumerState<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends ConsumerState<VenueScreen> {
  int counter = 0;
  @override
  void initState() {
    super.initState();
    // Timer for updating coordinates every 10sec
    Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) => {
              counter = (counter + 1) % coordinates.length,
              ref
                  .watch(locationProvider.notifier)
                  .update((state) => coordinates[counter])
            });
  }

  @override
  Widget build(BuildContext context) {
    final venueFuture = ref.watch(venueFutureProvider);

    if (venueFuture.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 35.0,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Wolt"),
        backgroundColor: const Color.fromARGB(255, 8, 196, 236),
        titleSpacing: 50,
        titleTextStyle: const TextStyle(fontSize: 30, fontFamily: 'Omnes'),
      ),
      body: Center(
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
                    id: venue.id))
                .toList(),
          ),
        ),
      ),
    );
  }
}
