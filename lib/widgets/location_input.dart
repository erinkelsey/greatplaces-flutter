import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location.dart';
import '../screens/map_screen.dart';

/// Widget for handling the location input for a [Place] object to add.
class LocationInput extends StatefulWidget {
  /// Function to call when a place is selected.
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  /// Google Maps API URL for the current location image shown in preview.
  String _previewImageUrl;

  /// Sets [_previewImageUrl] with current Google Maps API image for
  /// [latitude] and [longitude].
  void _showPreview(double latitude, double longitude) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  /// Gets the user's current location, and shows it on the screen preview.
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  /// Function that is called when a user has selected a place on the map.
  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: _previewImageUrl == null
            ? Text(
                'No Location Chosen',
                textAlign: TextAlign.center,
              )
            : Image.network(
                _previewImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _getCurrentUserLocation,
          ),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('Select on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _selectOnMap,
          ),
        ],
      ),
    ]);
  }
}
