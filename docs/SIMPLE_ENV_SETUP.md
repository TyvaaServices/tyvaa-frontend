# Simple Environment Management with flutter_dotenv

## Why flutter_dotenv is Better

✅ **Simple**: Just edit `.env` file, no complex build commands  
✅ **Developer Friendly**: Works with VS Code, hot reload, etc.  
✅ **Team Ready**: Each developer can have their own `.env` file  
✅ **No Build Script Needed**: Just `flutter run` works

## Quick Setup

1. **Copy environment file:**

```bash
cp .env.example .env
```

2. **Edit your credentials in `.env`:**

```bash
CINETPAY_API_KEY=your_actual_api_key_here
CINETPAY_SITE_ID=123456
CINETPAY_NOTIFY_URL=http://localhost:3000/api/v1/payments/notify
```

3. **Run normally:**

```bash
flutter run
```

That's it! No complex build commands needed.

## File Structure

```
.env                    # Your local development config (git ignored)
.env.example           # Template for team members
.env.development       # Development defaults
.env.production        # Production config (git ignored)
```

## Usage in Code

The app automatically loads `.env` on startup. Access variables like:

```dart
import 'package:passenger_tyvaa/app/config/environment.dart';

// Check if configured
if (!Environment.isConfigured) {
  print('Missing environment variables');
}

// Use values
String apiKey = Environment.cinetpayApiKey;
```

## Different Environments

### Development (default)

Just use `.env` file - already set up for you.

### Production

1. Copy your production values:

```bash
cp .env.production .env
```

2. Run as normal:

```bash
flutter run
```

### Quick Environment Switch

```bash
# Development
cp .env.development .env

# Production
cp .env.production .env
```

## Security

- `.env` files are git-ignored (except `.env.example`)
- Never commit real API keys
- Use different keys for dev/production

## Troubleshooting

**"Configuration manquante" error?**

- Check your `.env` file exists
- Verify all required variables are set
- Run in debug mode to see configuration details

**VS Code not loading changes?**

- Hot restart (Ctrl+Shift+F5) after changing `.env`

## Migration from Build Scripts

The complex build scripts have been replaced with this simple approach. You can delete:

- `scripts/build.sh`
- `.vscode/launch.json` dart-define configs

Just use the `.env` file approach instead!
