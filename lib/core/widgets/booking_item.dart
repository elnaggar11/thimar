import 'package:doctorin/core/routes/app_routes_fun.dart';
import 'package:doctorin/core/routes/routes.dart';
import 'package:doctorin/core/utils/enums.dart';
import 'package:doctorin/core/utils/extensions.dart';
import 'package:doctorin/core/widgets/app_btn.dart';
import 'package:doctorin/core/widgets/booking_type_container.dart';
import 'package:doctorin/core/widgets/custom_image.dart';
import 'package:doctorin/core/widgets/status_widget.dart';
import 'package:doctorin/data/models/booking.dart';
import 'package:doctorin/gen/assets.gen.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:doctorin/presentation/bookings/view/widget/contact_icon.dart';
import 'package:doctorin/presentation/bookings/view/widget/date_box.dart';
import 'package:doctorin/presentation/bookings/view/widget/patient_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingItem extends StatelessWidget {
  final BookingItemType type;
  final BookingModel data;
  final VoidCallback? onAccept, onReject;

  const BookingItem({
    super.key,
    required this.type,
    required this.data,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BookingItemType.newBookingRequest:
        return _NewBookingItem(
          data: data,
          onAccept: onAccept,
          onReject: onReject,
        );

      case BookingItemType.upcomingBooking:
        return _UpcomingBookingItem(data: data);

      case BookingItemType.myBookings:
        return _NormalBookingItem(data: data);

      case BookingItemType.calendarBooking:
        return _CalendarBookingItem(data: data);
    }
  }
}

abstract class BookingItemBase extends StatelessWidget {
  final BookingModel data;
  final BookingItemType type;

  const BookingItemBase({super.key, required this.data, required this.type});
  Widget buildStatus(BuildContext context) =>
      StatusWidget(status: data.status, statusTrans: data.status);
  Widget buildArriveInfo(BuildContext context) => const SizedBox.shrink();

  Widget buildMainRow(BuildContext context) => Row(
    spacing: 10.w,
    children: [
      Expanded(
        child: PatientRow(
          data: data,
          type: type,
          trailing: Row(
            spacing: 5.w,
            children: [
              if (!['pending', 'completed', 'canceled'].contains(data.status))
                if (data.phoneNumber != null)
                  ContactIcon(
                    phoneNumber: data.phoneNumber!,
                    icon: Assets.svg.call,
                    bgColor: context.borderColor,
                  ),
              if (!['pending', 'completed', 'canceled'].contains(data.status))
                ContactIcon(
                  icon: Assets.svg.chat,
                  bgColor: context.borderColor,
                ),

            ],
          ),
        ),
      ),
    ],
  );

  Widget buildActions(BuildContext context) => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    final middleWidgets = type == BookingItemType.myBookings
        ? <Widget>[
            buildMainRow(context),
            DateBox(type: type, dateText: data.dateText),
          ]
        : <Widget>[
            DateBox(type: type, dateText: data.dateText),
            buildArriveInfo(context),
            buildMainRow(context),
          ];
    return InkWell(
      onTap: () => push(
        NamedRoutes.bookingDetailsScreen,
        arg: {'id': data.id, 'data': data},
      ),
      child: Container(
        width: type == BookingItemType.myBookings ? null : context.w * 0.9,
        padding: EdgeInsets.all(12.r),
        margin: type == BookingItemType.myBookings
            ? null
            : EdgeInsets.symmetric(horizontal: 8.r),
        decoration: BoxDecoration(
          color: type == BookingItemType.calendarBooking
              ? context.scaffoldBackgroundColor
              : type == BookingItemType.myBookings
              ? null
              : context.borderColor.withValues(alpha: 0.5),
          borderRadius: type == BookingItemType.myBookings
              ? null
              : BorderRadius.circular(12.r),
          border: Border.all(color: context.borderColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Row(
              spacing: 5.w,
              children: [
                Text(
                  '# ${data.id.split('-').first}',
                  style: context.mediumText.copyWith(
                    fontSize: 16,
                    color: context.hintColor,
                  ),
                ),
                const Spacer(),
                BookingTypeContainer(type: data.type),
                buildStatus(context),
              ],
            ),
            ...middleWidgets,
            buildActions(context),
          ],
        ),
      ),
    );
  }
}

