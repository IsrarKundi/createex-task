import 'package:e_labor/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart'; // Import the HomeController

class MainScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),


      body: Obx(() {
        switch (homeController.selectedIndex.value) {
          case 0:
            return Center(child: HomeScreen());
          case 1:
            return Center(child: Text('Search Screen', style: TextStyle(color: Colors.white)));
          case 2:
            return Center(child: Text('Notifications Screen', style: TextStyle(color: Colors.white)));
          case 3:
            return Center(child: Text('Profile Screen', style: TextStyle(color: Colors.white)));
          default:
            return Center(child: Text('Home Screen', style: TextStyle(color: Colors.white)));
        }
      }),

      bottomNavigationBar: Obx(() {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xff2F2F2F),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BottomNavigationBar(
            currentIndex: homeController.selectedIndex.value,
            onTap: (index) => homeController.updateIndex(index),
            backgroundColor: Colors.transparent,
            selectedItemColor: Color(0xffFFC491),
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/Infinity.svg'),
                label: 'Loop',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/message.svg'),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/calender.svg'),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/Explore.svg'),
                label: 'Explore',
              ),
            ],
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
          ),

        );
      }),
    );
  }
}


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2C2C2C),
        body: Obx(() {
          if (homeController.circles.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text(
                      'Welcome to Circle!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        Get.to(()=> ProfileScreen());
                      },
                      child: CircleAvatar(
                        radius: screenWidth * 0.06,
                        backgroundImage: profileController.pickedImage.value != null
                            ? FileImage(profileController.pickedImage.value!)
                            : (profileController.profilePicture.value.isNotEmpty
                            ? NetworkImage(profileController.profilePicture.value)
                            : AssetImage('images/profile.png') as ImageProvider),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeController.circles.length,
                    itemBuilder: (context, index) {
                      final circle = homeController.circles[index];
                      return Card(
                        color: Color(0xff414141),
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(circle['circleImage']),
                          ),
                          title: Text(
                            circle['circleName'],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            circle['description'],
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
