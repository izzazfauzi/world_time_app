import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<dynamic> list;

  // List<WorldTime> locations = [
  //   WorldTime(
  //       location: 'Malaysia',
  //       flag: 'malaysia.png',
  //       url: 'timezone/Asia/Kuala_Lumpur'),
  //   WorldTime(
  //       location: 'London',
  //       flag: 'united-kingdom.png',
  //       url: 'timezone/Europe/London'),
  //   WorldTime(
  //       location: 'Athens', flag: 'germany.png', url: 'timezone/Europe/Berlin'),
  //   WorldTime(
  //       location: 'Cairo', flag: 'egypt.png', url: 'timezone/Africa/Cairo'),
  //   WorldTime(
  //       location: 'Chicago', flag: 'usa.png', url: 'timezone/America/Chicago'),
  //   WorldTime(
  //       location: 'New York',
  //       flag: 'usa.png',
  //       url: 'timezone/America/New_York'),
  //   WorldTime(
  //       location: 'Seoul', flag: 'south-korea.png', url: 'timezone/Asia/Seoul'),
  //   WorldTime(
  //       location: 'Jakarta',
  //       flag: 'indonesia.png',
  //       url: 'timezone/Asia/Jakarta'),
  // ];

  Future<void> getLocation() async {
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone');
      list = jsonDecode(response.body);
    } catch (e) {
      print('caught error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void updateTime(index) async {
    WorldTime instance =
        WorldTime(location: '${list[index]}', list: '${list[index]}');
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      // 'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder<dynamic>(
        future: getLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(list);
            try {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          updateTime(index);
                        },
                        title: Text(list[index]),
                        // leading:
                        //     Image(image: AssetImage('assets/${locations[index].flag}')),
                      ),
                    ),
                  );
                },
              );
            } catch (e) {
              print(e);
              return Center(
                child: Text('Unable to connect'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
