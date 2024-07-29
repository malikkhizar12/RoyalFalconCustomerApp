import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/routes/routes.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:royal_falcon/view/splash/splash_view.dart';
import 'package:royal_falcon/view_model/airport_animation_view_model.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/hourly_card_view_model.dart';
import 'package:royal_falcon/view_model/map_view_model.dart';
import 'package:royal_falcon/view_model/my_bookings_view_model.dart';
import 'package:royal_falcon/view_model/normal_booking_view_model.dart';
import 'package:royal_falcon/view_model/profile_screen_view_model.dart';
import 'package:royal_falcon/view_model/rides_animation_view_model.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/driver_booking_model.dart';
import 'model/my_bookings_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.instance;
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
  await Stripe.instance.applySettings();
  await Hive.initFlutter();

  // Register the adapters
  Hive.registerAdapter(BookingsAdapter());
  Hive.registerAdapter(GuestAdapter());
  Hive.registerAdapter(CoordinatesAdapter());
  Hive.registerAdapter(VehicleCategoryAdapter());
  Hive.registerAdapter(DriverBookingDataAdapter());
  Hive.registerAdapter(MyDriverBookingAdapter());
  Hive.registerAdapter(DriverGuestAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(PaginationAdapter());

  await Hive.openBox<DriverBookingData>('driverBookingDataBox');

  await Hive.openBox<Bookings>('bookingsBox');
  await Hive.openBox('vehicleCategoriesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => VehicleCardViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => RidesAnimationViewModel()),
        ChangeNotifierProvider(create: (_) => CarViewModel()),
        ChangeNotifierProvider(create: (_) => AirportAnimationViewModel()),
        ChangeNotifierProvider(create: (_) => VehicleViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileScreenViewModel()),
        ChangeNotifierProvider(create: (_) => MapsViewModel()),
        ChangeNotifierProvider(
            create: (_) => MyBookingsViewModel()), // Add this line
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
