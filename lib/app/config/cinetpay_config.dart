import 'environment.dart';

class CinetPayConfig {
  static String get apiKey => Environment.cinetpayApiKey;
  static int get siteId => Environment.cinetpaySiteId;
  static String get notifyUrl => Environment.cinetpayNotifyUrl;

  static const String CURRENCY_XOF = 'XOF';
  static const String CURRENCY_USD = 'USD';
  static const String CURRENCY_EUR = 'EUR';

  static const String CHANNELS_ALL = 'ALL';
  static const String CHANNELS_MOBILE_MONEY = 'MOBILE_MONEY';
  static const String CHANNELS_CARD = 'CARD';

  static const double MIN_AMOUNT = 100.0;
  static const double MAX_AMOUNT = 1500000.0;




  static bool isValidAmount(double amount) {
    return amount >= MIN_AMOUNT && amount <= MAX_AMOUNT;
  }

  static String getAmountErrorMessage(double amount) {
    if (amount < MIN_AMOUNT) {
      return 'Le montant minimum est de ${MIN_AMOUNT.toStringAsFixed(0)} XOF';
    }
    if (amount > MAX_AMOUNT) {
      return 'Le montant maximum est de ${MAX_AMOUNT.toStringAsFixed(0)} XOF';
    }
    return '';
  }

  static bool get isConfigured => Environment.isConfigured;

  static Map<String, dynamic> get configData => {
    'apikey': apiKey,
    'site_id': siteId,
    'notify_url': notifyUrl,
  };

  static List<String> validateConfiguration() {
    return Environment.configurationErrors;
  }
}
