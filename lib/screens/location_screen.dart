import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Failed", "Please turn on your Location",
          backgroundColor: Color.fromARGB(255, 227, 97, 41).withOpacity(0.1));
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Color(0xFFE36129),
        title: Text(
          'Current Location',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 227, 97, 41),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentPosition();
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.location_on_sharp,
          size: 27,
          color: Color.fromARGB(255, 227, 97, 41),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Center(),
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.15,
                width: width * 0.35,
                child: Image.asset(
                  "Assets/images/location_logo.png",
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Padding(
              padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0.0, 0.75), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Text(
                        "LAT:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        " ${_currentPosition?.latitude ?? ""}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 227, 97, 41),
                            // fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "LONG:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "${_currentPosition?.longitude ?? ""}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 227, 97, 41),
                            // fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "ADDRESS:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "${_currentAddress ?? ""}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 227, 97, 41),
                            // fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )),
          Flexible(
            child: Center(),
            flex: 2,
          ),
        ],
      )),
    );
  }
}
