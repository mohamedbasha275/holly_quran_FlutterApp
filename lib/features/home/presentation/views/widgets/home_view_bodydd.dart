import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  var _bottomNavIndex = 0; //default index of a first screen
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Text(AppConstants.appName),
      ),
      body: NotificationListener<ScrollNotification>(
        child:
        Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: AppSize.s300,
              child: Lottie.asset(JsonAssets.homeAvatar),
            ),
          ),
          Icon(iconList[_bottomNavIndex]),
        ],
      ),
    ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.brightness_3,
          color: Colors.purple,
        ),
        onPressed: () {
          // _fabAnimationController.reset();
          // _borderRadiusAnimationController.reset();
          // _borderRadiusAnimationController.forward();
          // _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildAnimatedBottomNavigationBar(),
    );
  }
  AnimatedBottomNavigationBar buildAnimatedBottomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.blue : Colors.white;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "brightnehh hhh h h  h h h h  h  hss $index",
                maxLines: 1,
                style: TextStyle(color: color),
                // group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: Colors.greenAccent,
      activeIndex: _bottomNavIndex,
      splashColor: Colors.redAccent,
      // notchAndCornersAnimation: borderRadiusAnimation,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      // hideAnimationController: _hideBottomBarAnimationController,
      shadow: BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: Colors.amber,
      ),
    );
  }
}
