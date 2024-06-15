import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:royal_falcon/view/home_screen/homescreen.dart';
import 'package:royal_falcon/view/login/login.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){

      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const Login() );

      case RoutesNames.home:
        return MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen() );

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