import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/dexchange_models.dart';
import '../controllers/payment_controller.dart';

/// Simple payment method selector for your existing payment view
class DexchangePaymentSelector extends StatelessWidget {
  const DexchangePaymentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find<PaymentController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade300),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.error, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => controller.loadAvailablePaymentMethods(),
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.availablePaymentMethods.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Aucune méthode de paiement disponible'),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Country Selector
          _buildCountrySelector(controller),
          const SizedBox(height: 16),

          // Payment Methods List
          _buildPaymentMethodsList(controller),
        ],
      );
    });
  }

  Widget _buildCountrySelector(PaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pays',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<DexchangeCountry>(
            value: controller.selectedCountry.value,
            isExpanded: true,
            underline: const SizedBox(),
            items:
                DexchangeCountry.values.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(_getCountryName(country)),
                  );
                }).toList(),
            onChanged: (country) {
              if (country != null) {
                controller.setCountry(country);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsList(PaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Méthode de paiement',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...controller.availablePaymentMethods.map((methodInfo) {
          final paymentMethod = controller.getPaymentMethodFromOperator(
            methodInfo.operator,
          );
          final isSelected =
              controller.selectedPaymentMethod.value == paymentMethod;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.setPaymentMethod(paymentMethod),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isSelected
                              ? const Color(0xFF6A0DAD)
                              : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        isSelected
                            ? const Color(0xFF6A0DAD).withOpacity(0.05)
                            : Colors.white,
                  ),
                  child: Row(
                    children: [
                      _getPaymentMethodIcon(paymentMethod),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              methodInfo.displayName,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected
                                        ? const Color(0xFF6A0DAD)
                                        : Colors.black87,
                              ),
                            ),
                            Text(
                              'Mobile Money',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Color(0xFF6A0DAD))
                      else
                        Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey.shade400,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _getPaymentMethodIcon(DexchangePaymentMethod method) {
    String text;
    Color backgroundColor;

    switch (method) {
      case DexchangePaymentMethod.orange:
        text = 'OM';
        backgroundColor = const Color(0xFFFF7900);
        break;
      case DexchangePaymentMethod.wave:
        text = 'W';
        backgroundColor = const Color(0xFF007AFF);
        break;
      case DexchangePaymentMethod.mtn:
        text = 'MTN';
        backgroundColor = const Color(0xFFFFCC00);
        break;
      case DexchangePaymentMethod.moov:
        text = 'M';
        backgroundColor = const Color(0xFFE60012);
        break;
      case DexchangePaymentMethod.free:
        text = 'FM';
        backgroundColor = const Color(0xFF6A0DAD);
        break;
      case DexchangePaymentMethod.wizall:
        text = 'WZ';
        backgroundColor = const Color(0xFF00C851);
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: _getContrastColor(backgroundColor),
            fontWeight: FontWeight.bold,
            fontSize: text.length > 2 ? 10 : 12,
          ),
        ),
      ),
    );
  }

  String _getCountryName(DexchangeCountry country) {
    switch (country) {
      case DexchangeCountry.senegal:
        return 'Sénégal';
      case DexchangeCountry.mali:
        return 'Mali';
      case DexchangeCountry.ivoryCoast:
        return 'Côte d\'Ivoire';
      case DexchangeCountry.cameroon:
        return 'Cameroun';
    }
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
