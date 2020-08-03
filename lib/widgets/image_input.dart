import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

/// Widget for handling the image input for [Place] to add.
class ImageInput extends StatefulWidget {
  /// Function to be called when an image is selected.
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  /// File object for the stored image that was taken by the camera.
  File _storedImage;

  /// Opens up the camera on Android or iOS and waits until they take
  /// a picture. Once they have taken a picture, save the image to the
  /// local storage, show preview of image on add screen, by called
  /// passed in function [widget.onSelectImage].
  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600, // lower resolution -> app doesn't need hi-res
    );

    // if user presses back -> no image taken, therefore don't save
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    // copy file to local permanent storage
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: () => _takePicture(),
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
