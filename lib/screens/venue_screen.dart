import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import '../providers/providers.dart';
import '../widgets/venue_card.dart';
import '../utils/helpers.dart';
import '../utils/styles.dart';

class VenueScreen extends ConsumerStatefulWidget {
  const VenueScreen({super.key});

  @override
  ConsumerState<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends ConsumerState<VenueScreen> {
  final helpers = Helpers();

  @override
  void initState() {
    super.initState();
    helpers.updateCoordinates(ref);
  }

  @override
  void dispose() {
    super.dispose();
    helpers.cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    final venueFuture = ref.watch(venueFutureProvider);
    final height = MediaQuery.of(context).size.height;

    if (venueFuture.isLoading) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/wolt_logo_white.png',
                    width: height * 0.35,
                  ),
                ),
                SizedBox(height: height * 0.1),
                SpinKitFadingCircle(
                  size: height * 0.23,
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
              ],
            ),
          ),
        ),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => {
            if (!ref.read(infoProvider))
              {
                helpers.showInfoSnackBar(context, ref),
              }
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: max(height * 0.065, 40),
        title: Image.asset(
            width: max(height * 0.115, 70),
            'assets/wolt_logo_white.png',
            fit: BoxFit.contain),
        centerTitle: true,
        backgroundColor: CustomDesign().mainColor,
      ),
      body: GestureDetector(
        onDoubleTap: () => {
          helpers.updateScreen(ref),
        },
        child: venueFuture.when(
          loading: () => Text(
            "Loading...",
            style: CustomDesign().screenStyle,
          ),
          error: (err, stack) => Text(
            "Error loading venues",
            style: CustomDesign().screenStyle,
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
