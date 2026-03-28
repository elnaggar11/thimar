import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/utils/app_theme.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class LocationPermissionDialog extends StatelessWidget {
  final Function()? onAllowLocation, onContinueWithout;
  const LocationPermissionDialog({
    super.key,
    this.onAllowLocation,
    this.onContinueWithout,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 15.h,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.primaryColorLight,
                  border: Border.all(
                    color: AppThemes.supportiveOrangeColor.color,
                    width: 3.w,
                  ),
                ),
                child: Icon(
                  Icons.priority_high_rounded,
                  color: AppThemes.supportiveOrangeColor.color,
                  size: 24.r,
                ),
              ),
              Text(
                LocaleKeys.locationIsRequired.tr(),
                style: context.boldText.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                LocaleKeys
                    .toReceiveNearbyPatientRequestsAndNavigateToClientLocationsPleaseAllowLocationAccess
                    .tr(),
                style: context.regularText,
                textAlign: TextAlign.center,
              ),
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CustomButton(
                      title: LocaleKeys.continueWithout.tr(),
                      onTap: () async {
                        await pushBack(false);
                        onContinueWithout?.call();
                      },
                      backgroundColor: context.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      textColor: context.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      title: LocaleKeys.allowLocation.tr(),
                      onTap: () async {
                        onAllowLocation?.call();
                        Navigator.pop(context, true);
                        await Geolocator.openAppSettings();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showLocationPermissionDialog(
  BuildContext context, {
  Function()? onAllowLocation,
  Function()? onContinueWithout,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => LocationPermissionDialog(
      onAllowLocation: onAllowLocation,
      onContinueWithout: onContinueWithout,
    ),
  );
}
