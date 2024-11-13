import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../home/views/home_screen.dart';

class LoginController extends GetxController {
  static const String baseUrl = 'https://cricle-app.azurewebsites.net';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs; // Track loading state

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    isLoading.value = true; // Set loading to true when request starts

    final url = Uri.parse('$baseUrl/api/auth/login');
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    try {

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'];

        // Store the token securely
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        isLoading.value = false;

        // Navigate to MainScreen
        Get.to(() => MainScreen());
      } else {
        isLoading.value = false;

        Get.snackbar('Error', 'Login failed. Please try again.');
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar('Error', 'An error occurred. Please try again later.');
    }
  }


  Future<void> fetchCircles() async {
    final url = Uri.parse('$baseUrl/api/circle/all');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      final response = await http.get(
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
      } else {
        Get.snackbar('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again later.');
    }
  }
}
