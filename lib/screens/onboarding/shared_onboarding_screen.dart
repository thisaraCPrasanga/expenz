import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/constants/constats.dart';
import 'package:expenzapp/screens/user_data_screen.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const SharedOnboardingScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefalutPadding),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset(imagePath, width: 250, fit: BoxFit.cover),
              SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDataScreen()),
                  );
                },
                child: Container(
                  height: 20,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kMainColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
