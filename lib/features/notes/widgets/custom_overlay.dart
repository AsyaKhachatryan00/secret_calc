import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart'; 
import 'package:secret_calc/models/note_model.dart';

class NoteOverlay extends StatelessWidget {
final NoteModel note;

  const NoteOverlay({
    super.key,
    required this.note
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding:   EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 315.w,
                  height: 250.h,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r)),
                child: Image.memory(
                  note.img
                ),
              ),
                SizedBox(height: 12.h),
              Text(
                note.note,
                maxLines: 3,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.white
                )
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }
}
