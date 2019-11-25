import 'package:http/http.dart';
import 'dart:convert';

class LoginApi {
  Future Login_Request(member_id, password) async {
    print('=====================================================');
    print('member id : $member_id');
    print("password: $password");

    String url = 'http://someti.scanitltd.com/api/member/login';
    try {
      /*  //todo have to delete next 2 line
      member_id = '01';
      password = '123456';*/
      var response = await post(url,
          body: {'member_id': '$member_id', 'password': '$password'});
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
      print("<================= Login execption  ====================>");
      //return e.toString();
      print(e.toString());
    }
  }
}
