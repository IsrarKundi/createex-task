import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/authentication_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final LoginController homeController = Get.put(LoginController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                Image.asset(
                  'images/signin.png',
                  width: screenWidth * 0.7,
                ),
                SizedBox(height: screenHeight * 0.05),

                // "Login" Text
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),

                Text(
                  'Please enter the required details',
                  style: TextStyle(
                    fontSize: screenHeight * 0.015,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.05),

                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.05),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: screenHeight * 0.015,
                        color: Color(0xffBBBBBB),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.008),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: homeController.emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      hintText: null,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Password TextField
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.05),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xffBBBBBB),
                        fontSize: screenHeight * 0.015,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.008),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: homeController.passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      hintText: null,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Login Button
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: screenHeight * 0.062,
                        child: Obx(() => ElevatedButton(
                          onPressed: homeController.isLoading.value
                              ? null
                              : () {
                            homeController.signIn();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (!homeController.isLoading.value)
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                              if (homeController.isLoading.value)
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFFC491),
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

