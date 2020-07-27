import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get time properties data
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);

      // get sign to subtract or add time
      String sign = data['utc_offset'].substring(0, 1);

      if (sign == "-") {
        now = now.subtract(
            Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
      } else {
        now = now.add(
            Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
      }

      // set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now).toString();
    } catch (e) {
      print(e);
      time = 'Could\'t get time data';
    }
  }
}
