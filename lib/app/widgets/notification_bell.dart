import 'package:flutter/material.dart';

import '../themes/design_system.dart';

class NotificationBell extends StatefulWidget {
  final bool hasNotifications;
  final int unreadCount;
  final VoidCallback onTap;
  final Color? bellColor;
  final Color? badgeColor;
  final double size;

  const NotificationBell({
    super.key,
    required this.hasNotifications,
    required this.unreadCount,
    required this.onTap,
    this.bellColor,
    this.badgeColor,
    this.size = 24,
  });

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell>
    with TickerProviderStateMixin {
  late AnimationController _bellController;
  late AnimationController _pulseController;
  late Animation<double> _bellAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Bell shake animation
    _bellController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bellAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bellController, curve: Curves.elasticOut),
    );

    // Pulse animation for badge
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations if there are notifications
    if (widget.hasNotifications) {
      _startAnimations();
    }
  }

  @override
  void didUpdateWidget(NotificationBell oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Start animations when new notifications arrive
    if (widget.hasNotifications && !oldWidget.hasNotifications) {
      _startAnimations();
    } else if (!widget.hasNotifications) {
      _stopAnimations();
    }
  }

  void _startAnimations() {
    _bellController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  void _stopAnimations() {
    _bellController.stop();
    _pulseController.stop();
    _bellController.reset();
    _pulseController.reset();
  }

  @override
  void dispose() {
    _bellController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(TRadius.md),
      child: Ink(
        decoration: BoxDecoration(
          color: TColors.surface(context),
          borderRadius: BorderRadius.circular(TRadius.md),
          boxShadow:
              widget.hasNotifications
                  ? [
                    BoxShadow(
                      color: (widget.badgeColor ?? TColors.error).withOpacity(
                        0.2,
                      ),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                    ...TShadows.subtle,
                  ]
                  : TShadows.subtle,
          border: Border.all(
            color:
                widget.hasNotifications
                    ? (widget.badgeColor ?? TColors.error).withOpacity(0.3)
                    : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(TRadius.md),
          child: Container(
            padding: EdgeInsets.all(TSpacing.md),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Bell icon with animation
                AnimatedBuilder(
                  animation: _bellAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle:
                          widget.hasNotifications
                              ? _bellAnimation.value *
                                  0.1 *
                                  (widget.hasNotifications ? 1 : 0)
                              : 0,
                      child: CustomPaint(
                        size: Size(widget.size, widget.size),
                        painter: NotificationBellPainter(
                          color:
                              widget.bellColor ??
                              (widget.hasNotifications
                                  ? TColors.error
                                  : TColors.textPrimary(context)),
                          hasNotifications: widget.hasNotifications,
                        ),
                      ),
                    );
                  },
                ),

                // Notification badge
                if (widget.hasNotifications && widget.unreadCount > 0)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: widget.badgeColor ?? TColors.error,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: TColors.surface(context),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (widget.badgeColor ?? TColors.error)
                                      .withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              widget.unreadCount > 99
                                  ? '99+'
                                  : widget.unreadCount.toString(),
                              style: TTextStyles.caption(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // Simple dot indicator for when count is 0 but has notifications
                if (widget.hasNotifications && widget.unreadCount == 0)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: widget.badgeColor ?? TColors.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: TColors.surface(context),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (widget.badgeColor ?? TColors.error)
                                      .withOpacity(0.5),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

class NotificationBellPainter extends CustomPainter {
  final Color color;
  final bool hasNotifications;

  NotificationBellPainter({
    required this.color,
    required this.hasNotifications,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final fillPaint =
        Paint()
          ..color = color.withOpacity(hasNotifications ? 0.1 : 0.05)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final bellWidth = size.width * 0.7;
    final bellHeight = size.height * 0.8;

    // Draw bell body
    final bellRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: center.translate(0, -size.height * 0.05),
        width: bellWidth,
        height: bellHeight * 0.7,
      ),
      topLeft: Radius.circular(bellWidth * 0.5),
      topRight: Radius.circular(bellWidth * 0.5),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    );

    // Fill bell body
    canvas.drawRRect(bellRect, fillPaint);
    canvas.drawRRect(bellRect, paint);

    // Draw bell mouth (bottom rim)
    final mouthY = center.dy + bellHeight * 0.25;
    canvas.drawLine(
      Offset(center.dx - bellWidth * 0.4, mouthY),
      Offset(center.dx + bellWidth * 0.4, mouthY),
      paint..strokeWidth = 3.0,
    );

    // Draw bell clapper
    final clapperCenter = Offset(center.dx, mouthY - bellHeight * 0.15);
    canvas.drawCircle(
      clapperCenter,
      size.width * 0.06,
      paint
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0,
    );

    // Draw bell top mounting
    final mountY = center.dy - bellHeight * 0.4;
    canvas.drawLine(
      Offset(center.dx - size.width * 0.1, mountY),
      Offset(center.dx + size.width * 0.1, mountY),
      paint
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke,
    );

    // Draw sound waves if there are notifications
    if (hasNotifications) {
      final wavePaint =
          Paint()
            ..color = color.withOpacity(0.6)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;

      // Draw 3 concentric wave arcs
      for (int i = 1; i <= 3; i++) {
        final waveRadius = bellWidth * 0.3 * i;
        final waveCenter = Offset(
          center.dx + bellWidth * 0.4,
          center.dy - bellHeight * 0.1,
        );

        canvas.drawArc(
          Rect.fromCenter(
            center: waveCenter,
            width: waveRadius * 2,
            height: waveRadius * 2,
          ),
          -0.5, // Start angle
          1.0, // Sweep angle
          false,
          wavePaint..color = color.withOpacity(0.8 - (i * 0.2)),
        );
      }
    }
  }

  @override
  bool shouldRepaint(NotificationBellPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.hasNotifications != hasNotifications;
  }
}
