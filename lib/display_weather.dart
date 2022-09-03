import 'package:flutter/material.dart';

Widget weatherView({
// IconData icon,
  required String currentTemperature,
  required String city,
  required String feelsLike,
  required String minTemperature,
  required String maxTemperature,
  required String humidity,
  required String country,
  required String sunrise,
  required String sunset,
  required String visibility,
  required String windSpeed,
  required String pressure,
  required String weatherOverView,
}){
  return Container(
    alignment: Alignment.bottomLeft,
    margin:const EdgeInsets.only(left: 20,top: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 100,
              margin:const EdgeInsets.only(left: 10),
              child:  Image.asset(
                'asset/could.gif',
                width: 200,
                height: 150,
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
              ),
            ),
            Flexible(
              child: Text(
                  weatherOverView,
                  style:const
                  TextStyle(
                    fontSize: 25,
                    color: Colors.black12,
                  )
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0,),
        Text(currentTemperature,
            style:const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(25, 19, 66, 1.0)
            )
        ),
        Text("Feels Like : $feelsLike",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        Text("$city , $country",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        //Text("Minimum Temperature : $minTemperature",style:const TextStyle(fontSize: 15,color: Colors.grey)),
       // Text("Minimum Temperature : $maxTemperature",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        Text("Humidity : $humidity",style:const TextStyle(fontSize: 15,color: Colors.grey)),
       // Text("Sunrise : $sunrise",style:const TextStyle(fontSize: 15,color: Colors.grey)),
       // Text("Sunset : $sunset",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        Text("Visibility : $visibility m",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        Text("Wind speed : $windSpeed ",style:const TextStyle(fontSize: 15,color: Colors.grey)),
        Text("Pressure : $pressure hPa",style:const TextStyle(fontSize: 15,color: Colors.grey)),
      ],
    ),
  );
}