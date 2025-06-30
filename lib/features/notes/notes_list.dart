import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/constants/app_assets.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/widgets/custom_button.dart';
import 'package:secret_calc/core/widgets/dialog_screen.dart';
import 'package:secret_calc/features/main/controller/main_controller.dart';
import 'package:secret_calc/features/notes/widgets/custom_edit_icon.dart';
import 'package:secret_calc/features/notes/widgets/custom_icon.dart';
import 'package:secret_calc/features/notes/widgets/custom_overlay.dart';
import 'package:secret_calc/models/editing_model.dart';
import 'package:secret_calc/models/note_model.dart';

import '../../core/route/routes.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  late final MainController _controller;
  late final List<NoteModel> _notes;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<MainController>()) {
      _controller = Get.find<MainController>();
    } else {
      _controller = Get.put(MainController());
    }
    _notes = _controller.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text(
          'All Notes',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 25.w),
            child: InkWell(
              child: SvgPicture.asset(AppSvgs.settings),
              onTap: () => Get.toNamed(RouteLink.settings),
            ),
          ),
        ],
      ),

      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _notes.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => showNoteOverlay(context, _notes[index]),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => Get.toNamed(
                                RouteLink.note,
                                id: 1,
                                arguments: EditingModel(
                                  data: 'Editing a note',
                                  note: _notes[index],
                                ),
                              ),
                              backgroundColor: AppColors.primary,
                              borderRadius: BorderRadius.circular(16.r),
                              icon: CustomEditIcon.edit,
                            ),

                            SlidableAction(
                              onPressed: (context) => showCupertinoDialog(
                                context: context,
                                builder: (context) => DialogScreen(
                                  title: 'SecretCalc: CheatPad',
                                  onTap: () => _controller.deleteNotoe(index),
                                  content:
                                      'Are you sure you want to delete this note?',
                                ),
                              ),
                              backgroundColor: AppColors.primary,
                              icon: CustomTrashIcon.trash,
                              foregroundColor: AppColors.red,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.memory(
                                  _notes[index].img,
                                  width: 81.w,
                                  height: 64.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  _notes[index].note,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: 14.sp,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomButton(
                onTap: () => Get.toNamed(
                  RouteLink.note,
                  id: 1,
                  arguments: EditingModel(data: 'Adding a note'),
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'Add a note ',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: ' +',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void showNoteOverlay(BuildContext context, NoteModel note) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(60),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,

        insetPadding: const EdgeInsets.all(16),
        child: NoteOverlay(note: note),
      ),
    );
  }
}
