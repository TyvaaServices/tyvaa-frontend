// Example constants file structure
// lib/app/constants/app_constants.dart
class AppConstants {
  // OTP Constants
  static const int otpLength = 6;
  static const String demoCorrectOtp = '123456'; // For demo purposes only
  static const int otpResendDelaySeconds = 30;

  // Private constructor to prevent instantiation
  AppConstants._();
}
