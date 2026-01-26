import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Free route visualization widget - no Google Maps API needed
/// Uses a stylized visual representation of the journey
class RoutePreview extends StatelessWidget {
  final String origin;
  final String destination;
  final String? duration;
  final String? distance;
  final double height;

  const RoutePreview({
    super.key,
    required this.origin,
    required this.destination,
    this.duration,
    this.distance,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withAlpha(15),
            AppColors.accent.withAlpha(30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withAlpha(40)),
      ),
      child: Stack(
        children: [
          // Background pattern (road visualization)
          Positioned.fill(child: CustomPaint(painter: _RoutePainter())),

          // Route info overlay
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Origin/Destination column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Origin
                      Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(100),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              origin,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      // Connecting line
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Container(
                          width: 2.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.success],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      // Destination
                      Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.success.withAlpha(100),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              destination,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Stats column
                if (distance != null || duration != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (distance != null) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.route,
                                size: 16.w,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                distance!,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                        if (duration != null) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16.w,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(duration!, style: AppTextStyles.bodyMedium),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the stylized route background
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withAlpha(20)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw a curved path representing the route
    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.cubicTo(
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.9,
      size.width,
      size.height * 0.7,
    );
    canvas.drawPath(path, paint);

    // Draw dashed effect
    final dashPaint = Paint()
      ..color = AppColors.primary.withAlpha(40)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.5);
    path2.cubicTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.5,
    );
    canvas.drawPath(path2, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
