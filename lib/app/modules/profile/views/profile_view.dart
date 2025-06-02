import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../themes/design_system.dart';
import '../../home/views/aide_view.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(TSpacing.lg),
              child: Column(
                children: [
                  _buildStatsCards(context),
                  SizedBox(height: TSpacing.xl),
                  _buildPersonalInfoCard(context),
                  SizedBox(height: TSpacing.lg),
                  _buildQuickActions(context),
                  SizedBox(height: TSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      floating: false,
      pinned: true,
      backgroundColor: TColors.background(context),
      elevation: 0,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16, top: 8),
          child: TextButton(
            onPressed: controller.saveChanges,
            style: TextButton.styleFrom(
              backgroundColor: TColors.primary.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Sauvegarder',
              style: TextStyle(
                color: TColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Obx(
          () => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  controller.gradientStartColor.value.withOpacity(0.2),
                  controller.gradientEndColor.value.withOpacity(0.2),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  _buildProfileAvatar(context),
                  SizedBox(height: TSpacing.lg),
                  _buildUserName(context),
                  SizedBox(height: TSpacing.sm),
                  _buildMemberSince(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  controller.gradientStartColor.value,
                  controller.gradientEndColor.value,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: controller.gradientEndColor.value.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: TColors.surface(context),
                  image:
                      controller.profileImage.value != null
                          ? DecorationImage(
                            image: FileImage(controller.profileImage.value!),
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
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: controller.pickImage,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: controller.gradientStartColor.value,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: controller.gradientStartColor.value.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserName(BuildContext context) {
    return Obx(
      () =>
          controller.isEditingName.value
              ? Container(
                width: 200,
                child: TextField(
                  controller: controller.nameController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: TColors.textPrimary(context),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Votre nom',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColors.primary, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.check, color: TColors.primary),
                      onPressed: () {
                        controller.user.value?.fullName =
                            controller.nameController.text;
                        controller.isEditingName.value = false;
                      },
                    ),
                  ),
                ),
              )
              : GestureDetector(
                onTap: () => controller.isEditingName.value = true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.user.value.fullName ?? "avatar-1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: TColors.textPrimary(context),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: TColors.primary.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildMemberSince(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Membre depuis ${Jiffy.parseFromDateTime(controller.user.value?.createdAt ?? DateTime.now()).format(pattern: 'MMMM yyyy')}',
          style: TextStyle(
            fontSize: 14,
            color: TColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Note',
            '4.8',
            Icons.star_rounded,
            Colors.amber,
          ),
        ),
        SizedBox(width: TSpacing.md),
        Expanded(
          child: _buildStatCard(
            context,
            'Trajets',
            '32',
            Icons.directions_car_rounded,
            Color(0xFF6C63FF),
          ),
        ),
        SizedBox(width: TSpacing.md),
        Expanded(
          child: _buildStatCard(
            context,
            'Avis',
            '28',
            Icons.rate_review_rounded,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(TSpacing.lg),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: TSpacing.sm),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: TColors.textPrimary(context),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: TColors.textPrimary(context).withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(TSpacing.xl),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColors.textPrimary(context),
            ),
          ),
          SizedBox(height: TSpacing.xl),

          Obx(() {
            final userEmail = controller.user.value.email;
            return userEmail != null && userEmail.isNotEmpty
                ? Column(
                  children: [
                    _buildInfoRow(
                      context,
                      Icons.email_rounded,
                      'Email',
                      userEmail,
                      Colors.blue,
                    ),
                    SizedBox(height: TSpacing.lg),
                  ],
                )
                : SizedBox.shrink();
          }),

          Obx(
            () => _buildInfoRow(
              context,
              Icons.phone_rounded,
              'Téléphone',
              controller.user.value?.phoneNumber ?? "+221 77 123 45 67",
              Colors.green,
            ),
          ),

          SizedBox(height: TSpacing.lg),
          Obx(
            () => _buildRoleRow(
              context,
              Icons.person_rounded,
              'Statut',
              controller.user.value.isDriver == true
                  ? 'Conducteur'
                  : 'Passager',
              controller.user.value.isVerified == true,
              Colors.purple,
            ),
          ),
          SizedBox(height: TSpacing.lg),
          Obx(
            () => _buildInfoRow(
              context,
              Icons.cake,
              'Date de naissance',
              Jiffy.parseFromDateTime(
                controller.user.value.dateOfBirth!,
              ).format(pattern: 'dd MMMM yyyy'),
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    bool isVerified,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: TSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: TColors.textPrimary(context).withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: TColors.textPrimary(context),
                    ),
                  ),
                  if (isVerified) ...[
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified_rounded,
                        color: TColors.primary,
                        size: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: TSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: TColors.textPrimary(context).withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TColors.textPrimary(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          context,
          'Voir tous mes avis',
          Icons.rate_review_rounded,
          TColors.primary,
          () {
            // Navigate to reviews
          },
        ),
        SizedBox(height: TSpacing.md),
        _buildActionButton(
          context,
          'Aide et Support',
          Icons.help_outline_rounded,
          Colors.orange,
          () => Get.to(() => const AideScreen()),
        ),
        SizedBox(height: TSpacing.md),
        _buildActionButton(
          context,
          'Déconnexion',
          Icons.logout_rounded,
          TColors.error,
          () => _showLogoutDialog(context),
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border:
            isDestructive ? Border.all(color: color.withOpacity(0.2)) : null,
        boxShadow:
            isDestructive
                ? null
                : [
                  BoxShadow(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black12
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSpacing.lg,
              vertical: TSpacing.lg,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: TSpacing.lg),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isDestructive ? color : TColors.textPrimary(context),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: TColors.textPrimary(context).withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Déconnexion',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Annuler',
                style: TextStyle(color: TColors.textPrimary(context)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.logout();
              },
              child: Text(
                'Déconnexion',
                style: TextStyle(
                  color: TColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
