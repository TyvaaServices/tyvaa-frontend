import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/tyvaa_theme.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    // Colors
    final backgroundColor =
        isDark ? AppColors.darkBackground : Color(0xFFF7F8FC);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final surfaceColor = isDark ? Color(0xFF1E1E2E) : Colors.white;
    final accentColor = Color(0xFF8A6FFF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mon Profil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: controller.saveChanges,
            child: Text(
              'Enregistrer',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _buildProfileHeader(
                context,
                isDark,
                primaryColor,
                accentColor,
                surfaceColor,
              ),
              SizedBox(height: 40),
              _buildUserInfoSection(context, isDark, textColor, surfaceColor),
              SizedBox(height: 30),
              _buildRatingsSection(context, isDark, textColor, surfaceColor),
              SizedBox(height: 30),
              // _buildPreferencesSection(context, isDark, textColor, surfaceColor, primaryColor),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    Color accentColor,
    Color surfaceColor,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Profile picture
            Obx(
              () => Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, accentColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: surfaceColor,
                      image:
                          controller.profileImage.value != null
                              ? DecorationImage(
                                image: FileImage(
                                  controller.profileImage.value!,
                                ),
                                fit: BoxFit.cover,
                              )
                              : DecorationImage(
                                image: AssetImage(
                                  'assets/images/default_profile.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                ),
              ),
            ),

            // Edit icon
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark
                                ? Colors.black26
                                : primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // User name
        Obx(
          () =>
              controller.isEditingName.value
                  ? _buildNameEditField(isDark, surfaceColor, primaryColor)
                  : GestureDetector(
                    onTap: () => controller.isEditingName.value = true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.userName.value,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.edit, size: 18, color: primaryColor),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildNameEditField(
    bool isDark,
    Color surfaceColor,
    Color primaryColor,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller.nameController,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Votre nom',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: IconButton(
            icon: Icon(Icons.check, color: primaryColor),
            onPressed: () {
              controller.userName.value = controller.nameController.text;
              controller.isEditingName.value = false;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color surfaceColor,
  ) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoItem(
                  context,
                  isDark,
                  Icons.email_outlined,
                  'Email',
                  'cheikh@tyvaa.com',
                  Colors.blue,
                ),
                Divider(height: 30),
                _buildInfoItem(
                  context,
                  isDark,
                  Icons.phone_outlined,
                  'Téléphone',
                  controller.phoneNumber.value,
                  Colors.green,
                ),
                Divider(height: 30),
                _buildInfoItem(
                  context,
                  isDark,
                  Icons.calendar_today_outlined,
                  'Membre depuis',
                  'Mars 2025',
                  Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    bool isDark,
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    final textColor = isDark ? Colors.white : Colors.black87;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: textColor.withOpacity(0.3),
          size: 16,
        ),
      ],
    );
  }

  Widget _buildRatingsSection(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color surfaceColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes évaluations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRatingScore(
                    isDark,
                    'Note globale',
                    '4.8',
                    Colors.amber,
                  ),
                  _buildRatingScore(isDark, 'Trajets', '32', Color(0xFF6C63FF)),
                  _buildRatingScore(isDark, 'Avis', '28', Colors.green),
                ],
              ),
              SizedBox(height: 24),
              _buildRatingBar(isDark),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/avatar1.png',
                        ),
                        radius: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Voir tous les avis',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: textColor.withOpacity(0.3),
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingScore(
    bool isDark,
    String label,
    String value,
    Color color,
  ) {
    final textColor = isDark ? Colors.white : Colors.black87;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
        ),
        SizedBox(height: 6),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(bool isDark) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 90,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF8A6FFF)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Expanded(flex: 10, child: Container()),
        ],
      ),
    );
  }

  // Widget _buildPreferencesSection(
  //     BuildContext context,
  //     bool isDark,
  //     Color textColor,
  //     Color surfaceColor,
  //     Color primaryColor,
  //     ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Préférences',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: textColor,
  //         ),
  //       ),
  //       SizedBox(height: 16),
  //       Container(
  //         padding: EdgeInsets.all(6),
  //         decoration: BoxDecoration(
  //           color: surfaceColor,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
  //               blurRadius: 10,
  //               offset: Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: [
  //             _buildPreferenceItem(
  //               isDark,
  //               Icons.dark_mode_outlined,
  //               'Mode sombre',
  //               true,
  //               primaryColor,
  //             ),
  //             _buildPreferenceItem(
  //               isDark,
  //               Icons.notifications_outlined,
  //               'Notifications',
  //               true,
  //               primaryColor,
  //             ),
  //             _buildPreferenceItem(
  //               isDark,
  //               Icons.language_outlined,
  //               'Langue',
  //               false,
  //               primaryColor,
  //               value: 'Français',
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPreferenceItem(
  //     bool isDark,
  //     IconData icon,
  //     String label,
  //     bool isSwitch,
  //     Color primaryColor, {
  //       String? value,
  //     }) {
  //   final textColor = isDark ? Colors.white : Colors.black87;
  //
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
  //     child: ListTile(
  //       leading: Container(
  //         padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           color: primaryColor.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Icon(
  //           icon,
  //           color: primaryColor,
  //           size: 24,
  //         ),
  //       ),
  //       title: Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w500,
  //           color: textColor,
  //         ),
  //       ),
  //       trailing: isSwitch
  //           ? Switch(
  //         value: true,
  //         activeColor: primaryColor,
  //         onChanged: (val) {},
  //       )
  //           : Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             value!,
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: textColor.withOpacity(0.7),
  //             ),
  //           ),
  //           SizedBox(width: 4),
  //           Icon(
  //             Icons.arrow_forward_ios,
  //             color: textColor.withOpacity(0.3),
  //             size: 16,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
