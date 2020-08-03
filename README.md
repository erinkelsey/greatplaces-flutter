## About

A simple app for testing out the native device features using Flutter and Dart for iOS, Android. The features being tested out are the camera, offline storage (with SQLite), location, and maps.The app uses Google Maps API, so you will need a Google Cloud Platform account to obtain an API Key.

## Functionality

- Add a new place with a photo.
- Take a photo with the device camera.
- Add a title for the photo/location.
- Select either your current location, or pick your location from a map.
- Places are saved on device, so that they are persistent after app restarts.

## Install and Setup

You will need Flutter installed, along with a number of dependencies for building and running iOS and Android apps on simulators. You can find the install instructions here: https://flutter.dev/docs/get-started/install

## Setup

This implementation uses Google Maps API to generate Google Maps image of current location, and ability to pick location on a map. In order for this to work, you will need a Google Maps Static API Key. You will also need an active Google Cloud Platform account.

1. Create a new project

2. Go to the Google Maps service

3. Enable the following APIs:

- Maps Static API
- Places API
- Maps SDK for Android
- Maps SDK for iOS
- Geocoding API

4. Go to Credentials

5. Create a new API Key

### Android

Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:

    <manifest ...
    <application ...
      <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="YOUR KEY HERE"/>

### iOS

Specify your API key in the application delegate ios/Runner/AppDelegate.swift:

    import UIKit
    import Flutter
    import GoogleMaps

    @UIApplicationMain
    @objc class AppDelegate: FlutterAppDelegate {
      override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
        GMSServices.provideAPIKey("YOUR KEY HERE")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
    }

## Run

Run on a device (once it is connected):

    $ flutter run --dart-define=GOOGLE_API_KEY=[YOUR_GOOGLE_API_KEY]

## TODO

- Test cases
