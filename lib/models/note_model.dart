import 'dart:convert';
import 'dart:typed_data';

class NoteModel {
  final String id;
  final String note;
  final Uint8List img;

  NoteModel({required this.id, required this.note, required this.img});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(id: json['id'], note: json['note'],
     img: Uint8List.fromList(json['img'].cast<int>().toList()),);
  }

  Map<String, dynamic> toJson() => {'id': id, 'note': note, 'img': img};

  String encode() => jsonEncode(toJson());

  static NoteModel decode(String jsonString) =>
      NoteModel.fromJson(jsonDecode(jsonString));
}
