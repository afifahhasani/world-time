import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;//location name for the UI
  String time; // time in that location
  String flag;//url to asset flag
  String url;// location url apii endpoint
  bool isDayTime;//true or flase if daytime or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {

    try{
      //make request
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours:int.parse(offset)));

      //set the time property
      isDayTime= now.hour>6 && now.hour<20 ? true: false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('caught eroor:$e');
      time='could not get time data';
    }





  }

}
