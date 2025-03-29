import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _currentLocation = const LatLng(-7.42139, 109.23444);
  final MapController _mapController = MapController();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
  }

  void _moveToPosition(LatLng target, [double zoom = 15.0]) {
    _mapController.move(target, zoom);
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showDialog(
          'Layanan Lokasi Dinonaktifkan',
          'Silakan aktifkan layanan lokasi di pengaturan perangkat.'
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showDialog(
            'Izin Lokasi Ditolak',
            'Anda perlu memberikan izin lokasi untuk menggunakan fitur ini.'
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showDialog(
          'Izin Lokasi Ditolak Permanen',
          'Anda telah menolak izin lokasi secara permanen. Silakan ubah di pengaturan aplikasi.'
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newLocation = LatLng(position.latitude, position.longitude);
      
      setState(() {
        _currentLocation = newLocation;
      });

      if (_isMapReady) {
        _moveToPosition(newLocation);
      }
    } catch (e) {
      _showDialog('Kesalahan', e.toString());
      if (_isMapReady) {
        _moveToPosition(const LatLng(-6.2088, 106.8456));
      }
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Lokasi'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_mapController.camera.center);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 15.0,
              minZoom: 4.0,
              maxZoom: 18.0,
              onMapReady: () {
                if (!_isMapReady) {
                  _isMapReady = true;
                  Future.delayed(const Duration(milliseconds: 500), () {
                    _moveToPosition(_currentLocation);
                  });
                }
              },
              interactionOptions: const InteractionOptions(
                flags: ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Center(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 50,
            ),
          ),

          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}