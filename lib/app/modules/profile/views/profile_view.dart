import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../themes/tyvaa_theme.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define constant accent and danger colors that aren't in AppColors yet
    final accentColor = Color(0xFF8A6FFF);
    final dangerColor = Color(0xFFFF5252);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mon Profil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: controller.saveChanges,
            child: Text(
              'Enregistrer',
              style: TextStyle(
                color: AppColors.primaryColor,
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
              _buildProfileHeader(context, accentColor),
              SizedBox(height: 40),
              _buildUserInfoSection(context),
              SizedBox(height: 30),
              _buildRatingsSection(context),
              SizedBox(height: 30),
              // _buildPreferencesSection(context),
              SizedBox(height: 30),
              _buildLogoutButton(context, dangerColor),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Color accentColor) {
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
                    colors: [AppColors.primaryColor, accentColor],
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
                      color: AppColors.surfaceColor,
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

            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.isDark
                                ? Colors.black26
                                : AppColors.primaryColor.withOpacity(0.3),
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
                  ? _buildNameEditField()
                  : GestureDetector(
                    onTap: () => controller.isEditingName.value = true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.user.value!.fullName!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.edit,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildNameEditField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                AppColors.isDark
                    ? Colors.black12
                    : Colors.black.withOpacity(0.05),
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
            icon: Icon(Icons.check, color: AppColors.primaryColor),
            onPressed: () {
              controller.user.value!.fullName = controller.nameController.text;
              controller.isEditingName.value = false;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      AppColors.isDark
                          ? Colors.black12
                          : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoItem(
                  context,
                  Icons.email_outlined,
                  'Email',
                  'cheikh@tyvaa.com',
                  Colors.blue,
                ),
                Divider(height: 30),
                _buildInfoItem(
                  context,
                  Icons.phone_outlined,
                  'Téléphone',
                  controller.user.value!.phoneNumber,
                  Colors.green,
                ),
                Divider(height: 30),
                _buildInfoItem(
                  context,
                  Icons.calendar_today_outlined,
                  'Membre depuis',
                  Jiffy.parseFromDateTime(
                    controller.user.value!.createdAt,
                  ).format(pattern: 'MMMM yyyy'),
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
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    final textColor = AppColors.textColor;

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

  Widget _buildRatingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes évaluations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    AppColors.isDark
                        ? Colors.black12
                        : Colors.black.withOpacity(0.05),
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
                  _buildRatingScore('Note globale', '4.8', Colors.amber),
                  _buildRatingScore('Trajets', '32', Color(0xFF6C63FF)),
                  _buildRatingScore('Avis', '28', Colors.green),
                ],
              ),
              SizedBox(height: 24),
              _buildRatingBar(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/default_profile.png',
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
                    color: AppColors.textColor.withOpacity(0.3),
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

  Widget _buildRatingScore(String label, String value, Color color) {
    final textColor = AppColors.textColor;

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

  Widget _buildRatingBar() {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.isDark ? Colors.grey.shade800 : Colors.grey.shade200,
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

  Widget _buildLogoutButton(BuildContext context, Color dangerColor) {
    final textColor = AppColors.textColor;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                AppColors.isDark
                    ? Colors.black12
                    : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Afficher dialogue de confirmation
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Déconnexion'),
                  content: Text('Êtes-vous sûr de vouloir vous déconnecter?'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Ici, ajoutez la logique de déconnexion
                        controller.logout();
                      },
                      child: Text(
                        'Déconnexion',
                        style: TextStyle(color: dangerColor),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: dangerColor, size: 24),
                SizedBox(width: 12),
                Text(
                  'Déconnexion',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
