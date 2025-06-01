import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../domain/entities/user.dart';
import '../../../services/synchronization_service.dart';

class ProfileController extends GetxController {
  Rx<User> user = Rx<User>(User());
  final userName = 'Cheikh Tidiane'.obs;
  final phoneNumber = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final isEditingName = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final storage = const FlutterSecureStorage();

  // Colors for profile image gradient
  final Rx<Color> gradientStartColor = Rx<Color>(Colors.purple);
  final Rx<Color> gradientEndColor = Rx<Color>(Colors.blue);
  final isGradientLoading = false.obs;

  @override
  Future<void> onInit() async {
    var logger = Logger();

    var box = Hive.box<User>('users');

    if (box.containsKey('currentUser')) {
      user.value = box.get('currentUser')!;
      nameController.text = user.value!.fullName ?? '';
      logger.d(user.value);

      // If there's an existing profile image, try to load it and extract colors
      await loadProfileImageAndExtractColors();
    } else {
      logger.d('No user found in Hive');
    }

    super.onInit();
  }

  Future<void> loadProfileImageAndExtractColors() async {
    try {
      final AssetImage defaultImage = AssetImage(
        'assets/images/default_profile.png',
      );
      final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        defaultImage,
        size: Size(100, 100), // Reduced size for faster processing
        maximumColorCount: 20,
      );

      updateGradientColors(palette);
    } catch (e) {
      print('Error loading profile image colors: $e');
    }
  }

  void pickImage() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.photos.request();
    } else if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      return;
    }

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800, // Reduce image size for faster processing
        maxHeight: 800,
      );
      if (image != null) {
        profileImage.value = File(image.path);
        // Extract colors from the new image
        await extractColorsFromImage(File(image.path));
      }
    } else {
      Get.snackbar('Permission refusée', 'Autorisez l\'accès aux photos');
    }
  }

  Future<void> extractColorsFromImage(File imageFile) async {
    isGradientLoading.value = true;
    try {
      print('Starting color extraction from: ${imageFile.path}');

      // Generate palette from the image file
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
            FileImage(imageFile),
            size: Size(200, 200), // Reduced size for faster processing
            maximumColorCount: 20,
          );

      print('Palette generated. Available colors:');
      print('Dominant: ${paletteGenerator.dominantColor?.color}');
      print('Vibrant: ${paletteGenerator.vibrantColor?.color}');
      print('DarkVibrant: ${paletteGenerator.darkVibrantColor?.color}');
      print('LightVibrant: ${paletteGenerator.lightVibrantColor?.color}');
      print('Muted: ${paletteGenerator.mutedColor?.color}');
      print('DarkMuted: ${paletteGenerator.darkMutedColor?.color}');
      print('LightMuted: ${paletteGenerator.lightMutedColor?.color}');

      // Force use of dominant color for immediate visual feedback
      final dominantColor = paletteGenerator.dominantColor?.color;
      if (dominantColor != null) {
        print('Using dominant color: $dominantColor');
        // Create a complementary color for the gradient
        final complementaryColor = _createComplementaryColor(dominantColor);

        gradientStartColor.value = dominantColor;
        gradientEndColor.value = complementaryColor;
        print(
          'Set gradient colors to: ${gradientStartColor.value} and ${gradientEndColor.value}',
        );
      } else {
        print('No dominant color found, falling back to defaults');
        gradientStartColor.value = Colors.purple;
        gradientEndColor.value = Colors.blue;
      }
    } catch (e) {
      print('Error extracting colors: $e');
      // Fallback to default colors
      gradientStartColor.value = Colors.purple;
      gradientEndColor.value = Colors.blue;
    } finally {
      isGradientLoading.value = false;
    }
  }

  // Create a complementary color that works well with the source color
  Color _createComplementaryColor(Color color) {
    // Method 1: Adjust the hue by 180 degrees (complementary on color wheel)
    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor complementary = hsl.withHue((hsl.hue + 180) % 360);

    // Method 2: Just darken or lighten the color
    final HSLColor adjusted = hsl.withLightness(
      hsl.lightness > 0.5 ? hsl.lightness - 0.3 : hsl.lightness + 0.3,
    );

    print('Original HSL: $hsl');
    print('Complementary HSL: $complementary');
    print('Adjusted HSL: $adjusted');

    // Use the adjusted version as it often produces more pleasing results
    return adjusted.toColor();
  }

  void updateGradientColors(PaletteGenerator palette) {
    // Debug the available colors
    print('Dominant color: ${palette.dominantColor?.color}');
    print('Vibrant color: ${palette.vibrantColor?.color}');
    print('Light vibrant color: ${palette.lightVibrantColor?.color}');
    print('Dark vibrant color: ${palette.darkVibrantColor?.color}');

    // Get vibrant colors if available
    final vibrantColor = palette.vibrantColor?.color;
    final darkVibrantColor = palette.darkVibrantColor?.color;
    final lightVibrantColor = palette.lightVibrantColor?.color;
    final dominantColor = palette.dominantColor?.color;

    // Set gradient colors based on extracted palette, with fallbacks
    if (lightVibrantColor != null && darkVibrantColor != null) {
      gradientStartColor.value = lightVibrantColor;
      gradientEndColor.value = darkVibrantColor;
      print('Using light+dark vibrant: $lightVibrantColor, $darkVibrantColor');
    } else if (vibrantColor != null && darkVibrantColor != null) {
      gradientStartColor.value = vibrantColor;
      gradientEndColor.value = darkVibrantColor;
      print('Using vibrant+dark: $vibrantColor, $darkVibrantColor');
    } else if (lightVibrantColor != null && vibrantColor != null) {
      gradientStartColor.value = lightVibrantColor;
      gradientEndColor.value = vibrantColor;
      print('Using light+vibrant: $lightVibrantColor, $vibrantColor');
    } else if (dominantColor != null) {
      // Create a gradient from the dominant color and a darker/lighter variant
      gradientStartColor.value = dominantColor;
      gradientEndColor.value = _adjustColor(dominantColor, -30);
      print(
        'Using dominant colors: $dominantColor, ${_adjustColor(dominantColor, -30)}',
      );
    } else if (vibrantColor != null) {
      gradientStartColor.value = vibrantColor;
      gradientEndColor.value = _adjustColor(vibrantColor, -30);
      print('Using vibrant color: $vibrantColor');
    } else {
      // Fallback
      gradientStartColor.value = Colors.indigo;
      gradientEndColor.value = Colors.purple;
      print('Using fallback colors');
    }
  }

  // Helper method to adjust color brightness/darkness
  Color _adjustColor(Color color, int amount) {
    int r = (color.red + amount).clamp(0, 255);
    int g = (color.green + amount).clamp(0, 255);
    int b = (color.blue + amount).clamp(0, 255);
    return Color.fromARGB(color.alpha, r, g, b);
  }

  void saveChanges() async {
    if (user.value != null) {
      user.value!.fullName = nameController.text.trim();

      var box = Hive.box<User>('users');
      await box.put('currentUser', user.value!);
      final synchronize = Get.find<SynchronizationService>();
      synchronize.markUserChanged();
      if (isEditingName.value) {
        isEditingName.value = false;
      }
    }

    Get.snackbar(
      'Profil mis à jour',
      'Vos informations ont été enregistrées avec succès',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 16,
      duration: Duration(seconds: 2),
    );
  }

  //A TESTER AVEC LE BACKEND
  void logout() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    await storage.deleteAll();
    await Future.delayed(2.seconds);
    Get.offAllNamed('/login');
  }
}
