import 'package:get/get.dart';
import 'package:hoomss/admob/ad_helper.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/ui/home/home_view.dart';

class SplashViewModel extends GetxController {
  final DatabaseService _databaseService = Get.put(DatabaseService());
  @override
  void onInit() {
    adHelper().requestTrackingPermission();
    _databaseService.databaseConfig();

    _loadData();

    super.onInit();
  }
}

Future<bool> _loadData() async {
  try {
    await Future.delayed(
      const Duration(milliseconds: 1111),
    );

    Get.off(
      () => const HomeView(),
    );

    return true;
  } catch (e) {
    return false;
  }
}
