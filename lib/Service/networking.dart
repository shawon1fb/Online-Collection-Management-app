import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print("Network helper");
      print(response.statusCode);
      print(decodedData.toString());
      return decodedData;
    } else {
      print('Error :' + response.statusCode.toString());
    }
  }
}
