import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'homescreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Scaffold(body: MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    CheckInternet();
  }

  @override
  Widget build(BuildContext context) {

   
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromRGBO(2, 227, 235, 1),
          Color.fromARGB(255, 1, 85, 100)
        ], radius: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: LottieBuilder.asset("assets/bus.json",
              repeat: true,
              animate: true,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text("CHEYYAR BUS", style: TextStyle(fontSize: 32, color: Colors.white),),
          LottieBuilder.asset("assets/loading.json",
          repeat: true,
          animate: true,)
        ],
        ),
      
    );
  }

  void CheckInternet() async {
    final listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          Timer(
              const Duration(seconds: 5),
              () =>
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeApp())));
          break;

        case InternetStatus.disconnected:
          // The internet is now disconnected
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Please check your Internet Connection"),
              action: SnackBarAction(
                  textColor: Colors.amber,
                  label: "Retry",
                  onPressed: () {
                    CheckInternet();
                  })));
          break;
      }
    });
  }
}
