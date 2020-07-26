import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    // make the request
    Response response = await get('https://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    // set the local time property direcly given by world time
    time = data['datetime'];

    // // (ALTERNATIVE WAY) get properties from utc data and convert to local time
    // String datetime = data['utc_datetime'];
    // String offset1 = data['utc_offset'].substring(1, 3);
    // String offset2 = data['utc_offset'].substring(4, 6);

    // DateTime now = DateTime.parse(datetime);
    // now = now
    //     .add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
  }
}
