import 'package:doctorin/core/routes/app_routes_fun.dart';
import 'package:doctorin/core/routes/routes.dart';
import 'package:doctorin/core/utils/extensions.dart';
import 'package:doctorin/core/widgets/app_btn.dart';
import 'package:doctorin/core/widgets/general_item.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:doctorin/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/general.dart';

class LangWidget extends StatefulWidget {
  const LangWidget({super.key});

  @override
  State<LangWidget> createState() => _LangWidgetState();
}

class _LangWidgetState extends State<LangWidget> {
  // final cubit = sl<SettingCubit>();
  Future<String> localeLang(
    BuildContext context,
    int index,
    String locale,
  ) async {
    if (locale == 'ar') {
      await context.setLocale(const Locale('ar'));
    } else if (locale == 'en') {
      await context.setLocale(const Locale('en'));
    }
    // else {
    //   await context.setLocale(const Locale('ur'));
    // }
    return locale;
  }

  List<GeneralModel> langList = [
    GeneralModel(
      name: 'English',
      key: 'en',
      isSelected: LocaleKeys.lang.tr() == 'en' ? true : false,
    ),
    GeneralModel(
      name: 'عربى',
      key: 'ar',
      isSelected: LocaleKeys.lang.tr() == 'ar' ? true : false,
    ),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = langList.indexWhere((l) => l.isSelected);
    if (selectedIndex < 0) selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final hasBoundedHeight = c.maxHeight.isFinite;
        final list = ListView.separated(
          shrinkWrap: !hasBoundedHeight,
          physics: hasBoundedHeight ? null : const ClampingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 16.h),
          itemCount: langList.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) => GeneralItem(
            onTap: () async {
              for (int i = 0; i < langList.length; i++) {
                langList[i].isSelected = i == index;
              }
              selectedIndex = index;
              if (!Navigator.of(context).canPop()) {
                await localeLang(context, index, langList[index].key!);
              }
              await prefs.setString('lang', langList[index].key!);
              setState(() {});
            },
            isSelected: langList[index].isSelected,
            item: langList[index],
          ),
        );
        final button =
            // BlocConsumer<SettingCubit, SettingState>(
            //   bloc: cubit,
            //   listener: (context, state)  {
            //     // if (state.toggleState.isDone) {
            //     //    pushBack();
            //     //   final langKey = langList[selectedIndex].key;
            //     //    localeLang(context, selectedIndex, langKey!);
            //     //   Phoenix.rebirth(context);
            //     // }
            //   },
            // builder: (context, state) =>
            CustomButton(
              // isLoading: state.toggleState.isLoading,
              title: Navigator.of(context).canPop()
                  ? LocaleKeys.apply.tr()
                  : LocaleKeys.confirm.tr(),
              onTap: () async {
                if (Navigator.of(context).canPop()) {
                  // cubit.changeLang(langList[selectedIndex].key!);
                } else {
                  // await prefs.setBool('isFirst', false);
                  await pushAndRemoveUntil(NamedRoutes.login);
                }
                // },
              },
            ).withPadding(bottom: 10.h);
        // );
        if (hasBoundedHeight) {
          return Column(
            children: [
              Expanded(child: list),
              SafeArea(top: false, child: button),
            ],
          ).withPadding(top: 30.h);
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            list,
            SafeArea(top: false, child: button),
          ],
        ).withPadding(top: 30.h);
      },
    );
  }
}
