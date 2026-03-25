import 'dart:async';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class LocationService {
  CustomPosition? position;
  Completer<CustomPosition>? _locationCompleter;

  /// Get current location once
  Future<CustomPosition> getCurrentLocation() async {
    if (_locationCompleter != null && !_locationCompleter!.isCompleted) {
      return _locationCompleter!.future;
    }
    _locationCompleter = Completer<CustomPosition>();

    // 1. Check & Force Location Service (GPS)
    await enableLocationService();

    LocationPermission status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }

    if (status == LocationPermission.denied ||
        status == LocationPermission.deniedForever) {
      return CustomPosition(
        status: status,
        msg: "Location permission denied",
        success: false,
      );
    }

    position = CustomPosition(
      status: status,
      msg: "",
      success: true,
      position: await Geolocator.getCurrentPosition(),
    );
    if (position?.position != null) {
      final address = await getAddressFromLatLng(position: position!.position);
      position = position?.copyWith(address: address);
    }
    _locationCompleter?.complete(position);
    _locationCompleter = null;
    return position!;
  }

  /// Get live location as a Position stream
  Stream<Position> getLiveLocationStream({
    required LocationAccuracy accuracy,
    required int distanceFilter,
  }) async* {
    var status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }

    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      yield* Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: accuracy,
          distanceFilter: distanceFilter, // Update every 5 meters
        ),
      );
    } else {
      log("Location permission denied for live stream");
    }
  }

  /// Get live location as LatLng stream
  Stream<LatLng> getLiveLatLngStream({
    LocationAccuracy accuracy = LocationAccuracy.bestForNavigation,
    int distanceFilter = 2,
  }) => getLiveLocationStream(
    accuracy: accuracy,
    distanceFilter: distanceFilter,
  ).map((pos) => LatLng(pos.latitude, pos.longitude));

  /// Convert coordinates to address
  Future<String> getAddressFromLatLng({
    Position? position,
    LatLng? latLng,
  }) async {
    try {
      double lat, lng;
      if (position == null && latLng == null) {
        throw "you position or latLng mustn't be null";
      } else {
        lat = position?.latitude ?? latLng!.latitude;
        lng = position?.longitude ?? latLng!.longitude;
      }
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks[0];
        return "${placemark.street}, ${placemark.locality}, ${placemark.country}";
      } else {
        return "";
      }
    } catch (e) {
      log("$e");
      return "";
    }
  }

  /// Calculate distance between two points (in KM)
  double getDistanceBetween({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    final distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );
    return distanceInMeters / 1000; // بالكيلومتر
  }

  Future<void> enableLocationService() async {
    loc.Location location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    while (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Stream<ServiceStatus> get serviceStatusStream =>
      Geolocator.getServiceStatusStream();
}

class CustomPosition {
  final Position? position;
  final String msg;
  final bool success;
  final LocationPermission status;
  final String? address;

  CustomPosition({
    required this.status,
    required this.msg,
    required this.success,
    this.address,
    this.position,
  });

  CustomPosition copyWith({
    Position? position,
    String? msg,
    bool? success,
    LocationPermission? status,
    String? address,
  }) => CustomPosition(
    address: address ?? this.address,
    position: position ?? this.position,
    msg: msg ?? this.msg,
    success: success ?? this.success,
    status: status ?? this.status,
  );
}
