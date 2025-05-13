import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../controllers/publish_trajet_controller.dart';

class PublishTrajetView extends GetView<PublishTrajetController> {
  const PublishTrajetView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final backgroundColor =
        isDark ? AppColors.darkBackground : const Color(0xFFF8F9FE);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: textColor, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Publier un trajet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorations (optimisé)
            _buildBackgroundDecoration(primaryColor),

            // Main content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(primaryColor),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Détails du trajet', textColor),
                    const SizedBox(height: 16),

                    // Location fields
                    _buildLocationFields(
                      isDark,
                      surfaceColor,
                      textColor,
                      primaryColor,
                    ),
                    const SizedBox(height: 24),

                    // Date & Places section
                    _buildDateAndPlacesSection(
                      isDark,
                      surfaceColor,
                      textColor,
                      primaryColor,
                      context,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      'Informations complémentaires',
                      textColor,
                    ),
                    const SizedBox(height: 16),

                    // Comment field
                    _buildCommentField(
                      isDark,
                      surfaceColor,
                      textColor,
                      primaryColor,
                    ),
                    const SizedBox(height: 24),

                    // Price section
                    _buildPriceField(
                      isDark,
                      surfaceColor,
                      textColor,
                      primaryColor,
                    ),
                    const SizedBox(height: 32),

                    // Publish button
                    _buildPublishButton(primaryColor),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecoration(Color primaryColor) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.05),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  Widget _buildHeaderSection(Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, const Color(0xFF8A6FFF)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.directions_car_filled_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Proposer un trajet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Partagez votre trajet et voyagez à moindre coût',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerWithIcon({
    required bool isDark,
    required Color surfaceColor,
    required Color primaryColor,
    required Widget child,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildIconContainer(IconData icon, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: primaryColor, size: 18),
    );
  }

  Widget _buildLocationFields(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return _buildContainerWithIcon(
      isDark: isDark,
      surfaceColor: surfaceColor,
      primaryColor: primaryColor,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Departure field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                _buildIconContainer(Icons.my_location_rounded, primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: controller.departure,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Point de départ',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.only(left: 54),
            child: Divider(color: textColor.withOpacity(0.1), height: 1),
          ),

          // Destination field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                _buildIconContainer(Icons.location_on_rounded, primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: controller.destination,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateAndPlacesSection(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
    BuildContext context,
  ) {
    return Row(
      children: [
        // Date & Time picker
        Expanded(
          flex: 3,
          child: _buildDateTimePicker(
            isDark,
            surfaceColor,
            textColor,
            primaryColor,
            context,
          ),
        ),
        const SizedBox(width: 12),
        // Places picker
        Expanded(
          flex: 2,
          child: _buildPlacesPicker(
            isDark,
            surfaceColor,
            textColor,
            primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
    BuildContext context,
  ) {
    final selected = controller.dateTime.value;

    return _buildContainerWithIcon(
      isDark: isDark,
      surfaceColor: surfaceColor,
      primaryColor: primaryColor,
      child: InkWell(
        onTap:
            () => _showDateTimePicker(
              context,
              primaryColor,
              surfaceColor,
              textColor,
            ),
        child: Row(
          children: [
            _buildIconContainer(Icons.calendar_today_rounded, primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date & Heure',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selected != null
                        ? DateFormat('dd MMM yyyy – HH:mm').format(selected)
                        : 'Choisir',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDateTimePicker(
    BuildContext context,
    Color primaryColor,
    Color surfaceColor,
    Color textColor,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                surface: surfaceColor,
                onSurface: textColor,
              ),
            ),
            child: child!,
          ),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 12, minute: 0),
        builder:
            (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  surface: surfaceColor,
                  onSurface: textColor,
                ),
              ),
              child: child!,
            ),
      );

      if (time != null) {
        controller.dateTime.value = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
  }

  Widget _buildPlacesPicker(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return _buildContainerWithIcon(
      isDark: isDark,
      surfaceColor: surfaceColor,
      primaryColor: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconContainer(Icons.people_alt_rounded, primaryColor),
              const SizedBox(width: 12),
              Text(
                'Places',
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCounterButton(
                icon: Icons.remove,
                primaryColor: primaryColor,
                onTap: () {
                  if (controller.places.value > 1) controller.places.value--;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${controller.places.value}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              _buildCounterButton(
                icon: Icons.add,
                primaryColor: primaryColor,
                onTap: () {
                  if (controller.places.value < 8) controller.places.value++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: primaryColor),
      ),
    );
  }

  Widget _buildCommentField(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return _buildContainerWithIcon(
      isDark: isDark,
      surfaceColor: surfaceColor,
      primaryColor: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconContainer(Icons.comment_rounded, primaryColor),
              const SizedBox(width: 12),
              Text(
                'Commentaires (optionnel)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            onChanged: controller.comment,
            maxLines: 3,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: 'Ex: 1 valise max, pas d\'animaux, etc.',
              hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              filled: true,
              fillColor: isDark ? Color(0xFF252543) : Color(0xFFF0F2F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceField(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return _buildContainerWithIcon(
      isDark: isDark,
      surfaceColor: surfaceColor,
      primaryColor: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconContainer(Icons.payments_rounded, primaryColor),
              const SizedBox(width: 12),
              Text(
                'Prix par passager',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            onChanged: controller.price,
            keyboardType: TextInputType.number,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: 'Ex: 2500',
              suffixText: 'FCFA',
              suffixStyle: TextStyle(
                color: textColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              filled: true,
              fillColor: isDark ? Color(0xFF252543) : Color(0xFFF0F2F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublishButton(Color primaryColor) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, const Color(0xFF8A6FFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => _validateAndSubmit(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        icon: const Icon(Icons.check_circle_rounded, size: 24),
        label: const Text(
          'Publier mon trajet',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    // Si tout est valide, on publie le trajet
    if (!controller.validateForm()) {
      return;
    }
    controller.publishTrajet();
  }

  void _showErrorDialog(String message) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Erreur',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
