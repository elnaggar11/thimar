import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/addresses/cubit/addresses_cubit.dart';
import 'package:thimar/models/address_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class AddAddressView extends StatefulWidget {
  final AddressModel? address;
  const AddAddressView({super.key, this.address});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final _cubit = sl<AddressesCubit>();

  // ignore: unused_field
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(
    24.7136,
    46.6753,
  ); // Default to Riyadh
  String _selectedType = 'المنزل'; // Default type

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _selectedType = widget.address!.type.isNotEmpty
          ? widget.address!.type
          : 'المنزل';
      _cubit.phoneController.text = widget.address!.phone;
      _cubit.descController.text = widget.address!.description;
      _selectedLocation = LatLng(widget.address!.lat, widget.address!.lng);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onAdd() async {
    if (_cubit.phoneController.text.isEmpty) {
      // Simple validation, ideally show toast
      return;
    }

    bool success;
    if (widget.address == null) {
      success = await _cubit.addAddress(
        type: _selectedType,
        phone: _cubit.phoneController.text,
        description: _cubit.descController.text,
        lat: _selectedLocation.latitude,
        lng: _selectedLocation.longitude,
      );
    } else {
      success = await _cubit.updateAddress(
        id: widget.address!.id,
        type: _selectedType,
        phone: _cubit.phoneController.text,
        description: _cubit.descController.text,
        lat: _selectedLocation.latitude,
        lng: _selectedLocation.longitude,
      );
    }

    if (success && mounted) {
      Navigator.pop(context, true); // Return true to refresh list
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.address == null
        ? LocaleKeys.addAddress.tr()
        : LocaleKeys.updateAddress.tr();
    return Scaffold(
      appBar: MainAppBar(title: title, isTitleCentered: true),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 14,
            ),
            onMapCreated: (controller) => _mapController = controller,
            onCameraMove: (position) {
              _selectedLocation = position.target;
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
          // Center Marker
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Icon(
                Icons.location_on,
                size: 50.sp,
                color: context.primaryColor,
              ),
            ),
          ),
          // Bottom Sheet Overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        LocaleKeys.addressType.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 16.sp,
                          color: context.primaryColor,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      _buildTypeButton('المنزل'),
                      SizedBox(width: 8.w),
                      _buildTypeButton('العمل'),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    controller: _cubit.phoneController,
                    hintText: LocaleKeys.enterPhoneNumber.tr(),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  AppField(
                    controller: _cubit.descController,
                    hintText: LocaleKeys.description.tr(),
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    title: widget.address == null
                        ? LocaleKeys.addAddress.tr()
                        : LocaleKeys.updateAddress.tr(),
                    backgroundColor: context.primaryColor,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: _onAdd,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String title) {
    final isSelected = _selectedType == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.hintColor.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          title,
          style: context.semiboldText.copyWith(
            fontSize: 14.sp,
            color: isSelected ? Colors.white : context.primaryColor,
          ),
        ),
      ),
    );
  }
}
