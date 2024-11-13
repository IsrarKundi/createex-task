import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  static const String baseUrl = 'https://cricle-app.azurewebsites.net';

  // Observable list to store circles data
  var circles = <Map<String, dynamic>>[].obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCircles();
  }

  Future<void> fetchCircles() async {
    final url = Uri.parse('$baseUrl/api/circle/all');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      final response = await get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        circles.value = List<Map<String, dynamic>>.from(data['circles']);
      } else {
        Get.snackbar('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again later.');
    }
  }
}
