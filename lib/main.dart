import 'package:flutter/material.dart';
import 'package:petty/provider/user.dart';
import 'package:petty/provider/vaccine_date_list.dart';
import 'package:petty/provider/vaccine_list.dart';
import 'package:petty/screen/home_page.dart';
import 'package:petty/provider/pet_list.dart';
import 'package:petty/screen/language_screen.dart';
import 'package:petty/screen/pet_detail_screen.dart';
import 'package:petty/screen/user_form_screen.dart';

import 'package:petty/shared/themes/app_colors.dart';
import 'package:petty/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PetList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Users(),
        ),
        ChangeNotifierProvider(
          create: (_) => VaccineList(),
        ),
        ChangeNotifierProvider(
          create: (_) => VaccineDateList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Petty',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
        ),
        routes: {
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.PET_DETAIL: (ctx) => PetDetailScreen(),
          AppRoutes.USER_FORM: (ctx) => UserFormScreen(),
          AppRoutes.LANGUAGE: (ctx) => LanguageScreen(),
        },
      ),
    );
  }
}
