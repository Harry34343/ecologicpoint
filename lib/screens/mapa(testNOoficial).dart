import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async'; // Necesario para Completer

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Google Maps', home: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Posición inicial de la cámara
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.422, -122.084), // Coordenadas de Mountain View, CA
    zoom: 14.0,
  );

  // Opcional: Para agregar marcadores
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Puedes agregar marcadores aquí si lo deseas
    _markers.add(
      const Marker(
        markerId: MarkerId('miUbicacion'),
        position: LatLng(37.422, -122.084),
        infoWindow: InfoWindow(title: 'Mi ubicación de ejemplo'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Mapa Flutter')),
      body: GoogleMap(
        mapType:
            MapType
                .normal, // Puedes cambiar el tipo de mapa (satellite, hybrid, terrain)
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers, // Agrega tus marcadores
        // Otras propiedades del mapa
        // myLocationEnabled: true, // Para mostrar la ubicación actual del usuario
        // myLocationButtonEnabled: true, // Para mostrar un botón de centrar en la ubicación del usuario
      ),
    );
  }
}
