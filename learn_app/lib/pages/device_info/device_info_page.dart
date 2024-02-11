import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  var battery = Battery();
  var batteryLevel = 0;
  var appVersion = "";
  var appName = "";
  var buildNumber = "";
  var packageName = "";
  var deviceName = "Unknown Device";
  var networkType = "Unknown";
  var geolocation = "Unknown";

  Future<void> getBatteryLevel() async {
    try {
      batteryLevel = await battery.batteryLevel;
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {});
  }

  Future<void> openExternalLink() async {
    await launchUrl(Uri.parse("https://www.google.com"));
  }

  Future<void> shareExternalLink() async {
    await Share.share("Looks this link! https://www.google.com");
  }

  Future<void> getNetworkStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      networkType = "Mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      networkType = "Wifi";
    } else {
      networkType = "Unknown";
    }

    setState(() {});
  }

  Future<void> getAppData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    appName = packageInfo.appName;
    buildNumber = packageInfo.buildNumber;
    packageName = packageInfo.packageName;

    setState(() {});
  }

  Future<void> getDeviceData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
    }
    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getGeolocation() async {
    try {
      Position position = await _determinePosition();
      geolocation = "Lat: ${position.latitude}, Long: ${position.longitude}";
    } catch (e) {
      geolocation = "Unknown";
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBatteryLevel();
    getAppData();
    getDeviceData();
    getNetworkStatus();
    getGeolocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Device Info"),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    const Text("Battery Info"),
                    const SizedBox(
                      height: 16,
                    ),
                    CircularPercentIndicator(
                      radius: 24.0,
                      lineWidth: 10.0,
                      percent: batteryLevel / 100,
                      center: Text("${batteryLevel.toString()}%"),
                      progressColor: Colors.green,
                    )
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: openExternalLink,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Open External Link")
                  ],
                )),
            TextButton(
                onPressed: shareExternalLink,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Share External Link")
                  ],
                )),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const Text("App Info",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            Text("App Version: $appVersion",
                style: const TextStyle(fontSize: 14)),
            Text("App Name: $appName", style: const TextStyle(fontSize: 14)),
            Text("Build Number: $buildNumber",
                style: const TextStyle(fontSize: 14)),
            Text("Package Name: $packageName",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const Text("Device Info",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            Text("Device Name: $deviceName",
                style: const TextStyle(fontSize: 14)),
            Text("Connection: $networkType",
                style: const TextStyle(fontSize: 14)),
            Text("User Location $geolocation",
                style: const TextStyle(fontSize: 14)),
          ],
        ));
  }
}
