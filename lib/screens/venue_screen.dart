import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../widgets/venue_card.dart';

class VenueScreen extends ConsumerWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
