import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';
import 'base_api_services.dart';


class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try{
      final response = await  http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson= returnResponse(response);

    }on SocketException{
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try{
      final response = await  http.post(
          Uri.parse(url),body: data).timeout(
          const Duration(seconds: 15));
      responseJson= returnResponse(response);

    }on SocketException{
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }


  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 201:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 201:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw FetchDataException('Error occured during communication with server' + ' with status'+response.statusCode.toString());
    }
  }

}