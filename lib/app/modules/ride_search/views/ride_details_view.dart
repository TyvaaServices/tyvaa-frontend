import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../payment/views/payment_view.dart';

class RideDetailsView extends StatelessWidget {
  final RideSearchController controller = Get.find();
  final _numberOfSeatsController = TextEditingController(text: '1');

  RideDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: Obx(() {
        final ride = controller.selectedRide.value;

        if (ride == null) {
          return const Center(child: Text('Trajet non trouvé'));
        }

        return Column(
          children: [
            _buildCleanHeader(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    _buildCleanRoute(context, ride),

                    const SizedBox(height: 32),

                    _buildTripInfo(context, ride),

                    const SizedBox(height: 32),

                    _buildDriverInfo(context, ride),

                    const SizedBox(height: 32),

                    _buildBookingSection(context, ride),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final ride = controller.selectedRide.value;
        if (ride == null) return const SizedBox.shrink();

        return _buildCleanBottomAction(context, ride);
      }),
    );
  }

  Widget _buildCleanHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: TColors.neutral300.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: TColors.neutral200.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: TColors.textPrimary(context),
                size: 18,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Détails du trajet',
              style: TTypography.headingMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanRoute(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Départ',
                    style: TTypography.labelSmall(context).copyWith(
                      color: TColors.textSecondary(context),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${ride.departureTime.hour.toString().padLeft(2, '0')}:${ride.departureTime.minute.toString().padLeft(2, '0')}',
                    style: TTypography.headingLarge(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: TColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: TColors.success.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${ride.price.toInt()} FCFA',
                  style: TTypography.headingSmall(context).copyWith(
                    color: TColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          Column(
            children: [
              // Departure
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DÉPART',
                          style: TTypography.labelSmall(context).copyWith(
                            color: TColors.textSecondary(context),
                            letterSpacing: 0.5,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ride.departurePoint,
                          style: TTypography.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.only(left: 6, top: 12, bottom: 12),
                width: 2,
                height: 24,
                decoration: BoxDecoration(
                  color: TColors.neutral400.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),

              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: TColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ARRIVÉE',
                          style: TTypography.labelSmall(context).copyWith(
                            color: TColors.textSecondary(context),
                            letterSpacing: 0.5,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ride.arrivalPoint,
                          style: TTypography.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TColors.neutral200.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat(
                    'EEEE d MMMM yyyy',
                    'fr_FR',
                  ).format(ride.departureDate),
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                if (ride.isRecurring && ride.recurringDays != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Récurrent: ${ride.recurringDays!.join(', ')}',
                    style: TTypography.bodySmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripInfo(BuildContext context, RideSearchModel ride) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoTile(
            context,
            icon: Icons.airline_seat_recline_normal_outlined,
            title: 'Places disponibles',
            value: '${ride.availableSeats}',
            color: TColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoTile(
            context,
            icon: Icons.schedule_outlined,
            title: 'Durée estimée',
            value: '25-30 min',
            color: TColors.info,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TTypography.headingMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TTypography.labelSmall(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Enhanced driver info with trust signals
          Row(
            children: [
              // Driver avatar with verification badge
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: TColors.primary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        ride.chauffeurImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Verification badge
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: TColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: TColors.surface(context),
                          width: 2,
                        ),
                      ),
                      child: Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Driver details with enhanced info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ride.chauffeurName,
                            style: TTypography.bodyLarge(
                              context,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        // Trust score
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_user,
                                size: 12,
                                color: TColors.success,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Vérifié',
                                style: TTypography.labelSmall(context).copyWith(
                                  color: TColors.success,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Enhanced rating with more context
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < ride.chauffeurRating.floor()
                                  ? Icons.star_rounded
                                  : index < ride.chauffeurRating
                                  ? Icons.star_half_rounded
                                  : Icons.star_outline_rounded,
                              size: 16,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${ride.chauffeurRating} • 247 trajets',
                          style: TTypography.bodySmall(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: TColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Quick stats
                    Row(
                      children: [
                        _buildQuickStat(
                          context,
                          '98%',
                          'Ponctualité',
                          TColors.info,
                        ),
                        const SizedBox(width: 16),
                        _buildQuickStat(
                          context,
                          '5★',
                          'Moyenne',
                          TColors.warning,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action buttons with enhanced UX
          Row(
            children: [
              // WhatsApp contact - primary action
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _launchWhatsApp(ride.chauffeurPhone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 2,
                  ),
                  icon: Icon(Icons.chat, size: 18),
                  label: Text(
                    'Contacter',
                    style: TTypography.bodySmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // View profile - secondary action
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: TColors.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => _showDriverProfile(context, ride),
                  icon: Icon(
                    Icons.person_outline,
                    color: TColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context,
    String value,
    String label,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$value $label',
          style: TTypography.labelSmall(context).copyWith(
            color: TColors.textSecondary(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSection(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Réservation',
            style: TTypography.headingSmall(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nombre de places', style: TTypography.bodyMedium(context)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: TColors.neutral300.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildCounterButton(
                      icon: Icons.remove,
                      onPressed: () {
                        final current = int.parse(
                          _numberOfSeatsController.text,
                        );
                        if (current > 1) {
                          _numberOfSeatsController.text =
                              (current - 1).toString();
                        }
                      },
                    ),
                    Container(
                      width: 40,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _numberOfSeatsController.text,
                        textAlign: TextAlign.center,
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    _buildCounterButton(
                      icon: Icons.add,
                      onPressed: () {
                        final current = int.parse(
                          _numberOfSeatsController.text,
                        );
                        if (current < ride.availableSeats) {
                          _numberOfSeatsController.text =
                              (current + 1).toString();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(
            icon,
            size: 16,
            color: TColors.textSecondary(Get.context!),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanBottomAction(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(
          top: BorderSide(
            color: TColors.neutral300.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Price summary - clean and minimal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TTypography.labelSmall(
                        context,
                      ).copyWith(color: TColors.textSecondary(context)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${(int.parse(_numberOfSeatsController.text) * ride.price).toInt()} FCFA',
                      style: TTypography.headingMedium(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: TColors.success,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_numberOfSeatsController.text} place${int.parse(_numberOfSeatsController.text) > 1 ? 's' : ''}',
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action button - clean design
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Obx(() {
                if (controller.isRequestingBooking.value) {
                  return ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }

                if (controller.hasRequestedBooking.value) {
                  return ElevatedButton.icon(
                    onPressed: null,
                    icon: Icon(
                      controller.bookingRequestStatus.value == 'approved'
                          ? Icons.check_circle_outline
                          : controller.bookingRequestStatus.value == 'rejected'
                          ? Icons.cancel_outlined
                          : Icons.access_time_outlined,
                      size: 20,
                    ),
                    label: Text(
                      controller.bookingRequestStatus.value == 'approved'
                          ? 'Réservation confirmée'
                          : controller.bookingRequestStatus.value == 'rejected'
                          ? 'Réservation refusée'
                          : 'En attente de confirmation',
                      style: TTypography.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          controller.bookingRequestStatus.value == 'approved'
                              ? TColors.success
                              : controller.bookingRequestStatus.value ==
                                  'rejected'
                              ? TColors.error
                              : TColors.info,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                  );
                }

                return ElevatedButton(
                  onPressed: () {
                    final ridePrice = ride.price;
                    final seatCount =
                        int.tryParse(_numberOfSeatsController.text) ?? 1;
                    final totalAmount = ridePrice * seatCount;
                    final bookingData = {
                      'rideInstanceId': ride.id,
                      'seatsBooked': seatCount,
                    };
                    Get.to(
                      () => const PaymentView(),
                      arguments: {
                        'amount': totalAmount,
                        'bookingData': bookingData,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Réserver maintenant',
                    style: TTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showDriverProfile(BuildContext context, RideSearchModel ride) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder:
                (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: TColors.neutral400.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              // Header
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color: TColors.primary.withOpacity(
                                            0.2,
                                          ),
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          ride.chauffeurImageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ride.chauffeurName,
                                            style: TTypography.headingMedium(
                                              context,
                                            ).copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                size: 18,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${ride.chauffeurRating} (124 avis)',
                                                style: TTypography.bodyMedium(
                                                  context,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: TColors.success
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Chauffeur vérifié',
                                              style: TTypography.labelSmall(
                                                context,
                                              ).copyWith(
                                                color: TColors.success,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            context,
                                            icon: Icons.directions_car_outlined,
                                            title: 'Trajets',
                                            value: '247',
                                            color: TColors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildStatCard(
                                            context,
                                            icon: Icons.schedule_outlined,
                                            title: 'Expérience',
                                            value: '3 ans',
                                            color: TColors.info,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 16),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            context,
                                            icon: Icons.thumb_up_outlined,
                                            title: 'Satisfaction',
                                            value: '98%',
                                            color: TColors.success,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildStatCard(
                                            context,
                                            icon: Icons.access_time_outlined,
                                            title: 'Ponctualité',
                                            value: '95%',
                                            color: TColors.accent,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 24),

                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: TColors.neutral200.withOpacity(
                                          0.4,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'À propos',
                                            style: TTypography.bodyLarge(
                                              context,
                                            ).copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Chauffeur expérimenté et fiable. Véhicule climatisé et confortable. Toujours ponctuel et courtois avec les passagers.',
                                            style: TTypography.bodyMedium(
                                              context,
                                            ).copyWith(
                                              color: TColors.textSecondary(
                                                context,
                                              ),
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: TextButton(
                                        onPressed: () => Get.back(),
                                        style: TextButton.styleFrom(
                                          backgroundColor: TColors.primary
                                              .withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Fermer',
                                          style: TTypography.bodyMedium(
                                            context,
                                          ).copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: TColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // WhatsApp contact section
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: TColors.surface(context),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: TColors.neutral300.withOpacity(
                                            0.3,
                                          ),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contacter le chauffeur',
                                            style: TTypography.bodyLarge(
                                              context,
                                            ).copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(height: 16),

                                          Row(
                                            children: [
                                              // WhatsApp icon
                                              GestureDetector(
                                                onTap:
                                                    () => _launchWhatsApp(
                                                      ride.chauffeurPhone,
                                                    ),
                                                child: Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    color: TColors.success
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12,
                                                        ),
                                                    child: Image.asset(
                                                      'assets/icons/wa_icon.png',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 16),

                                              Expanded(
                                                child: Text(
                                                  'Envoyer un message sur WhatsApp',
                                                  style: TTypography.bodyMedium(
                                                    context,
                                                  ).copyWith(
                                                    color: TColors.textPrimary(
                                                      context,
                                                    ),
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TTypography.headingSmall(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TTypography.labelSmall(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) return;

    // Clean phone number - remove any non-digit characters except +
    String cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // For Android, try WhatsApp with proper intent handling
    final whatsappAppUrl = "whatsapp://send?phone=$cleanPhoneNumber";
    final whatsappWebUrl = "https://wa.me/$cleanPhoneNumber";

    try {
      // First try the app scheme
      bool canLaunchApp = await canLaunch(whatsappAppUrl);
      if (canLaunchApp) {
        await launch(whatsappAppUrl);
        return;
      }

      // If app scheme fails, try web with external app preference
      bool canLaunchWeb = await canLaunch(whatsappWebUrl);
      if (canLaunchWeb) {
        await launch(
          whatsappWebUrl,
          forceSafariVC: false,
          forceWebView: false,
          enableJavaScript: true,
          universalLinksOnly: true, // This helps prefer app over browser
        );
        return;
      }

      // If both fail, show error
      _showWhatsAppError();
    } catch (e) {
      print('Error launching WhatsApp: $e');
      // Try alternative Android intent approach
      try {
        final androidIntentUrl =
            "intent://send?phone=$cleanPhoneNumber#Intent;scheme=whatsapp;package=com.whatsapp;end";
        if (await canLaunch(androidIntentUrl)) {
          await launch(androidIntentUrl);
          return;
        }
      } catch (intentError) {
        print('Android intent also failed: $intentError');
      }

      _showWhatsAppError();
    }
  }

  void _showWhatsAppError() {
    Get.snackbar(
      'WhatsApp non disponible',
      'Veuillez installer WhatsApp pour contacter le chauffeur',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange[100],
      colorText: Colors.orange[800],
      duration: const Duration(seconds: 3),
    );
  }
}
