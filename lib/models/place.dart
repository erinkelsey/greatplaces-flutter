import 'dart:io';

import 'package:flutter/foundation.dart';

import './place_location.dart';

/// Class for defining the components of a [Place] object.
class Place {
  /// The id for this place.
  final String id;

  /// The title for this place.
  final String title;

  /// The [PlaceLocation] associated with this place.
  final PlaceLocation location;

  /// The image for this place. Image is take by camera on native device.
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
