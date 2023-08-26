import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
class location{


Future<String> getCurrentLocation() async {

  PermissionStatus permissionStatus = await Permission.location.request();
  
  if (permissionStatus.isGranted) {

  // Check if location services are enabled
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    await AppSettings.openLocationSettings();
  }

  // Get the current position (latitude and longitude)
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Get the address from coordinates
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  // Extract the city from the address
  if (placemarks.isNotEmpty) {
    String city = placemarks[0].administrativeArea ?? 'Unknown';
    return city;
  } throw Exception('Failed to load Location ');



  } else if (permissionStatus.isDenied) {
     throw Exception('Failed to get permission ');

  }


  throw Exception('Failed in get permission Status');





}







}