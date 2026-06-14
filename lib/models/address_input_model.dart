import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'address_model.dart';
import 'city_model.dart';
import 'district_model.dart';

class AddressInputModel {
  String? id;
  LatLng? latLng;
  String? location;

  final titleController = TextEditingController();
  final streetController = TextEditingController();
  CityModel? selectedCity;
  DistrictModel? selectedDistrict;
  bool isDefault = false;
  AddressInputModel();

  AddressInputModel.fromModel(AddressModel model) {
    id = model.id;
    latLng = LatLng(model.lat, model.lng);
    location = model.location;
    titleController.text = model.title;
    streetController.text = model.street;
    selectedCity = model.city;
    selectedDistrict = model.district;
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_method': "PUT",
    'title': titleController.text.trim(),
    'city_id': selectedCity?.id,
    'district_id': selectedDistrict?.id,
    'street': streetController.text.trim(),
    'location': location,
    'lat': latLng?.latitude,
    'lng': latLng?.longitude,
    'is_default': isDefault ? 1 : 0,
  };
}
