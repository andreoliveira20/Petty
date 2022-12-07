import 'package:flutter/material.dart';
import 'package:petty/core/shared/themes/app_theme.dart';
import 'package:petty/core/utils/app_routes.dart';
import 'package:petty/page/auth/auth_page.dart';
import 'package:petty/page/auth/userForm/user_form_page.dart';
import 'package:petty/page/home/home_page.dart';
import 'package:petty/page/language/language_page.dart';
import 'package:petty/page/petDetail/pet_detail_page.dart';
import 'package:petty/page/settings/controller/settings_controller.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Settings.instance,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme,
          themeMode: Settings.instance.themeMode,
          title: 'Petty',
          theme: AppTheme.lightTheme,
          routes: {
            AppRoutes.home: (context) => HomePage(),
            AppRoutes.petDetail: (context) => PetDetailPage(),
            AppRoutes.language: (context) => LanguagePage(),
            AppRoutes.auth: (context) => AuthPage(),
            AppRoutes.userForm: (context) => UserFormPage(),
          },
        );
      },
    );
  }
}
