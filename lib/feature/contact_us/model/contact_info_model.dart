class ContactInfoModel {
  final String location;
  final String phone;
  final String email;
  final double lat;
  final double lng;

  ContactInfoModel({
    required this.location,
    required this.phone,
    required this.email,
    required this.lat,
    required this.lng,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      location: json['location'] ?? json['address'] ?? '119 شارع الملك فهد ، جدة ، المملكة العربية السعودية',
      phone: json['phone'] ?? '+966 054 87452',
      email: json['email'] ?? 'info@thimar.com',
      lat: double.tryParse(json['lat']?.toString() ?? '0.0') ?? 0.0,
      lng: double.tryParse(json['lng']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
