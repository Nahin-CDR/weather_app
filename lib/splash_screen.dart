import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/home_page.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? storedData;
bool _noInternet = false;

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Timer(const Duration(seconds: 5), () async {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        } on SocketException catch (_) {
          setState(() {
            _noInternet = true;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  flex: 1,
                  child: Image(
                    image:const AssetImage("asset/clouds_splash.png"),
                    height: MediaQuery.of(context).size.height - 20,
                  )),
              Flexible(
                  flex: 2, child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                  Text("Weather",style: TextStyle(color: Colors.blue,fontSize: 30, fontWeight: FontWeight.bold),),
                  Text(" City",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight:FontWeight.bold),)
                ],
              )
              ),
              Flexible(
                flex: 2,
                child: _noInternet == true?
                SizedBox(
                    height: MediaQuery.of(context).size.height/2,
                    child: const Text("\nNo internet !",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20)))
                    :const SpinKitPouringHourGlassRefined(color: Colors.grey, size: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
