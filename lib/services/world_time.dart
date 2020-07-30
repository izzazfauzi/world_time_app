import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the Ui
  String time; // the time in that location
  // String flag; // url to an asset flag icon
  dynamic list; // location url for api endpoint
  bool isDaytime; // true or false if daytime

  WorldTime({this.location, this.list});

  Future<void> defaultTime() async {
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/$list');
      Map data = jsonDecode(response.body);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      //print('$datetime - $offset');

      // create DateTime console
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 7 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }

  Future<void> getTime() async {
    try {
      // make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$list');
      Map data = jsonDecode(response.body);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      //print('$datetime - $offset');

      // create DateTime console
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 7 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
