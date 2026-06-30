import 'package:get_it/get_it.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/feature/about/cubit/about_cubit.dart';
import 'package:thimar/feature/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:thimar/feature/auth/login/cubit/login_cubit.dart';
import 'package:thimar/feature/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:thimar/feature/auth/verify/cubit/verify_cubit.dart';
import 'package:thimar/feature/complaints_and_suggestions/cubit/complaints_and_suggestions_cubit.dart';
import 'package:thimar/feature/layout/cubit/layout_cubit.dart';
import 'package:thimar/feature/splash/cubit/splash_cubit.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';
import 'package:thimar/feature/favorites/cubit/favorites_cubit.dart';
import 'package:thimar/feature/profile/cubit/profile_cubit.dart';
import 'package:thimar/feature/personal_info/cubit/personal_info_cubit.dart';
import 'package:thimar/feature/notifications/cubit/notifications_cubit.dart';
import 'package:thimar/feature/auth/reset_password/cubit/reset_password_cubit.dart';

import 'package:thimar/feature/home/cubit/home_cubit.dart';
import 'package:thimar/feature/product_details/cubit/product_details_cubit.dart';
import 'package:thimar/feature/contact_us/cubit/contact_us_cubit.dart';
import 'package:thimar/feature/faqs/cubit/faqs_cubit.dart';
import 'package:thimar/feature/policy/cubit/policy_cubit.dart';
import 'package:thimar/feature/terms/cubit/terms_cubit.dart';
import 'package:thimar/feature/cart/cubit/cart_cubit.dart';
import 'package:thimar/feature/addresses/cubit/addresses_cubit.dart';
import 'package:thimar/feature/wallet/cubit/wallet_cubit.dart';
import 'package:thimar/feature/cards/cubit/cards_cubit.dart';
import 'package:thimar/feature/rate_products/cubit/rate_products_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(() => LocationService());
    sl.registerFactory(() => SplashCubit());
    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(() => SignUpCubit());
    sl.registerFactory(() => ForgetPasswordCubit());
    sl.registerFactory(() => LayoutCubit());
    sl.registerFactory(() => HomeCubit());
    sl.registerFactory(() => OrdersCubit());
    sl.registerLazySingleton(() => FavoritesCubit());
    sl.registerFactory(() => ProfileCubit());
    sl.registerFactory(() => NotificationsCubit());
    sl.registerFactory(() => ProductDetailsCubit());
    sl.registerFactory(() => FaqsCubit());
    sl.registerFactory(() => ComplaintsAndSuggestionsCubit());
    sl.registerFactory(() => VerifyCubit());
    sl.registerFactory(() => ResetPasswordCubit());
    sl.registerFactory(() => AboutCubit());
    sl.registerFactory(() => PersonalInfoCubit());
    sl.registerFactory(() => PolicyCubit());
    sl.registerFactory(() => TermsCubit());
    sl.registerFactory(() => ContactUsCubit());
    sl.registerFactory(() => CartCubit());
    sl.registerFactory(() => AddressesCubit());
    sl.registerFactory(() => WalletCubit());
    sl.registerFactory(() => CardsCubit());
    sl.registerFactory(() => RateProductsCubit());
  }
}
