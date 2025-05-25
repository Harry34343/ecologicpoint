// The snippet below shows code for the activity file. To view the complete code sample,
// visit https://github.com/googlemaps-samples/android-samples/tree/main/ApiDemos/java.

// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdvancedMarkersDemoScreen extends StatefulWidget {
  const AdvancedMarkersDemoScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedMarkersDemoScreen> createState() =>
      _AdvancedMarkersDemoScreenState();
}

class _AdvancedMarkersDemoScreenState extends State<AdvancedMarkersDemoScreen> {
  static const LatLng singapore = LatLng(1.3521, 103.8198);
  static const LatLng kualaLumpur = LatLng(3.1390, 101.6869);
  static const LatLng jakarta = LatLng(-6.2088, 106.8456);
  static const LatLng bangkok = LatLng(13.7563, 100.5018);
  static const LatLng manila = LatLng(14.5995, 120.9842);
  static const LatLng hoChiMinhCity = LatLng(10.7769, 106.7009);

  static const double zoomLevel = 3.5;

  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.addAll([
      Marker(
        markerId: MarkerId('singapore'),
        position: singapore,
        infoWindow: InfoWindow(title: 'Singapore', snippet: 'Hello!'),
      ),
      Marker(
        markerId: MarkerId('kuala_lumpur'),
        position: kualaLumpur,
        infoWindow: InfoWindow(title: 'Kuala Lumpur'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueMagenta,
        ),
      ),
      Marker(
        markerId: MarkerId('jakarta'),
        position: jakarta,
        infoWindow: InfoWindow(title: 'Jakarta'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      Marker(
        markerId: MarkerId('bangkok'),
        position: bangkok,
        infoWindow: InfoWindow(title: 'Bangkok', snippet: 'A'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: MarkerId('manila'),
        position: manila,
        infoWindow: InfoWindow(title: 'Manila'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueMagenta,
        ),
      ),
      Marker(
        markerId: MarkerId('ho_chi_minh_city'),
        position: hoChiMinhCity,
        infoWindow: InfoWindow(title: 'Ho Chi Minh City'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Markers Demo')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: singapore,
          zoom: zoomLevel,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
