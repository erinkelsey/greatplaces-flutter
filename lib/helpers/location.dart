import 'dart:convert';

import 'package:http/http.dart' as http;

/// Google API Key that has all of the necessary Google Maps API services
/// enabled. Passed in as environment variable on build.
const GOOGLE_API_KEY = String.fromEnvironment('GOOGLE_API_KEY');

/// Helper class for managing location data with Google Maps API.
class LocationHelper {
  /// Generates a Google Maps image of location [latitude], [longitude].
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  /// Gets the human readable, full address of [latitude], [longitude].
  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';

    final response = await http.get(url);
    // print(json.decode(response.body));

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
