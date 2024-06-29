import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:royal_falcon/view/home_screen/homescreen.dart';
import 'package:royal_falcon/view/login/login.dart';
import 'package:royal_falcon/view/my_bookings/my_booking.dart';
import 'package:royal_falcon/view/rides/airport_bookings.dart';
import 'package:royal_falcon/view/rides/normal_bookings.dart';
import 'package:royal_falcon/view/rides/rides_booking_form.dart';

import '../../view/splash/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){

      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const Login() );

      case RoutesNames.home:
        return MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen() );

      case RoutesNames.splash:
        return MaterialPageRoute(builder: (BuildContext context)=> SplashScreen() );



      case RoutesNames.normalBookings:
        return MaterialPageRoute(builder: (BuildContext context)=>const NormalBookings() );

      case RoutesNames.airportBookings:
        return MaterialPageRoute(builder: (BuildContext context)=> AirportBookings() );

      case RoutesNames.myBookings:
        return MaterialPageRoute(builder: (BuildContext context)=> MyBookings() );

        default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text("No Route Defined",style: TextStyle(color: Colors.white),),
            ),
          );
        });
    }
  }
}