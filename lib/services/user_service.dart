import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // method to store the user name and user Email in shared prferences
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //chech where the user enterd password and the confirmPasswor are the same
      if (password != confirmPassword) {
        //show a message to the users
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password and confirm Password do not match")),
        );
        return;
      }
      //if the user password and confirmPassword are same then store the users name and email
      //Create and instance shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // store the user name and email pairs
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      //show a message to the user
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User data Stored Successfully")));
    } catch (err) {
      err.toString();
    }
  }

  //methode to check weather the username is saved in the shared peference
  static Future<bool> checkUserName() async {
    //create an instance for shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }
}
