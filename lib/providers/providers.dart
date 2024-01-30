import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/venue.dart';
import '../services/venue_service.dart';
import '../utils/coordinates.dart';

// Provider for showing snackbar only when the user sees the venues screen for the first time
final infoProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final infoSeen = prefs.getBool('info') ?? false;
  ref.listenSelf((prev, cur) {
    prefs.setBool('info', cur);
  });
  return infoSeen;
});

// Provider for coordinates counter
final counterProvider = StateProvider<int>(
  (ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    final currentCounter = prefs.getInt('counter') ?? 0;
    return currentCounter;
  },
);

// Provider for listing venues when api response data is ready
final venueFutureProvider = FutureProvider<List<Venue>>(
  (ref) async {
    final counter = ref.watch(counterProvider);
    final location = locations[counter];
    return await VenueService().getVenues(location['lat']!, location['long']!);
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

// Provider for sharedPreferences
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
