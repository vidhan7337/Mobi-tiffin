import 'dart:async';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Config/config.dart';
import 'Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (EcommerceApp.sharedPreferences.getString(EcommerceApp.language) ==
        "English") {
      _locale = Locale.fromSubtags(languageCode: 'en');
    } else if (EcommerceApp.sharedPreferences
            .getString(EcommerceApp.language) ==
        "Hindi") {
      _locale = Locale.fromSubtags(languageCode: 'hi');
    } else {
      Locale.fromSubtags(languageCode: 'gu');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Tiffin User App",
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('es', ''),
          const Locale('gu', ''),
          const Locale('hi', ''),
        ],
        locale: _locale,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.

          // When navigating to the "/second" route, build the SecondScreen widget.
          '/auth': (context) => AuthenticScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
        home: EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) !=
                null
            ? HomeScreen()
            : AuthenticScreen());
  }
}

// class MyApp extends StatelessWidget {
//   Locale _locale;

//       @override
//       Widget build(BuildContext context) {
//         return MaterialApp(
//           title: 'Tiffin User app',
//           localizationsDelegates: [
//             AppLocalizations.delegate, // Add this line
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: [
//             const Locale('en', ''), // English, no country code
//             const Locale('es', ''), // Spnanish, no country code
//           ],
//           locale: Locale('es', ''),
//           initialRoute: '/',
//           routes: {
//             // When navigating to the "/" route, build the FirstScreen widget.

//             // When navigating to the "/second" route, build the SecondScreen widget.
//             '/auth': (context) => AuthenticScreen(),
//           },
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: SplashScreen(),
//         );
//       }

// }

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Container(
//       decoration: new BoxDecoration(
//           gradient: new LinearGradient(
//         colors: [Colors.white, Colors.white],
//         begin: const FractionalOffset(0.0, 0.0),
//         end: const FractionalOffset(1.0, 0.0),
//         stops: [0.0, 1.0],
//         tileMode: TileMode.clamp,
//       )),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset("images/Untitled.png"),
//           ],
//         ),
//       ),
//     ));
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
