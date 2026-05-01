import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  static const String formspreeId = 'mblnkzwa';
  static const String apiEndpoint = 'https://formspree.io/f/';

  Future<Map<String, dynamic>> sendMessage({
    required String name,
    required String email,
    required String message,
    required String subject,
  }) async {
    try {
      return await sendViaFormspree(
        name: name,
        email: email,
        message: message,
        subject: subject,
      );
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to send message: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> sendViaFormspree({
    required String name,
    required String email,
    required String message,
    required String subject,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/$formspreeId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'message': message,
          'about': subject,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Message sent successfully! I\'ll get back to you soon.',
        };
      } else {
        String errorMessage = 'Failed to send message. Please try again.';
        try {
          if (response.headers['content-type']?.contains('application/json') ??
              false) {
            final errorBody = jsonDecode(response.body);
            errorMessage = errorBody['error'] ?? errorMessage;
          }
        } catch (e) {
          return {'error': false, 'message': errorMessage};
        }
        return {'error': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'error': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
