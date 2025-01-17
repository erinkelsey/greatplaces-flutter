import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place_location.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location.dart';

/// Provider for managing the [Place] class.
class GreatPlaces with ChangeNotifier {
  /// All of the [Place] items on the device.
  List<Place> _items = [];

  /// Returns a list of [Place] items on the device.
  List<Place> get items {
    return [..._items];
  }

  /// Adds a [Place] item on the device, and stores the info
  /// in the local SQLite DB.
  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  /// Fetches and loads all of the [Place] items saved to this device
  /// into memory, so able to display them.
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item[
                'image']), // create file based on path -> load file into memory
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  /// Returns the [Place] object with [id].
  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
