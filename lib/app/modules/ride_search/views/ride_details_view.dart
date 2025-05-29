import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class RideDetailsView extends StatelessWidget {
  final RideSearchController controller = Get.find();
  final _numberOfSeatsController = TextEditingController(text: '1');
  final _messageController = TextEditingController();

  RideDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      appBar: AppBar(
        title: Text(
          'Détails du trajet',
          style: TTypography.headingMedium(context),
        ),
        elevation: 0,
        backgroundColor: TColors.background(context),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final ride = controller.selectedRide.value;

        if (ride == null) {
          return Center(
            child: Text(
              'Trajet non trouvé',
              style: TTypography.bodyLarge(context),
            ),
          );
        }

        return Stack(
          children: [
            // Main content
            SingleChildScrollView(
              padding: const EdgeInsets.all(TSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ride overview card
                  _buildRideOverviewCard(context, ride),

                  const SizedBox(height: TSpacing.xl),

                  // Chauffeur info
                  _buildChauffeurInfoCard(context, ride),

                  const SizedBox(height: TSpacing.xl),

                  // Ride details
                  _buildRideDetailsCard(context, ride),

                  const SizedBox(height: TSpacing.xl),

                  // Booking options
                  _buildBookingOptionsCard(context, ride),

                  // Bottom space for the button
                  const SizedBox(height: 100),
                ],
              ),
            ),

            // Fixed book button at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(TSpacing.lg),
                decoration: BoxDecoration(
                  color: TColors.surface(context),
                  boxShadow: TShadows.medium,
                ),
                child: Row(
                  children: [
                    // Price info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Prix par personne',
                          style: TTypography.labelSmall(
                            context,
                          ).copyWith(color: TColors.textSecondary(context)),
                        ),
                        Text(
                          '${ride.price.toInt()} FCFA',
                          style: TTypography.headingMedium(
                            context,
                          ).copyWith(color: TColors.success),
                        ),
                      ],
                    ),

                    const SizedBox(width: TSpacing.lg),

                    // Book button
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: Obx(() {
                          if (controller.isRequestingBooking.value) {
                            return ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: TRadius.buttonRadius,
                                ),
                                elevation: 0,
                              ),
                              child: const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            );
                          }

                          if (controller.hasRequestedBooking.value) {
                            return ElevatedButton.icon(
                              onPressed: null,
                              icon: Icon(
                                controller.bookingRequestStatus.value ==
                                        'approved'
                                    ? Icons.check_circle
                                    : controller.bookingRequestStatus.value ==
                                        'rejected'
                                    ? Icons.cancel
                                    : Icons.hourglass_top,
                              ),
                              label: Text(
                                controller.bookingRequestStatus.value ==
                                        'approved'
                                    ? 'Réservation confirmée'
                                    : controller.bookingRequestStatus.value ==
                                        'rejected'
                                    ? 'Réservation refusée'
                                    : 'En attente de confirmation',
                                style: TTextStyles.buttonStatic,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.bookingRequestStatus.value ==
                                            'approved'
                                        ? TColors.success
                                        : controller
                                                .bookingRequestStatus
                                                .value ==
                                            'rejected'
                                        ? TColors.error
                                        : TColors.info,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: TRadius.buttonRadius,
                                ),
                                elevation: 0,
                              ),
                            );
                          }

                          return ElevatedButton.icon(
                            onPressed:
                                () => _showBookingConfirmationDialog(
                                  context,
                                  ride,
                                ),
                            icon: const Icon(Icons.check_circle),
                            label: Text(
                              'Réserver',
                              style: TTextStyles.buttonStatic,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: TRadius.buttonRadius,
                              ),
                              elevation: 0,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRideOverviewCard(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.lg),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and time
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSpacing.md,
                  vertical: TSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: TRadius.cardRadius,
                ),
                child: Text(
                  '${ride.departureTime.hour.toString().padLeft(2, '0')}:${ride.departureTime.minute.toString().padLeft(2, '0')}',
                  style: TTypography.headingMedium(
                    context,
                  ).copyWith(color: TColors.primary),
                ),
              ),

              const SizedBox(width: TSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSpacing.md,
                  vertical: TSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: TColors.success.withOpacity(0.1),
                  borderRadius: TRadius.cardRadius,
                ),
                child: Text(
                  '${ride.price.toInt()} FCFA',
                  style: TTypography.labelLarge(context).copyWith(
                    color: TColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: TSpacing.lg),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? TColors.neutral800
                    : TColors.neutral200,
          ),

          const SizedBox(height: TSpacing.lg),

          // Route visualization
          _buildRouteVisualization(context, ride),
        ],
      ),
    );
  }

  Widget _buildRouteVisualization(BuildContext context, RideSearchModel ride) {
    return Column(
      children: [
        // Departure
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.trip_origin,
                color: TColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Départ',
                    style: TTypography.labelSmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ride.departurePoint,
                    style: TTypography.headingSmall(context),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Connection line
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 40,
                color: TColors.primary.withOpacity(0.3),
              ),
            ],
          ),
        ),

        // Arrival
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: TColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: TColors.accent,
                size: 24,
              ),
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arrivée',
                    style: TTypography.labelSmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ride.arrivalPoint,
                    style: TTypography.headingSmall(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChauffeurInfoCard(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.lg),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Votre chauffeur', style: TTypography.headingSmall(context)),

          const SizedBox(height: TSpacing.md),

          Row(
            children: [
              // Chauffeur image
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: TColors.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(ride.chauffeurImageUrl, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(width: TSpacing.lg),

              // Chauffeur info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ride.chauffeurName,
                      style: TTypography.headingSmall(context),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < ride.chauffeurRating.floor()
                                  ? Icons.star
                                  : index < ride.chauffeurRating
                                  ? Icons.star_half
                                  : Icons.star_border,
                              size: 18,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ride.chauffeurRating.toString(),
                          style: TTypography.bodyMedium(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 16,
                          color: TColors.success,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Chauffeur vérifié',
                          style: TTypography.bodySmall(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSpacing.lg),

          OutlinedButton(
            onPressed: () {
              // This would typically navigate to the chauffeur's profile
              Get.snackbar(
                'Profil du chauffeur',
                'Cette fonctionnalité sera bientôt disponible',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: TColors.primary),
              shape: RoundedRectangleBorder(borderRadius: TRadius.buttonRadius),
            ),
            child: Text(
              'Voir le profil',
              style: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideDetailsCard(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.lg),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Détails du trajet', style: TTypography.headingSmall(context)),

          const SizedBox(height: TSpacing.lg),

          // Available seats
          _buildDetailRow(
            context,
            icon: Icons.airline_seat_recline_normal,
            iconColor: TColors.primary,
            title: 'Places disponibles',
            value:
                '${ride.availableSeats} place${ride.availableSeats > 1 ? 's' : ''}',
          ),

          const SizedBox(height: TSpacing.md),

          // Price
          _buildDetailRow(
            context,
            icon: Icons.attach_money,
            iconColor: TColors.success,
            title: 'Prix par personne',
            value: '${ride.price.toInt()} FCFA',
          ),

          const SizedBox(height: TSpacing.md),

          // Estimated duration (mock data)
          _buildDetailRow(
            context,
            icon: Icons.timelapse,
            iconColor: TColors.info,
            title: 'Durée estimée',
            value: '25-30 minutes',
          ),

          if (ride.isRecurring && ride.recurringDays != null) ...[
            const SizedBox(height: TSpacing.md),

            // Recurring days
            _buildDetailRow(
              context,
              icon: Icons.repeat,
              iconColor: TColors.accent,
              title: 'Jours de récurrence',
              value: ride.recurringDays!.join(', '),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBookingOptionsCard(BuildContext context, RideSearchModel ride) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.lg),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Options de réservation',
            style: TTypography.headingSmall(context),
          ),

          const SizedBox(height: TSpacing.md),

          Text(
            'Vous pouvez ajouter un message pour le chauffeur ou spécifier des besoins particuliers.',
            style: TTypography.bodySmall(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.lg),

          // Number of seats selection
          Row(
            children: [
              Text('Nombre de places', style: TTypography.bodyMedium(context)),

              const Spacer(),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.neutral300),
                  borderRadius: TRadius.inputRadius,
                ),
                child: Row(
                  children: [
                    // Decrement button
                    IconButton(
                      onPressed: () {
                        final currentValue = int.parse(
                          _numberOfSeatsController.text,
                        );
                        if (currentValue > 1) {
                          _numberOfSeatsController.text =
                              (currentValue - 1).toString();
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        color: TColors.textSecondary(context),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                    ),

                    // Value display
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _numberOfSeatsController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TTypography.bodyMedium(context),
                        readOnly: true,
                      ),
                    ),

                    // Increment button
                    IconButton(
                      onPressed: () {
                        final currentValue = int.parse(
                          _numberOfSeatsController.text,
                        );
                        if (currentValue < ride.availableSeats) {
                          _numberOfSeatsController.text =
                              (currentValue + 1).toString();
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        color: TColors.textSecondary(context),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSpacing.lg),

          // Message field
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Message pour le chauffeur (optionnel)',
              border: OutlineInputBorder(borderRadius: TRadius.inputRadius),
              enabledBorder: OutlineInputBorder(
                borderRadius: TRadius.inputRadius,
                borderSide: BorderSide(color: TColors.neutral300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: TRadius.inputRadius,
                borderSide: BorderSide(color: TColors.primary),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),

        const SizedBox(width: TSpacing.md),

        Text(title, style: TTypography.bodyMedium(context)),

        const Spacer(),

        Text(
          value,
          style: TTypography.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Future<void> _showBookingConfirmationDialog(
    BuildContext context,
    RideSearchModel ride,
  ) async {
    final numberOfSeats = int.parse(_numberOfSeatsController.text);
    final totalPrice = numberOfSeats * ride.price;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmer la réservation',
            style: TTypography.headingMedium(context),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vous êtes sur le point de réserver :',
                  style: TTypography.bodyMedium(context),
                ),

                const SizedBox(height: TSpacing.md),

                // Ride summary
                Container(
                  padding: const EdgeInsets.all(TSpacing.md),
                  decoration: BoxDecoration(
                    color: TColors.neutral100,
                    borderRadius: TRadius.cardRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ride.departurePoint} → ${ride.arrivalPoint}',
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Le ${DateFormat('EEEE d MMMM', 'fr_FR').format(ride.departureDate)} à ${ride.departureTime.hour.toString().padLeft(2, '0')}:${ride.departureTime.minute.toString().padLeft(2, '0')}',
                        style: TTypography.bodySmall(context),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$numberOfSeats place${numberOfSeats > 1 ? 's' : ''}',
                            style: TTypography.bodyMedium(context),
                          ),

                          Text(
                            '$totalPrice FCFA',
                            style: TTypography.bodyMedium(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: TColors.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: TSpacing.lg),

                Text(
                  'Le chauffeur devra approuver votre demande pour confirmer la réservation.',
                  style: TTypography.bodySmall(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Annuler',
                style: TextStyle(color: TColors.textSecondary(context)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.requestBooking(
                  ride,
                  numberOfSeats,
                  _messageController.text.isEmpty
                      ? null
                      : _messageController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
