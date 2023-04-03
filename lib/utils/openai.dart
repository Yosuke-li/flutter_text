import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAI {
  static const String _baseUrl = 'https://api.openai.com/v1/';

  static Future<Map<String, dynamic>> getCompletion(
      String prompt, String model, int maxTokens) async {
    final response = await http.post(
      Uri.parse(_baseUrl + 'engines/$model/completions'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${YOUR_API_KEY}',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': maxTokens,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get completion');
    }
  }
}