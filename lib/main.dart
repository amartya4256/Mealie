import 'package:Mealie/FoodCategory/categoryScreenWidget.dart';
import 'package:Mealie/accounts/authScreen.dart';
import 'package:Mealie/accounts/signUpScreen.dart';
import 'package:Mealie/cart/cartScreen.dart';
import 'package:Mealie/home/homePageWidget.dart';
import 'package:Mealie/newFood/addFoodScreen.dart';
import 'package:Mealie/order/orderScreen.dart';
import 'package:Mealie/order/orderCompletedScreen.dart';
import 'package:Mealie/providers/cart.dart';
import 'package:Mealie/providers/favourites_provider.dart';
import 'package:Mealie/settings/settingsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavFoods(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Color(0xff800000),
          accentColor: Color(0xffc0c0c0),
          backgroundColor: Color(0xffeeeeee),
          canvasColor: Color(0xffeeeeee),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  color: Colors.white,
                ),
                subtitle2: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
                subtitle1: TextStyle(
                  color: Colors.black,
                  backgroundColor: Color(0xffeeeeee),
                  fontWeight: FontWeight.bold,
                ),
                headline1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                headline2: TextStyle(
                  color: Color(0xff800000),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                headline3: TextStyle(
                  color: Color(0xff800000),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          fontFamily: 'PTSans',
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                    body: Center(
                        child: Text(
                  "MEALIE",
                  style: Theme.of(context).textTheme.headline2,
                )));
              }
              if (userSnapshot.hasData) {
                return HomePage();
              }
              return AuthScreen();
            }),
        // initialRoute: '/',
        routes: {
          // '/': (context) => StreamBuilder(
          //     stream: FirebaseAuth.instance.onAuthStateChanged,
          //     builder: (ctx, userSnapshot) {
          //       if (userSnapshot.hasData) {
          //         return HomePage();
          //       }
          //       return AuthScreen();
          //     }),
          '/home': (context) => HomePage(),
          CategoryScreen.route: (context) => CategoryScreen(),
          SettingsScreen.route: (context) => SettingsScreen(),
          CartScreen.route: (context) => CartScreen(),
          AddFoodScreen.route: (context) => AddFoodScreen(),
          OrderScreen.route: (context) => OrderScreen(),
          OrderCompletedScreen.route: (context) => OrderCompletedScreen(),
          SignUpScreen.route: (context) => SignUpScreen(),
        },
        onUnknownRoute: (setting) {
          return MaterialPageRoute(builder: (ctx) => HomePage());
        },
      ),
    );
  }
}
