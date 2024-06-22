import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/routes/routes.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:royal_falcon/view/splash/splash_view.dart';
import 'package:royal_falcon/view_model/airport_animation_view_model.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/normal_booking_view_model.dart';
import 'package:royal_falcon/view_model/rides_animation_view_model.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => RidesAnimationViewModel()),
        ChangeNotifierProvider(create: (_) => CarViewModel()),
        ChangeNotifierProvider(create: (_) => AirportAnimationViewModel()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RFL',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
            onGenerateRoute: Routes.generateRoute,
            initialRoute: RoutesNames.splash,
          );
        },
      ),
    );
  }
}
