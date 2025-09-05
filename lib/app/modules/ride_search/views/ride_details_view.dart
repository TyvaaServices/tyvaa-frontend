import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';



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

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: TColors.background(context),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
                onPressed: () => Get.back(),
              ),
              title: Text(
                'Détails du trajet',
                style: TTypography.headingMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildCleanRoute(context, ride),
                    const SizedBox(height: 24),
                    _buildTripInfo(context, ride),
                    const SizedBox(height: 24),
                    _buildDriverInfo(context, ride),
                    const SizedBox(height: 24),
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

  

    Widget _buildCleanRoute(BuildContext context, Rideinstance ride) {
    final rideModel = ride.ride;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Départ',
                      style: TTypography.labelSmall(context).copyWith(
                        color: TColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rideModel?.time ?? '-',
                      style: TTypography.headingLarge(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: TColors.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${rideModel?.price ?? '-'} FCFA',
                  style: TTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.w700,
                    color: TColors.primary,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.trip_origin, color: TColors.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DÉPART',
                            style: TTypography.labelSmall(context).copyWith(
                              color: TColors.textSecondary(context),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rideModel?.departure ?? '-',
                            style: TTypography.bodyLarge(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                  width: 1,
                  height: 24,
                  color: TColors.neutral300,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: TColors.accent, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ARRIVÉE',
                            style: TTypography.labelSmall(context).copyWith(
                              color: TColors.textSecondary(context),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rideModel?.destination ?? '-',
                            style: TTypography.bodyLarge(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                    ride.rideDate,
                    style: TTypography.bodyMedium(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (rideModel?.isRecurring == true &&
                      rideModel?.recurrence != null)
                    ...[
                      const SizedBox(height: 4),
                      Text(
                        'Récurrent: ${rideModel?.recurrence?.join(', ') ?? ''}',
                        style: TTypography.bodySmall(context)
                            .copyWith(color: TColors.textSecondary(context)),
                      ),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripInfo(BuildContext context, Rideinstance ride) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoTile(
            context,
            icon: Icons.airline_seat_recline_normal_outlined,
            title: 'Places disponibles',
            value: ride.seatsAvailable.toString(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoTile(
            context,
            icon: Icons.schedule_outlined,
            title: 'Statut',
            value: ride.status,
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
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 24, color: TColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: TTypography.headingMedium(context).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TTypography.labelSmall(context).copyWith(color: TColors.textSecondary(context)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context, Rideinstance ride) {
    final driver = ride.ride?.driver;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              // backgroundImage: driver?.profileImage != null && driver!.profileImage.isNotEmpty
              //     ? NetworkImage(driver.profileImage!)
              //     : null,
              child: (driver?.profileImage?.isEmpty ?? true)
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver?.fullName ?? '-',
                    style: TTypography.bodyLarge(context).copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    driver?.phoneNumber ?? '-',
                    style: TTypography.bodySmall(context).copyWith(color: TColors.textSecondary(context)),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSection(BuildContext context, Rideinstance ride) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Nombre de places', style: TTypography.bodyLarge(context)),
            Row(
              children: [
                _buildCounterButton(
                  icon: Icons.remove,
                  onPressed: () {
                    final current = int.parse(_numberOfSeatsController.text);
                    if (current > 1) {
                      _numberOfSeatsController.text = (current - 1).toString();
                    }
                  },
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    _numberOfSeatsController.text,
                    textAlign: TextAlign.center,
                    style: TTypography.bodyLarge(context).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                _buildCounterButton(
                  icon: Icons.add,
                  onPressed: () {
                    final current = int.parse(_numberOfSeatsController.text);
                    if (ride.seatsAvailable != null && current < ride.seatsAvailable!) {
                      _numberOfSeatsController.text = (current + 1).toString();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: TColors.textPrimary(Get.context!)),
    );
  }

  Widget _buildCleanBottomAction(BuildContext context, Rideinstance ride) {
    final rideModel = ride.ride;
    if (rideModel == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(top: BorderSide(color: TColors.neutral300.withOpacity(0.5))),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: TTypography.bodyMedium(context).copyWith(color: TColors.textSecondary(context)),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(int.parse(_numberOfSeatsController.text) * (rideModel.price ?? 0)).toInt()} FCFA',
                  style: TTypography.headingMedium(context).copyWith(fontWeight: FontWeight.w700, color: TColors.primary),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final ridePrice = rideModel.price ?? 0;
                final seatCount = int.tryParse(_numberOfSeatsController.text) ?? 1;
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
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Réserver',
                style: TTypography.bodyLarge(context).copyWith(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  
}
