import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class TelegramService {
  static const String _botToken = '8814327779:AAFOCJCCvZYIXQD_n1qrzjK_AzYUmBw9gIE';
  static const String _chatId = '7185524802';

  static Future<bool> sendContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {

    final text = '🔔 *New Portfolio Message*\n\n'
        '👤 *Name:* $name\n'
        '📧 *Email:* $email\n\n'
        '💬 *Message:*\n$message';

    try {
      final response = await http.post(
        Uri.parse('https://api.telegram.org/bot$_botToken/sendMessage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chat_id': _chatId,
          'text': text,
          'parse_mode': 'Markdown',
        }),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}