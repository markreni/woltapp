import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/venue.dart';
import '../services/venue_service.dart';

// Provider for listing venues when api response data is ready
final venueFutureProvider = FutureProvider<List<Venue>>(
  (ref) async {
    return await VenueService().getVenues(60.170187, 24.930599);
  },
);

// Provider for storing user's favorite venues
class VenueIdsNotifier extends StateNotifier<List<String>> {
  final SharedPreferences prefs;
  VenueIdsNotifier(this.prefs) : super([]);

  _initialize() async {
    if (prefs.containsKey("venues")) {
      state = prefs.getStringList("venues")!;
    }
  }

  updateFavorite(String id) async {
    final venues = state;
    if (!state.contains(id)) {
      state = [id, ...state];
    } else {
      venues.removeWhere((venueId) => venueId == id);
      state = [...venues];
    }
    prefs.setStringList("venues", state);
  }
}

final favoriteProvider =
    StateNotifierProvider<VenueIdsNotifier, List<String>>((ref) {
  final ids = VenueIdsNotifier(ref.watch(sharedPreferencesProvider));
  ids._initialize();
  return ids;
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
