import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/venue.dart';

class VenueService {
  final _endpoint = "https://restaurant-api.wolt.com/v1/pages/restaurants?";

  Future<List<Venue>> getVenues(double lat, double lon) async {
    final response = await http.get(
      Uri.parse("${_endpoint}lat=$lat&lon=$lon"),
    );
    final Map data = jsonDecode(response.body);
    final List items = data['sections'][1]['items'];
    final List firstItems = items.take(15).toList();
    final List<Venue> venues = List<Venue>.from(
      firstItems.map(
        (itemData) => Venue.fromJson(
          {
            'id': itemData['venue']['id'],
            'name': itemData['venue']['name'],
            'description': itemData['venue']['short_description'],
            'image': itemData['image']['url'],
            'distance': itemData['sorting']['sortables'][3]['value'],
            'rating': itemData['venue']['rating']['score']
          },
        ),
      ),
    );

    return venues;
  }
}
