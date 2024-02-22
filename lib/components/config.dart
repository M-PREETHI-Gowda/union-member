import 'dart:io';

class Config{
  static String accessToken = "";
  static String url = 'http://13.127.193.213/api';
  static String firstName = "";
  static String lastName = "";
  static String profilePic = "";

  static Map<String, String> headers(){
    return {
      HttpHeaders.contentTypeHeader : "application/json",
    };
  }
  static Map<String, String> authHeaders() {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization" : "Bearer $accessToken"
    };
  }
}