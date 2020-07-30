import 'package:http/http.dart';
import 'dart:convert';

class ListLocation {
  List data;

  ListLocation({this.data});
  void getLocation() async {
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone');
      data = jsonDecode(response.body);
    } catch (e) {
      print('caught error: $e');
    }
  }
}
