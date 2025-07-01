#!/usr/bin/env node

// Debug script to test FCM token and notification setup
// Run this from your Node.js backend directory

import admin from "firebase-admin";
import createLogger from "./src/utils/logger.js";

const logger = createLogger("fcm-debug-test");

// Your FCM token from the app
const FCM_TOKEN =
  "c6pC4TWQQLa_s-kdBIEAlu:APA91bFp8VZnXOwBh2LOGmFT8cHzjI_MNgDG7e6Gzym0pPI8znJ4SWxg01FhU8aH3wKTEM7zYJoGsVKtSNkJLNJIJZHyTI6Hak8VXtYAhgoMAAYltORS05c";

/**
 * Initialize Firebase Admin SDK (if not already initialized)
 */
function initializeFirebase() {
  try {
    // Check if already initialized
    admin.app();
    logger.info("Firebase Admin SDK already initialized");
  } catch (error) {
    // Initialize if not already done
    // Make sure you have your firebase service account key
    logger.info("Initializing Firebase Admin SDK...");
    // admin.initializeApp({
    //     credential: admin.credential.applicationDefault(),
    // });
    logger.warn(
      "Firebase Admin SDK initialization skipped - configure your service account key"
    );
  }
}

/**
 * Test direct FCM message sending
 */
async function sendDirectFCMTest() {
  try {
    logger.info("🧪 Testing direct FCM message...");

    const message = {
      notification: {
        title: "Direct FCM Test",
        body: "This is a direct test from Firebase Admin SDK",
      },
      data: {
        type: "test",
        timestamp: new Date().toISOString(),
      },
      token: FCM_TOKEN,
    };

    // Uncomment this when you have Firebase Admin SDK configured
    // const response = await admin.messaging().send(message);
    // logger.info(`Direct FCM message sent successfully: ${response}`);

    logger.info("Direct FCM test message structure:");
    logger.info(JSON.stringify(message, null, 2));
  } catch (error) {
    logger.error("Error sending direct FCM test:", error);
  }
}

/**
 * Validate FCM token format
 */
function validateFCMToken() {
  logger.info("🔍 Validating FCM token format...");

  if (!FCM_TOKEN) {
    logger.error("❌ FCM token is empty or undefined");
    return false;
  }

  // FCM token format validation
  const tokenPattern = /^[A-Za-z0-9_-]+:[A-Za-z0-9_-]+$/;
  const isValidFormat = tokenPattern.test(FCM_TOKEN);

  logger.info(`📱 FCM Token: ${FCM_TOKEN}`);
  logger.info(`📏 Token length: ${FCM_TOKEN.length}`);
  logger.info(`✅ Token format valid: ${isValidFormat}`);

  if (FCM_TOKEN.length < 100) {
    logger.warn("⚠️ FCM token seems unusually short");
  }

  return isValidFormat;
}

/**
 * Test notification payload structure
 */
function testNotificationPayload() {
  logger.info("🧪 Testing notification payload structures...");

  const testPayloads = [
    {
      name: "Welcome Message",
      payload: {
        notification: {
          title: "Welcome to Tyvaa!",
          body: "Thank you for joining our ride-sharing community",
        },
        data: {
          type: "welcome",
          eventType: "WELCOME_MESSAGE",
          userName: "John Doe",
        },
        token: FCM_TOKEN,
      },
    },
    {
      name: "Data-only Message",
      payload: {
        data: {
          type: "background_sync",
          eventType: "USER_REGISTERED",
          userName: "John Doe",
          timestamp: new Date().toISOString(),
        },
        token: FCM_TOKEN,
      },
    },
    {
      name: "Ride Notification",
      payload: {
        notification: {
          title: "Ride Request",
          body: "You have a new ride request",
        },
        data: {
          type: "ride",
          eventType: "RIDER_ACCEPT_RIDE",
          riderName: "John Doe",
        },
        token: FCM_TOKEN,
      },
    },
  ];

  testPayloads.forEach((test, index) => {
    logger.info(`\n📋 Test ${index + 1}: ${test.name}`);
    logger.info(JSON.stringify(test.payload, null, 2));
  });
}

/**
 * Check common FCM issues
 */
function checkCommonIssues() {
  logger.info("🔧 Checking common FCM issues...");

  const issues = [];

  // Check token validity
  if (!validateFCMToken()) {
    issues.push("Invalid FCM token format");
  }

  // Check environment
  if (!process.env.GOOGLE_APPLICATION_CREDENTIALS) {
    issues.push("GOOGLE_APPLICATION_CREDENTIALS environment variable not set");
  }

  if (issues.length > 0) {
    logger.warn("⚠️ Potential issues found:");
    issues.forEach((issue) => logger.warn(`  - ${issue}`));
  } else {
    logger.info("✅ No obvious configuration issues found");
  }

  logger.info("\n📱 App-side checklist:");
  logger.info("  ✓ Check if Firebase is initialized in main.dart");
  logger.info("  ✓ Check if notification permissions are granted");
  logger.info("  ✓ Check if FCM token is being saved to backend");
  logger.info("  ✓ Check Android manifest for FCM service configuration");
  logger.info("  ✓ Check if app is in foreground/background when testing");
  logger.info("  ✓ Check device logs for Firebase-related errors");
}

// Main execution
async function main() {
  logger.info("🚀 Starting FCM Debug Test...\n");

  initializeFirebase();
  validateFCMToken();
  testNotificationPayload();
  checkCommonIssues();

  // Test direct sending if Firebase is configured
  // await sendDirectFCMTest();

  logger.info("\n✅ FCM Debug test completed");
  logger.info("💡 Next steps:");
  logger.info("  1. Configure Firebase Admin SDK with service account key");
  logger.info("  2. Uncomment the direct FCM sending code");
  logger.info("  3. Test with different payload structures");
  logger.info("  4. Check app logs for detailed FCM debugging output");
}

main().catch((error) => {
  logger.error("Debug test failed:", error);
  process.exit(1);
});