class _NewBookingItem extends BookingItemBase {
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  const _NewBookingItem({
    required super.data,
    super.type = BookingItemType.newBookingRequest,
    this.onAccept,
    this.onReject,
  });
  @override
  Widget buildStatus(BuildContext context) => SizedBox.shrink();
  @override
  Widget buildMainRow(BuildContext context) {
    return Row(
      spacing: 10.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PatientRow(data: data, type: type),
        ),
        Row(
          spacing: 5.w,
          children: [
            CustomImage(Assets.svg.routing, fit: BoxFit.cover),
            Text('${data.distanceKm}', style: context.semiboldText),
            Text(
              '${LocaleKeys.km.tr()} - ',
              style: context.semiboldText.copyWith(color: context.hintColor),
            ),
            Text('${data.durationMin}', style: context.semiboldText),
            Text(
              LocaleKeys.minute.tr(),
              style: context.semiboldText.copyWith(color: context.hintColor),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildActions(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: CustomButton(
            onTap: onAccept ?? () {},
            child: Row(
              spacing: 5.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_rounded, color: context.primaryColorLight),
                Text(
                  LocaleKeys.accept.tr(),
                  style: context.semiboldText.copyWith(
                    color: context.primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomButton(
            onTap: onReject ?? () {},
            textColor: context.errorColor,
            backgroundColor: context.errorColor.withValues(alpha: 0.05),
            child: Row(
              spacing: 5.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.close, color: context.errorColor),
                Text(
                  LocaleKeys.reject.tr(),
                  style: context.semiboldText.copyWith(
                    color: context.errorColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UpcomingBookingItem extends BookingItemBase {
  const _UpcomingBookingItem({
    required super.data,
    super.type = BookingItemType.upcomingBooking,
  });

  @override
  Widget buildArriveInfo(BuildContext context) {
    if (data.timeToStart == null) return const SizedBox.shrink();
    return Text(
      LocaleKeys.youHaveMinToStart.tr(args: [data.timeToStart ?? '']),
      style: context.regularText.copyWith(
        fontSize: 13,
        color: context.hintColor,
      ),
    );
  }
}

class _NormalBookingItem extends BookingItemBase {
  const _NormalBookingItem({
    required super.data,
    super.type = BookingItemType.myBookings,
  });

  @override
  Widget buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.price.tr(),
              style: context.regularText.copyWith(color: context.hintColor),
            ),
            Row(
              spacing: 2.w,
              children: [
                Text(
                  data.price.toString(),
                  style: context.boldText.copyWith(fontSize: 30),
                ),
                Text(
                  strutStyle: StrutStyle(fontSize: 25),
                  'EGP',
                  style: context.mediumText,
                ),
              ],
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: context.primaryColor.withValues(alpha: 0.1),
          child: Icon(
            Icons.arrow_forward,
            color: context.primaryColor,
            size: 18.h,
          ),
        ),
      ],
    );
  }
}

class _CalendarBookingItem extends BookingItemBase {
  const _CalendarBookingItem({
    required super.data,
    super.type = BookingItemType.calendarBooking,
  });

  @override
  Widget buildMainRow(BuildContext context) {
    return PatientRow(data: data, type: type);
  }

  @override
  Widget buildActions(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Icon(Icons.access_time_rounded, color: context.hintColor, size: 18.r),
        Text(
          '${data.appointmentHour.toString()}:00 - ${data.appointmentHour + 1}:00 ${data.appointmentHour >= 12 ? "pm" : "am"} (${'1 hour'})',
          style: context.mediumText.copyWith(color: context.hintColor),
        ),
      ],
    );
  }
}
