import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/constants/widgets/custom_button.dart';
import 'package:expenzapp/screens/main_screen.dart';
import 'package:expenzapp/services/user_service.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _rememberMe = false;

  //form Key for the validation
  final _formKey = GlobalKey<FormState>();

  //controller for the text from feilds
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordcontroler = TextEditingController();
  final TextEditingController _conformPasswordcontroler =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordcontroler.dispose();
    _conformPasswordcontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      //User Name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your Name!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),
                      //Email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your Email!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),
                      //Password
                      TextFormField(
                        controller: _passwordcontroler,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your Password!";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),
                      //Password
                      TextFormField(
                        controller: _conformPasswordcontroler,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please ReEnter your Password!";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Conform Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 25),
                      //Remember me for the next time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remember me for the next time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;

                                  print(_rememberMe);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            //form is valid , process data
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordcontroler.text;
                            String conformPassword =
                                _conformPasswordcontroler.text;

                            //
                            await UserService.storeUserDetails(
                              userName: userName,
                              email: email,
                              password: password,
                              confirmPassword: conformPassword,
                              context: context,
                            );
                            if (context.mounted ||
                                password == conformPassword) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: CustomButton(
                          buttonName: "Submit",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
