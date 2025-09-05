/// Application configuration for different environments
class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.tyvaa.live/api/v1',
  );

  static const bool isProduction = bool.fromEnvironment('PRODUCTION');
  static const bool enableLogging = !isProduction;

  /// DEXCHANGE Configuration
  static const String dexchangeWebhookUrl =
      '$baseUrl/payments/dexchange/webhook';
  static const String paymentsBasePath = '/payments';

  /// Supported countries for DEXCHANGE
  static const List<String> supportedCountries = ['SN', 'ML', 'CI', 'CM'];

  /// Payment timeout in minutes
  static const int paymentTimeoutMinutes = 5;

  /// Payment polling interval in seconds
  static const int paymentPollingIntervalSeconds = 10;
}
