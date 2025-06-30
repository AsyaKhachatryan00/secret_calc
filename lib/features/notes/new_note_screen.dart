import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/widgets/custom_button.dart';
import 'package:secret_calc/features/main/controller/main_controller.dart';
import 'package:secret_calc/models/editing_model.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({required this.model, super.key});
  final EditingModel model;

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  late final MainController _controller;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<MainController>()) {
      _controller = Get.find<MainController>();
    } else {
      _controller = Get.put(MainController());
    }

    if (widget.model.note != null) {
      final note = widget.model.note;
      _controller.noteController.text = note?.note ?? '';
      _controller.filePath = note?.img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(onPressed: () => _controller.onBackPressed()),
        title: Text(
          widget.model.data,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  controller: _controller.noteController,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppColors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Note',
                    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.white.withAlpha(70),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GetBuilder<MainController>(
                builder: (controller) => GestureDetector(
                  onTap: () async => await _showPhotoOptions(),
                  child: Container(
                    width: 315.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: _controller.filePath == null
                        ? DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              padding: EdgeInsets.zero,
                              radius: Radius.circular(15.r),
                              color: AppColors.primary,
                              dashPattern: [3, 3],
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: 315.w,
                              height: 250.h,
                              child: Text(
                                'Photo',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              _controller.filePath!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: 250.h),
              CustomButton(
                data: 'Save',
                onTap: () => widget.model.note != null
                    ? _controller.updateNote(widget.model.note!.id)
                    : _controller.onsaveNote(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showPhotoOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Camera',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.blue,
                fontSize: 17.sp,
              ),
            ),
            onPressed: () {
              Get.back();
              _controller.onImagePick(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Gallery',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.blue,
                fontSize: 17.sp,
              ),
            ),
            onPressed: () {
              Get.back();
              _controller.onImagePick(ImageSource.gallery);
            },
          ),
          if (_controller.filePath != null)
            CupertinoActionSheetAction(
              child: Text(
                'Delete photo',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.red,
                  fontSize: 17.sp,
                ),
              ),
              onPressed: () {
                Get.back();
                _controller.deleteImage();
              },
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
