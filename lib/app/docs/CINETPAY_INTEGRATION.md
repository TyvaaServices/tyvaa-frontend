# CinetPay Integration for Tyvaa

This implementation provides a clean, simple payment screen using CinetPay for your Tyvaa passenger app.

## Features

✅ Clean, minimal design following your app's design system  
✅ CinetPay integration for secure payments  
✅ Automatic booking confirmation after successful payment  
✅ Error handling and user feedback  
✅ Loading states and animations  
✅ Environment-based configuration (dev/prod)

## Setup Instructions

### 1. CinetPay Account Setup

1. Go to [CinetPay.com](https://cinetpay.com/)
2. Create an account or log in
3. Navigate to Settings > API Keys in your dashboard
4. Copy your API Key and Site ID
5. Set up your webhook/notify URL

### 2. Configure Your Credentials

Edit `/lib/app/config/cinetpay_config.dart`:

```dart
// Development environment
static const Map<String, dynamic> development = {
  'api_key': 'your_test_api_key',
  'site_id': 445160, // Your test site ID
  'notify_url': 'https://your-api.com/webhook/cinetpay',
};

// Production environment
static const Map<String, dynamic> production = {
  'api_key': 'your_production_api_key',
  'site_id': 123456, // Your production site ID
  'notify_url': 'https://your-api.com/webhook/cinetpay',
};
```

### 3. How to Use

#### Simple Payment (Amount Only)

```dart
import 'package:get/get.dart';
import 'app/modules/payment/views/payment_view.dart';

// Navigate to payment screen
Get.to(
  () => const PaymentView(),
  arguments: {
    'amount': 2500.0, // Amount in XOF
  },
);
```

#### Full Booking Flow (Recommended)

```dart
// Navigate with booking data for complete flow
Get.to(
  () => const PaymentView(),
  arguments: {
    'amount': 2500.0,
    'bookingData': {
      'departure': 'Dakar Plateau',
      'destination': 'Yoff',
      'departureTime': '2025-01-15 14:30',
      'seats': 2,
      'driverId': 123,
      'rideId': 456,
    },
  },
);
```

#### Handle Payment Result

```dart
// Wait for payment result
final result = await Get.to(() => const PaymentView(), arguments: {...});

// Handle the result
if (result != null && result['success'] == true) {
  if (result['booking_confirmed'] == true) {
    // Both payment and booking succeeded
    Get.snackbar('Succès', 'Trajet réservé avec succès!');
  } else {
    // Only payment succeeded
    Get.snackbar('Paiement réussi', 'Paiement effectué.');
  }
}
```

## File Structure

```
lib/app/
├── modules/payment/
│   ├── controllers/payment_controller.dart  # Payment logic & CinetPay integration
│   ├── views/payment_view.dart             # Clean payment UI
│   └── bindings/payment_binding.dart       # GetX bindings
├── config/
│   └── cinetpay_config.dart               # CinetPay configuration
├── examples/
│   └── payment_example.dart               # Usage examples
└── repositories/
    └── user_repository.dart               # Booking API calls
```

## Design Features

- **Minimal UI**: Clean, uncluttered design like Google's approach
- **Your Design System**: Uses TColors, TTypography, TSpacing from your design system
- **Loading States**: Smooth loading indicators during payment
- **Error Handling**: Clear error messages with icons
- **Success Feedback**: Success states with visual confirmation
- **Security Note**: Shows "Paiement sécurisé via CinetPay" footer

## Payment Flow

1. User clicks "Réserver trajet"
2. App navigates to PaymentView with amount and booking data
3. User sees clean payment screen with amount
4. User clicks "Confirmer le paiement"
5. CinetPay checkout opens with multiple payment options
6. After successful payment, booking is automatically confirmed
7. User sees success message and returns to previous screen

## Payment Methods Supported

CinetPay supports multiple payment methods in West Africa:

- Mobile Money (Orange Money, MTN Money, Moov Money)
- Credit/Debit Cards (Visa, Mastercard)
- Bank transfers
- Digital wallets

## Backend Integration

You'll need to implement a webhook endpoint to handle payment confirmations:

```javascript
// Example Node.js webhook endpoint
app.post("/webhook/cinetpay", (req, res) => {
  const { cpm_trans_id, cpm_trans_status, cpm_amount } = req.body;

  if (cpm_trans_status === "ACCEPTED") {
    // Payment confirmed, update booking status in database
    updateBookingStatus(cpm_trans_id, "confirmed");
  }

  res.status(200).send("OK");
});
```

## Testing

Use CinetPay's test environment for development:

- Test API keys are provided by CinetPay
- Use test amounts: 100 XOF (success), 150 XOF (failure)
- No real money is charged in test mode

## Customization

The payment screen is designed to be simple and clean. You can customize:

- Colors: Edit `TColors` in your design system
- Typography: Modify `TTypography` styles
- Button styles: Update `TRadius.buttonRadius`
- Spacing: Adjust `TSpacing` values

## Security Notes

- API keys are stored in configuration files (consider environment variables for production)
- All payments are processed securely through CinetPay
- Transaction IDs are unique and timestamped
- Amount validation prevents invalid transactions

## Support

For CinetPay integration issues:

- [CinetPay Documentation](https://docs.cinetpay.com/)
- [CinetPay Support](https://cinetpay.com/support)

For app-specific issues, check the error messages in the payment controller and ensure your backend webhook is properly implemented.
