import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static const String baseUrl = 'https://cricle-app.azurewebsites.net';
  RxString profilePicture = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxBool isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    // You can fetch profile details when the controller is initialized
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No token found");
      }

      final url = Uri.parse('$baseUrl/api/auth/profile');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        var data = jsonDecode(response.body);

        if (data['success'] == true) {
          // Extract the profile data
          var profileData = data['data'];
          print(profileData);
          // Update the profile details
          profilePicture.value = profileData['profilePicture'] ?? '';
          name.value = profileData['name'] ?? 'Unknown';
          email.value = profileData['email'] ?? 'Unknown';
          print(profilePicture.value);
          print(profileData);
          isLoading.value = false;

          print('Profile fetched successfully: $name, $email');
        } else {
          throw Exception('Failed to load profile: ${data['message']}');
        }
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;

      print('Error fetching profile: $e');
    }
  }

// Method to update profile picture


  Future<void> updateProfilePicture(BuildContext context) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token != null) {

        String url = '$baseUrl/api/auth/update-profile-picture';

        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..headers['Authorization'] = 'Bearer $token';

        if (pickedImage.value != null) {
          var imageFile = pickedImage.value!;
          var imageStream = http.ByteStream(imageFile.openRead());
          var imageLength = await imageFile.length();

          request.files.add(http.MultipartFile(
            'profilePicture',
            imageStream,
            imageLength,
            filename: imageFile.path.split('/').last,
            contentType: MediaType('profilePicture', 'jpg'),
          ));
        }

        // Send the request and get the response
        var response = await request.send();

        // Check the response status
        if (response.statusCode == 200) {
          List<int> imageBytes = await pickedImage.value!.readAsBytes();
          String base64Image = base64Encode(imageBytes);

          var responseBody = await http.Response.fromStream(response);
          final data = jsonDecode(responseBody.body);
          print(data);

          isLoading.value = false; // Start loading

          Get.snackbar(
            'Success',
            'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          isLoading.value = false; // Start loading

          Get.snackbar(
            'Error',
            'Failed to update profile. Status code: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Authentication token not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false; // Start loading

      print('Error occurred while updating profile: $e');
    }
  }



  var pickedImage = Rxn<File>();

  Future<void> pickImage(BuildContext context) async {
    try {
      print("Opening image picker...");
      ImagePicker imagePicker = ImagePicker();

      XFile? photoTaken = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (photoTaken == null) {
        print("No image selected.");
        return;
      }

      print("Image selected: ${photoTaken.path}");

      File image = File(photoTaken.path);

      // Show loading toast
      final cancelToast = BotToast.showLoading();

      pickedImage.value = image;
      print('PICKED IMAGE: ${pickedImage.value}');

      cancelToast();

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } finally {
      BotToast.cleanAll();
    }
  }


}
