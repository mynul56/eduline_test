import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  var timeoutDuration = const Duration(seconds: 20);

  @override
  Future getGetApiResponse({required String url}) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeoutDuration);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Server Connection");
    } catch (error) {
      print(error.toString());
      return "Error Found";
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        final responseData = jsonDecode(response.body);
        String responsemessage = responseData['message'];
        throw InvalidInputRequest(
          responsemessage + response.statusCode.toString(),
        );
      case 400:
        final responseData = jsonDecode(response.body);
        String responsemessage = responseData['message'];
        throw BadRequestException(
          responsemessage + response.statusCode.toString(),
        );
      case 403:
        final responseData = jsonDecode(response.body);
        String responsemessage = responseData['message'];
        throw responsemessage + response.statusCode.toString();
      case 405:
        final responseData = jsonDecode(response.body);
        String responsemessage = responseData['message'];
        throw responsemessage + response.statusCode.toString();
      default:
        final responseData = jsonDecode(response.body);
        String responsemessage = responseData['message'];

        throw FetchDataException("$responsemessage ${responseData.toString()}");
    }
  }
}
