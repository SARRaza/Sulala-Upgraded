import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/screens/splash_screen.dart/splash_screen.dart';
import 'src/data/locale_strings.dart';
import 'src/screens/reg_mode/notifications_list.dart';
import 'src/screens/reg_mode/reg_home_page.dart';
import 'src/screens/sign_up/create_password.dart';
import 'src/theme/colors/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.grayscale00,
        bottomSheetTheme: const BottomSheetThemeData(
          dragHandleColor: AppColors.grayscale20,
          dragHandleSize: Size(40, 4),
        ),
      ),
      title: 'Sulala App',
      translations: LocalStrings(),
      locale: const Locale('en', 'US'),
      routes: {
        '/': (context) => const SplashScreen(),
        '/create_password': (context) => const CreatePassword(),
        '/reg_home_page': (context) => const HomeScreenRegMode(),
        '/notifications': (context) => const NotificationList(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
