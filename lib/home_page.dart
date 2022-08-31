
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'display_weather.dart';
import 'services.dart';
import 'package:flutter/material.dart';
import 'model_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool loading = true;
  Services client = Services();
  WeatherModel? data;
  String city = "Mymensingh";
  final inputTextController = TextEditingController();
  late DateTime sunriseTime;
  late DateTime sunsetTime;

  Future<void>getData() async{
    data = await client.getWeatherData(city);
    sunriseTime = DateTime.fromMicrosecondsSinceEpoch(data!.sys.sunrise);
    sunsetTime = DateTime.fromMicrosecondsSinceEpoch(data!.sys.sunset);
  }


  @override
  void initState() {
    super.initState();
    getData();
    Timer(const Duration(seconds: 0), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Weather ",style: TextStyle(color: Colors.blue)),
              Text("City",style: TextStyle(color: Colors.black),)
            ],
          ),
          centerTitle: true,
        ),
        body: loading == true? Container(
          alignment: Alignment.center,
          child: const SpinKitPouringHourGlassRefined(color: Colors.grey, size: 80),
        ): SingleChildScrollView(
          child: FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done ){
                return Column(
                  children: [
                    weatherView(
                      //icon: Icons.sunny,
                      currentTemperature: "${(data!.main.temp-273.15).toStringAsFixed(2)} \u2103",
                      city: data!.name,
                      feelsLike: "${(data!.main.feelsLike-273.15).toStringAsFixed(2)} \u2103",
                      minTemperature: "${(data!.main.tempMin-273.15).toStringAsFixed(2)} \u2103",
                      maxTemperature:"${(data!.main.tempMax-273.15).toStringAsFixed(2)} \u2103",
                      humidity: "${data!.main.humidity} %",
                      country: data!.sys.country,
                      pressure: "${data!.main.pressure}",
                      sunrise: TimeOfDay.fromDateTime(sunriseTime).format(context),
                      sunset: TimeOfDay.fromDateTime(sunsetTime).format(context),
                      visibility: "${data!.visibility}",
                      windSpeed: "${data!.wind.speed} km/h",
                      weatherOverView: data!.weather[0].description,
                    ),
                    const SizedBox(height: 10,),
                    const Divider(thickness: 1,color: Colors.orange,),
                    SizedBox(
                      width:MediaQuery.of(context).size.width-50,
                      child: TextField(
                        textAlign: TextAlign.left,
                        style:const TextStyle(
                            fontSize: 18,
                            color: Colors.orange
                        ),
                        maxLength: 20,
                        controller: inputTextController,
                        cursorColor: Colors.orange,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: 'Enter a City Name',
                            labelStyle:TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.orange,
                            minimumSize: const Size.fromHeight(50.0)),
                        onPressed: (){
                          if(inputTextController.text.trim().isNotEmpty){
                            setState(() {
                              city = inputTextController.text.trim();
                            });
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Something Went wrong !",style: TextStyle(fontSize: 12.00, color: Colors.white),),
                              duration: Duration(milliseconds: 1500),
                              backgroundColor: Colors.red,
                            ));
                          }


                        },
                        icon: const Icon(Icons.spellcheck_outlined,size: 32),
                        label: const Text("Check"),
                      ),
                    )
                  ],
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: SpinKitRipple(color: Colors.grey, size: 80),
                ),
              );
            },
          ),
        )
      ),
    );
  }
}

