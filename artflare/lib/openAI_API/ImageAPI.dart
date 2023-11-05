import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageAPI {
  final String apikey = 'Enter-Your-APIKEY';
  final String urla = 'https://api.openai.com/v1/images/generations';

  Future<String?> generateAIImage(String prompt) async {
    if (prompt.isNotEmpty) {
      var data = {
        "prompt": prompt,
        "n": 1,
        "size": "256x256",
      };

      var res = await http.post(Uri.parse(urla),
          headers: {
            "Authorization": "Bearer $apikey",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(res.body);

      return jsonResponse['data'][0]['url'];
    } else {
      print("Enter something");
      return null;
    }
  }

  Future<String?> createEditImage(
      File imageFile, File maskFile, String prompt) async {
    String url = "https://api.openai.com/v1/images/edits";

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['Authorization'] = 'Bearer $apikey'
      ..fields['prompt'] = prompt
      ..fields['n'] = '1'
      ..fields['size'] = '256x256'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path))
      ..files.add(await http.MultipartFile.fromPath('mask', maskFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      return jsonResponse['data'][0]['url'];
    } else {
      var errorData = await response.stream.bytesToString();
      print(
          "Error with status code: ${response.statusCode}, reason: ${response.reasonPhrase}, and body: $errorData");
      return null;
    }
  }
}
