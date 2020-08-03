import 'package:flutter/foundation.dart';

/// Class for defining the Place location data.
class PlaceLocation {
  /// The latitude for this place.
  final double latitude;

  /// The longitude for this place.
  final double longitude;

  /// The human-readable fully formatted address of
  /// [latitude] and [longitude].
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
