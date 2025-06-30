import 'core/utils/shared_prefs.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  final SharedPrefs prefs;

  AppService({required this.prefs});

  static AppService get to => Get.find();

  RxInt currenIndex = 0.obs;
}
