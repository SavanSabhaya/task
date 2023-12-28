import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/api_service/api_constant.dart';
import 'package:task/utils/logger_util.dart';

class ApiRepository {


  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final Uri url = Uri.parse('${ApiConstant.baseUrl}$endpoint');
    logger.d('url===>$url');
    logger.d('params===>$data');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('get response==${response.body}');
        return jsonDecode(response.body);
      } else {
        // Handle error, you can throw an exception or return an error response
        throw Exception('Failed to post data');
      }
    } catch (e) {
      // Handle network or other errors
      throw Exception('Failed to connect to the server');
    }
  }


  Future<Map<String, dynamic>> postMultipartData(String endpoint, Map<String, dynamic> data) async {
    final Uri url = Uri.parse('${ApiConstant.baseUrl}$endpoint');
     logger.d('url===>$url');
    logger.d('params===>$data');

    try {
      var request = http.MultipartRequest('POST', url);
        request.fields['username'] = data['email'];
        request.fields['password'] = data['password'];
        request.headers['Content-Type'] = 'multipart/form-data';


      var response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(await response.stream.bytesToString());
        return data;
      } else {
        throw Exception('Failed to upload data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
