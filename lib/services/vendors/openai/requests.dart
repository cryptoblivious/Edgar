import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:async';

String apiKey = dotenv.env['OPENAI_API_KEY']!;
String modelEndpoint = 'https://api.openai.com/v1/chat/completions';

Stream<String> getCompletionStream(String prompt) async* {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  var body = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'user', 'content': prompt}
    ],
    'temperature': 0.7,
  };

  var response = await http.post(Uri.parse(modelEndpoint), headers: headers, body: jsonEncode(body));

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    var choices = responseBody['choices'] as List<dynamic>;
    for (final choice in choices) {
      var completion = choice['message']['content'] as String;
      yield completion;
    }
  } else {
    throw Exception('Failed to make API request');
  }
}
