import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const kGoogleAPIKey = 'AIzaSyDKmJWt7BPojonxt3_m1AtJtX8PIBasFeA';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng accra = const LatLng(5.614818, -0.205874);

  LocationData? _locationData;
  Location location = Location();
  LatLng? currentPostion;

  //   Permissions   //

  permissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  //   Initial Position Created After Map Created
  _getInitialUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(locationSettings: const LocationSettings());

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
    print(currentPostion);
    return currentPostion;
  }

  @override
  void initState() {
    permissions();
    _getInitialUserLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aerial mapping of seedlings',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: accra, zoom: 12),
        myLocationEnabled: true,
      ),
    );
  }
}
