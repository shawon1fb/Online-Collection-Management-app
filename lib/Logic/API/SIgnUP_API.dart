import 'package:http/http.dart';
import 'dart:convert';

class SignUP_API {
  Future SignUP_Request(member_id, password) async {
    print('=====================================================');
    print('member id : $member_id');
    print("password: $password");

    String url = 'http://someti.scanitltd.com/api/member/register';
    try {
      var response = await post(url,
          body: {'member_id': '$member_id', 'member_name': '$password'});
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print("responce : " + decodedData.toString());
        return decodedData;
      } else {
        print('Error :' + response.statusCode.toString());
      }
      //print(response.body);
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
