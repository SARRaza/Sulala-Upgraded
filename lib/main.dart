import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/widgets/pages/main_widgets/navigation_bar_reg_mode.dart';
import 'src/screens/reg_mode/notifications_list.dart';
import 'src/screens/reg_mode/reg_home_page.dart';
import 'src/screens/sign_up/create_password.dart';
import 'src/theme/colors/colors.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    globals.updateMediaQueryValues(context);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.grayscale00,
        bottomSheetTheme: const BottomSheetThemeData(
          dragHandleColor: AppColors.grayscale20,
          dragHandleSize: Size(40, 4),
        ),
      ),
      title: 'Sulala App',
      routes: {
        '/': (context) => const NavigationBarRegMode(),
        '/create_password': (context) => const CreatePassword(),
        '/reg_home_page': (context) => const HomeScreenRegMode(),
        '/notifications': (context) => NotificationList(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
