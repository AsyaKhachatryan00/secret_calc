import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_calc/core/confing/constants/storage_keys.dart';
import 'package:secret_calc/core/utils/shared_prefs.dart';
import 'package:secret_calc/features/calculator/calculator.dart';
import 'package:secret_calc/models/note_model.dart';
import 'package:uuid/uuid.dart';

class MainController extends GetxController {
  late RxList<NoteModel> notes = <NoteModel>[].obs;
  final TextEditingController noteController = TextEditingController();
  XFile? _selectedImage;
  Uint8List? filePath;

  final storage = SharedPrefs();

  @override
  void onInit() {
    super.onInit();
    storage.init().then((onValue) {
      notes.value = getNotes();
    });
  }

  Future<void> onImagePick(ImageSource source) async {
    if (_selectedImage != null) {}

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      _selectedImage = XFile(picked.path);
      if (_selectedImage != null) {
        final bytes = await _selectedImage?.readAsBytes();
        if (bytes != null) {
          filePath = bytes;
        }
      }
    }
  }

  void onsaveNote() {
    if (noteController.text.isEmpty && filePath == null) {
      Get.snackbar(
        'Please fill fields!',
        '',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (noteController.text.isEmpty) {
      Get.snackbar(
        'Note is empty!',
        '',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (filePath == null) {
      Get.snackbar(
        'Add image!',
        '',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final NoteModel note = NoteModel.fromJson({
        'id': const Uuid().v4(),
        'note': noteController.text,
        'img': filePath,
      });
      notes.add(note);
      _onClear();
      addNote(note);
      Get.back(id: 1);
    }
  }

  void _onClear() {
    noteController.clear();
    deleteImage();
  }

  void addNote(NoteModel element) async {
    List<String> existingEntries = storage.getStringList(
      StorageKeys.notesListKey,
    );

    existingEntries.add(element.encode());

    await storage.setStringList(StorageKeys.notesListKey, existingEntries);
  }

  void deleteImage() {
    _selectedImage = null;
    filePath = null;
    update();
  }

  void updateNote(final String id) async {
    if (noteController.text.isEmpty && filePath == null) {
      Get.snackbar(
        'Please fill fields!',
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
      );
    } else if (noteController.text.isEmpty) {
      Get.snackbar(
        'Note is empty!',
        '',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (filePath == null) {
      Get.snackbar(
        'Add image!',
        '',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final NoteModel note = NoteModel.fromJson({
        'id': id,
        'note': noteController.text,
        'img': filePath,
      });

      final element = notes.firstWhereOrNull(
        (element) => element.id == note.id,
      );
      if (element != null) {
        final index = notes.indexOf(element);
        notes
          ..removeAt(index)
          ..insert(index, note);
      }
      saveNotes();
      _onClear();
      Get.back(id: 1);
    }
  }

  void saveNotes() async {
    await storage.setStringList(
      StorageKeys.notesListKey,
      notes.map((entry) => entry.encode()).toList(),
    );
  }

  void deleteNotoe(int index) {
    notes.removeAt(index);
    List<String> existingEntries = storage.getStringList(
      StorageKeys.notesListKey,
    );
    existingEntries.removeAt(index);
    storage.setStringList(StorageKeys.notesListKey, existingEntries);
    Get.back();
  }

  void onBackPressed() {
    noteController.clear();
    _selectedImage = null;
    filePath = null;
    Get.back(id: 1);
  }

  List<NoteModel> getNotes() {
    List<String> storedEntries = storage.getStringList(
      StorageKeys.notesListKey,
    );

    return storedEntries.map((entry) => NoteModel.decode(entry)).toList();
  }

  void onTapOpenCalc() {
    Get.bottomSheet(
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: CalculatorPage(),
      ),
      isScrollControlled: true,
    );
  }
}
