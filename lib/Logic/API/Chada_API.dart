import 'package:http/http.dart';
import 'dart:convert';

class Chada_API {
  Future Chada_Request(member_id, from_date, to_date) async {
    print('=====================================================');
    print('member id : $member_id');

    String url = 'http://someti.scanitltd.com/api/chada/collect/date/member';
    try {
     /* //todo must be deleted before deploy
      member_id = '01';
      from_date = '2019-10-01';
      to_date = '2019-10-30';
*/
      ///================>
      var response = await post(url, body: {
        'from_date': '$from_date',
        'to_date': '$to_date',
        'memberid': '$member_id',
      });
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
      print(e.toString());
    }
  }
}
