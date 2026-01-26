class EnvConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
  static const bool enableLogs = bool.fromEnvironment(
    'ENABLE_LOGS',
    defaultValue: true,
  );
}
