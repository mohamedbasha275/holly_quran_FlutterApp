
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

void main() {
  getSalahTimes(Coordinates(26.16666666666, 32.716666666667));
  runApp(HomeApp());
}
void getSalahTimes(Coordinates coordinates){
  //print('Kushtia Prayer Times');
  //final myCoordinates = Coordinates(26.16666666666, 32.716666666667); // Replace with your own location lat, lng.
  final myCoordinates = coordinates; // Replace with your own location lat, lng.
  final params = CalculationMethod.egyptian.getParameters();
  params.madhab = Madhab.shafi;
  final prayerTimes = PrayerTimes.today(myCoordinates, params);

  print(
      "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
  print(DateFormat.jm().format(prayerTimes.fajr));
  print(prayerTimes.fajr);
  print(DateTime.now());
  print(DateFormat.jm().format(prayerTimes.sunrise));
  print(DateFormat.jm().format(prayerTimes.dhuhr));
  print(DateFormat.jm().format(prayerTimes.asr));
  print(DateFormat.jm().format(prayerTimes.maghrib));
  print(DateFormat.jm().format(prayerTimes.isha));

  // DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
  // DateTime dt2 = DateTime.parse("2018-09-12 10:57:00");
  //
  // Duration diff = dt1.difference(dt2);
}
class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  Future<void> _currentLocation() async {
    Location location = Location();
    // current location
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    Coordinates newCoordinates = Coordinates(_locationData.latitude!, _locationData.longitude!);
    getSalahTimes(newCoordinates);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: _currentLocation,
                //onPressed: (){},
                label: Text('my current place'),
                icon: Icon(Icons.location_on),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}