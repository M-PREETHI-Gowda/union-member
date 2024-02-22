import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:user_app/components/config.dart';

class LoginDao {
  Future login({required String memberId, required String password}) async {
    var url = '${Config.url}/member/auth/login';

    Map<String,dynamic> body = {
      "member_id": memberId,
      "password": password
    };

    final response = await http.post(
        Uri.parse(url),
        headers: Config.headers(),
        body: jsonEncode(body)
    );

    log("Response Status Code : ${response.statusCode}");
    log("Response body : ${response.body}");

    return response;
  }

}