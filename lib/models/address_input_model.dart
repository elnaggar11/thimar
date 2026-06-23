import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'address_model.dart';

class AddressInputModel {
  String? id;
  LatLng? latLng;
  String? location;

  final typeController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isDefault = false;

  AddressInputModel();

  AddressInputModel.fromModel(AddressModel model) {
    id = model.id;
    latLng = LatLng(model.lat, model.lng);
    location = model.location;
    typeController.text = model.type;
    phoneController.text = model.phone;
    descriptionController.text = model.description;
    isDefault = model.isDefault;
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_method': "PUT",
    'type': typeController.text.trim(),
    'phone': phoneController.text.trim(),
    'description': descriptionController.text.trim(),
    'location': location,
    'lat': latLng?.latitude,
    'lng': latLng?.longitude,
    'is_default': isDefault ? 1 : 0,
  };
}
