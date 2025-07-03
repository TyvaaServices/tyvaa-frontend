import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }

  static String get cinetpayApiKey => dotenv.env['CINETPAY_API_KEY'] ?? '';
  static int get cinetpaySiteId =>
      int.tryParse(dotenv.env['CINETPAY_SITE_ID'] ?? '0') ?? 0;
  static String get cinetpayNotifyUrl =>
      dotenv.env['CINETPAY_NOTIFY_URL'] ?? '';

  static String get appEnvironment => dotenv.env['APP_ENV'] ?? 'development';

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  static bool get isProduction => appEnvironment == 'production';
  static bool get isDevelopment => appEnvironment == 'development';
  static bool get isStaging => appEnvironment == 'staging';

  static bool get isConfigured {
    return cinetpayApiKey.isNotEmpty &&
        cinetpaySiteId > 0 &&
        cinetpayNotifyUrl.isNotEmpty;
  }

  static List<String> get configurationErrors {
    final errors = <String>[];

    if (cinetpayApiKey.isEmpty) {
      errors.add('CINETPAY_API_KEY is not set in .env file');
    }

    if (cinetpaySiteId == 0) {
      errors.add('CINETPAY_SITE_ID is not set or invalid in .env file');
    }

    if (cinetpayNotifyUrl.isEmpty) {
      errors.add('CINETPAY_NOTIFY_URL is not set in .env file');
    }

    return errors;
  }

  static void printConfig() {
    print('=== Environment Configuration ===');
    print('APP_ENV: $appEnvironment');
    print('API_BASE_URL: $apiBaseUrl');
    print('CINETPAY_SITE_ID: $cinetpaySiteId');
    print(
      'CINETPAY_API_KEY: ${cinetpayApiKey.isNotEmpty ? "Set (${cinetpayApiKey.length} chars)" : "Not set"}',
    );
    print('CINETPAY_NOTIFY_URL: $cinetpayNotifyUrl');
    print('Is Configured: $isConfigured');
    if (!isConfigured) {
      print('Errors: ${configurationErrors.join(", ")}');
    }
    print('================================');
  }
}
