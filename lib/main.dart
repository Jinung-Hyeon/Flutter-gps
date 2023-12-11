import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SpeedometerApp(),
    );
  }
}

class SpeedometerApp extends StatefulWidget {
  const SpeedometerApp({super.key});

  @override
  State<SpeedometerApp> createState() => _SpeedometerAppState();
}

class _SpeedometerAppState extends State<SpeedometerApp> {
  Location location = Location();
  int _currentSpeed = 0;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  _initLocation() async {
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

    location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.accuracy != null && locationData.accuracy! < 20) {
        // 정확도가 20m 미만인 경우에만 업데이트
        setState(() {
          print(locationData);
          print(locationData.speed);
          _currentSpeed = (locationData.speed ?? 0.0).toInt();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speedometer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Current Speed:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_currentSpeed m/s',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
