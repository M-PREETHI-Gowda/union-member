import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:user_app/components/config.dart';
import 'package:http_parser/http_parser.dart';

class SingUpDao {
  Future singUp({
    required String salutiation,
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
    required String confirmPassword,
    String? profilePic
  }) async {
    var url = '${Config.url}/member/auth/sign-up';

    Map<String,dynamic> body = {
      "salutiation": salutiation,
      "first_name": firstName,
      "last_name": lastName,
      "mobile": mobile,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "profile_pic": profilePic,
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

  Future uploadImage({required File imagePath}) async {
    var url = '${Config.url}/member/auth/upload-image';

    try{
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        "Authorization" : "Bearer ${Config.accessToken}"
      });

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          await File.fromUri(Uri.parse(imagePath.path)).readAsBytes(),
          filename: 'image.jpg',
          contentType:  MediaType('image', 'jpg'),
        ),
      );

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Response status:${response.statusCode}');
      log('Response body:${response.body.toString()}');

      return response;

    }catch(error){
      log("The error of Upload Image : $error");
    }
  }

}