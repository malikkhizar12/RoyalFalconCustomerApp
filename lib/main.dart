import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/routes/routes.dart';
import 'package:royal_falcon/view/login/login.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';

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
      ],
      child: ScreenUtilInit(
        designSize:const Size(430,932),
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
            home: AnimatedSplashScreen(
              splash: 'images/splashIcon.png',
              nextScreen: const Login(),
              centered: true,
              backgroundColor: Colors.black,
              duration: 3000,
              splashIconSize: 1000,
            ),
            onGenerateRoute: Routes.generateRoute,
            // initialRoute: RoutesNames.login,
          );
        },
      ),
    );
  }
}
