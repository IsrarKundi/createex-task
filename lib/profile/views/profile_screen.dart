import 'package:e_labor/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF2C2C2C),
          title: Center(
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Color(0xFF2C2C2C),
        body: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        alignment: Alignment.center,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                profileController.pickImage(context);
                              },
                              child: CircleAvatar(
                                radius: screenWidth * 0.18,
                                backgroundImage: profileController.pickedImage.value != null
                                    ? FileImage(profileController.pickedImage.value!)
                                    : (profileController.profilePicture.value.isNotEmpty
                                    ? NetworkImage(profileController.profilePicture.value)
                                    : AssetImage('images/profile.png') as ImageProvider),
                              ),
                            ),

                            Positioned(
                              right: 10,
                              bottom: -10,
                              child: Image.asset(
                                'images/instagram.png', // Replace with your PNG image path
                                width: screenWidth * 0.12, // Adjust the size of the bottom image
                                height: screenWidth * 0.12, // Adjust the size of the bottom image
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey[400], fontSize: screenWidth * 0.044),
                            ),
                            Text(
                              profileController.name.value,
                              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.048),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey[800],
                              thickness: 1,
                            ),
                            SizedBox(height: screenHeight * 0.01),

                            Text(
                              'Email',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey[400], fontSize: screenWidth * 0.044),
                            ),
                            Text(
                              profileController.email.value,
                              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.048),
                            ),
                            SizedBox(height: screenHeight * 0.013),
                            Divider(
                              color: Colors.grey[800],
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: screenHeight * 0.066,
                              child: ElevatedButton(
                                onPressed: () {
                                  profileController.updateProfilePicture(context);
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFFC491),
                                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24), // Rounded corners
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),

              if (profileController.isLoading.value)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}


