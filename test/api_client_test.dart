import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';

void main() {
  group('ApiClient Circuit Breaker', () {
    late ApiClient apiClient;

    setUp(() {
      // Mock connectivity controller
      Get.put(ConnectivityController());
      apiClient = ApiClient();
    });

    tearDown(() {
      Get.reset();
    });

    test('should have circuit breaker initially closed', () {
      expect(apiClient.isCircuitBreakerOpen, false);
      expect(apiClient.consecutiveFailures, 0);
    });

    test('should reset circuit breaker manually', () {
      apiClient.resetCircuitBreaker();
      expect(apiClient.isCircuitBreakerOpen, false);
      expect(apiClient.consecutiveFailures, 0);
    });
  });
}
