import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/venue.dart';
import '../services/venue_service.dart';

final venueFutureProvider = FutureProvider<List<Venue>>(
  (ref) async {
    return await VenueService().getVenues(60.170187, 24.930599);
  },
);

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
