import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/tyvaa_map.dart';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.slate200,
              backgroundImage: const AssetImage('assets/icons/nav_profile.png'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Arjun Singh",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  Text(
                    "En ligne",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.slate900),
        actions: [
          IconButton(
            icon: Icon(Icons.call_outlined, size: 22.w),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded, size: 22.w),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Safety Banner (Compact)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            color: AppColors.info.withValues(alpha: 0.05),
            child: Row(
              children: [
                Icon(Icons.shield_outlined, size: 14.w, color: AppColors.info),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Paiement à l'arrivée uniquement. Restez vigilant.",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              reverse: false, // For simple mock
              children: [
                _buildDateDivider("Aujourd'hui"),
                _buildMsg(
                  "Salut Arjun, tu pars d'où exactement ?",
                  isMe: true,
                  time: "10:05",
                ),
                _buildMsg(
                  "Bonjour ! Je serai à la gare routière, près de la station Total.",
                  isMe: false,
                  time: "10:08",
                ),
                _buildMsg(
                  "D'accord, j'arrive dans 10 mins.",
                  isMe: true,
                  time: "10:10",
                ),
                _buildLocationMsg(context, isMe: false, time: "10:12"),
              ],
            ),
          ),

          // Input Area (Modern & Visible)
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Quick Actions
                IconButton(
                  icon: Icon(
                    Icons.add_location_alt_rounded,
                    color: AppColors.primary,
                    size: 24.w,
                  ),
                  onPressed: () => _showSendLocationSheet(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 12.w),

                // TextField Container
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.slate100,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Écrire un message...",
                        hintStyle: TextStyle(
                          color: AppColors.slate400,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Send Button
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20.w,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSendLocationSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.slate200,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Partager votre position",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              "Aidez le conducteur à vous retrouver facilement.",
              style: TextStyle(color: AppColors.slate500, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                height: 150.h,
                width: double.infinity,
                child: const TyvaaMap(
                  isInteractive: false,
                  showControls: false,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Position envoyée',
                    'Le conducteur peut maintenant voir votre position.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.success,
                    colorText: Colors.white,
                  );
                },
                icon: const Icon(Icons.send_rounded),
                label: const Text("Envoyer ma position actuelle"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDateDivider(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.slate400,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildMsg(String txt, {required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: isMe ? Radius.circular(20.r) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(20.r),
              ),
              boxShadow: !isMe
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              txt,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.slate900,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h, left: 4.w, right: 4.w),
            child: Text(
              time,
              style: TextStyle(fontSize: 10.sp, color: AppColors.slate400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMsg(
    BuildContext context, {
    required bool isMe,
    required String time,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            width: 200.w,
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: !isMe
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    color: AppColors.slate200,
                    child: Icon(
                      Icons.map_rounded,
                      size: 40.w,
                      color: AppColors.slate400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 16.w,
                        color: isMe ? Colors.white70 : AppColors.secondary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "Ma position",
                        style: TextStyle(
                          color: isMe ? Colors.white : AppColors.slate700,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h, left: 4.w, right: 4.w),
            child: Text(
              time,
              style: TextStyle(fontSize: 10.sp, color: AppColors.slate400),
            ),
          ),
        ],
      ),
    );
  }
}
