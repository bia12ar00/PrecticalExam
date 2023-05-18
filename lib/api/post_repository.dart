import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practical_exam/Models/otp_data_model.dart';
import 'package:practical_exam/Models/otp_verify_model.dart';
import 'package:practical_exam/Models/welcome_data_model.dart';
import 'package:practical_exam/Preference.dart';
import 'package:practical_exam/api/api.dart';

class PostRepository {
  API api = API();

  Future<OtpDataModel?> sendOtpData(Map<String, String> data) async {
    try {
      Response response = await api.sendRequest.post(
        "/sendotp.php",
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: FormData.fromMap(data),
      );

      if (response.statusCode == 200) {
        print(response.data);
        print(jsonDecode(response.data));
        return OtpDataModel.fromJson(jsonDecode(response.data));
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  Future<OtpVerifyModel?> sendOtpVerifyData(Map<String, String> data) async {
    try {
      Response response = await api.sendRequest.post(
        "/verifyotp.php",
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.data);
        print(jsonDecode(response.data));
        return OtpVerifyModel.fromJson(jsonDecode(response.data));
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  Future<WelcomeDataModel?> sendWelcomeData(Map<String, String> data) async {
    final String token = Preference().getString(Preference.token);
    try {
      Response response = await api.sendRequest.post(
        "/profilesubmit.php",
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {
              "Content-Type": "application/json",
              "Token": token,
            }),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.data);
        print(jsonDecode(response.data));
        return WelcomeDataModel.fromJson(jsonDecode(response.data));
      } 
    } catch (ex) {
      return null;
    }
    return null;
  }
}
