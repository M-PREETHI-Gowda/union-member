import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:user_app/components/config.dart';

class ProfileDao {
  Future fetchProfile() async {
    var url = '${Config.url}/member/profile/view';

    final response = await http.get(
      Uri.parse(url),
      headers: Config.authHeaders(),
    );
    log("Response Status Code : ${response.statusCode}");
    log("Response body : ${response.body}");
    return response;
  }
}