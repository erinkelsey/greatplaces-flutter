import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/great_places.dart';
import '../models/place_location.dart';

/// Widget to build the screen where a user can add a [Place] object.
class AddPlaceScreen extends StatefulWidget {
  /// Route name for navigating to this screen.
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  /// Controller for the title text input.
  final _titleController = TextEditingController();

  /// The currently take image.
  File _pickedImage;

  /// The currently picked location.
  PlaceLocation _pickedLocation;

  /// Sets [pickedImage] to [_pickedImage]
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  /// Saves the title, image, and location as a new [Place].
  ///
  /// Saves only if the title, picked image, and picked location
  /// are not empty.
  ///
  /// Used the [GreatPlaces] provider to add save the new [Place]
  /// object to local storage on device.
  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) return;

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);

    Navigator.of(context).pop();
  }

  /// Functon used to set the [_pickedLocation] to a [PlaceLocation] object
  /// with [lat] and [lng] as coordinates.
  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    // add a form and validation
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
