# Environment Variables in Flutter - Complete Guide

This guide shows you how to properly manage environment variables in your Flutter Tyvaa app.

## 🎯 Why Environment Variables?

- **Security**: Keep API keys and sensitive data out of source code
- **Flexibility**: Different configs for dev/staging/production
- **Team Collaboration**: Each developer can have their own local config
- **CI/CD**: Easy deployment with different environments

## 🚀 Quick Start

### 1. Copy Environment File

```bash
cp .env.example .env.development
```

### 2. Edit Your Variables

Edit `.env.development` with your actual CinetPay credentials:

```bash
CINETPAY_API_KEY=your_actual_api_key
CINETPAY_SITE_ID=your_site_id
CINETPAY_NOTIFY_URL=your_webhook_url
```

### 3. Run with Environment

```bash
# Using build script (recommended)
./scripts/build.sh dev

# Or manually with flutter
flutter run \
  --dart-define=CINETPAY_API_KEY=your_key \
  --dart-define=CINETPAY_SITE_ID=123456 \
  --dart-define=CINETPAY_NOTIFY_URL=your_url \
  --dart-define=APP_ENV=development
```

## 📁 File Structure

```
passenger_tyvaa/
├── .env.example              # Template file
├── .env.development          # Development config
├── .env.production          # Production config (DO NOT commit)
├── .vscode/launch.json      # VS Code debug configurations
├── scripts/build.sh         # Build scripts with env support
└── lib/app/config/
    ├── environment.dart     # Environment variable access
    └── cinetpay_config.dart # CinetPay config using env vars
```

## 🛠 Build Scripts Usage

Make the script executable:

```bash
chmod +x scripts/build.sh
```

Available commands:

```bash
# Development
./scripts/build.sh dev

# Production build
./scripts/build.sh prod

# Debug mode
./scripts/build.sh debug

# Debug with specific environment
./scripts/build.sh debug production
```

## 🔧 VS Code Integration

Use the launch configurations in `.vscode/launch.json`:

1. **Flutter Development** - Pre-configured with dev environment
2. **Flutter Production** - Production environment
3. **Flutter Debug (Custom)** - Prompts for custom values

## 💻 Command Line Usage

### Development

```bash
flutter run \
  --dart-define=CINETPAY_API_KEY=12912847765bc0db748fdd44.40081707 \
  --dart-define=CINETPAY_SITE_ID=445160 \
  --dart-define=CINETPAY_NOTIFY_URL=http://localhost:3000/api/v1/payments/notify \
  --dart-define=APP_ENV=development
```

### Production Build

```bash
flutter build apk --release \
  --dart-define=CINETPAY_API_KEY=your_production_key \
  --dart-define=CINETPAY_SITE_ID=your_production_site_id \
  --dart-define=CINETPAY_NOTIFY_URL=https://your-api.com/webhook \
  --dart-define=APP_ENV=production
```

## 🔑 Using Environment Variables in Code

```dart
import 'package:passenger_tyvaa/app/config/environment.dart';

// Access environment variables
String apiKey = Environment.cinetpayApiKey;
int siteId = Environment.cinetpaySiteId;
String notifyUrl = Environment.cinetpayNotifyUrl;

// Check environment
if (Environment.isDevelopment) {
  print('Running in development mode');
}

// Validate configuration
if (!Environment.isConfigured) {
  print('Missing environment variables:');
  Environment.configurationErrors.forEach(print);
}
```

## 🔒 Security Best Practices

### ✅ DO

- Use different API keys for development and production
- Add `.env.*` files to `.gitignore` (except `.env.example`)
- Use CI/CD environment variables for deployment
- Validate environment variables at app startup

### ❌ DON'T

- Commit real API keys to version control
- Use production keys in development
- Hard-code sensitive values in source code
- Share API keys in chat or email

## 🚦 Environment Types

### Development

- Local development
- Test CinetPay credentials
- Debug logging enabled
- Local backend

### Staging

- Pre-production testing
- Production-like environment
- Real API keys (test mode)
- Staging backend

### Production

- Live app
- Real CinetPay credentials
- Error tracking
- Production backend

## 🐛 Troubleshooting

### "Configuration manquante" Error

Check that all required environment variables are set:

```dart
print(Environment.configurationErrors);
```

### VS Code Not Loading Environment

Restart VS Code after changing `.vscode/launch.json`

### Build Script Permission Error

```bash
chmod +x scripts/build.sh
```

### Environment Variables Not Working

Ensure you're using `--dart-define` flags correctly and values don't contain spaces.

## 📝 CI/CD Setup

### GitHub Actions Example

```yaml
- name: Build APK
  run: |
    flutter build apk --release \
      --dart-define=CINETPAY_API_KEY=${{ secrets.CINETPAY_API_KEY }} \
      --dart-define=CINETPAY_SITE_ID=${{ secrets.CINETPAY_SITE_ID }} \
      --dart-define=CINETPAY_NOTIFY_URL=${{ secrets.CINETPAY_NOTIFY_URL }} \
      --dart-define=APP_ENV=production
```

### Codemagic Setup

Add environment variables in Codemagic dashboard and reference them in your build script.

## 🔄 Migration from Old Config

If you were using the old hardcoded config, the new environment-based system is already integrated. Just ensure your environment variables are set correctly.

## 📞 Support

For environment variable issues:

1. Check the troubleshooting section above
2. Verify your CinetPay credentials
3. Ensure all required variables are set
4. Check the console for specific error messages
