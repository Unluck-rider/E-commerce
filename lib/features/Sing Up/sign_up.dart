import 'package:e_commerce/features/login/Login%20Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/ResponsiveLayout.dart';
import '../../base/size_config.dart';
import '../../base/theme.dart';
import '../login/Widget/Textfield Widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? passwordError;
  DateTime? selectedDate;
  TextEditingController dobController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilrController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    confirmPasswordController.addListener(_checkPasswordMatch);
  }

  void _checkPasswordMatch() {
    setState(() {
      if (confirmPasswordController.text != passwordController.text) {
        passwordError = 'Passwords do not match';
      } else {
        passwordError = null;
      }
    });
  }
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  Future<bool> onWillPop() async {
    Navigator.pop(context);
    return false;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ResponsiveLayout(
      mobile: _buildOnboarding(context),
      tablet: _buildOnboarding(context, scaleFactor: 1.2),
      desktop: _buildOnboarding(context, scaleFactor: 1.5),
    );
  }
  Widget _buildOnboarding(BuildContext context, {double scaleFactor = 1.0}) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.h(40)), // Top spacing
                  Center(
                    child: Image.asset(
                      'assets/images/Logo/logo1.png',
                      height: SizeConfig.h(180 * scaleFactor),
                      width: SizeConfig.w(180 * scaleFactor),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(24)),
                  Text(
                    'Register and Enjoy Your Shopping!',
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.h(24)),
                  CustomTextField(
                    hintText: 'Enter full name',
                    icon: Icons.person,
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: SizeConfig.h(16)),
                  CustomTextField(
                    hintText: 'Enter email address',
                    icon: Icons.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: SizeConfig.h(16)),
                  CustomTextField(
                    hintText: 'Enter mobile number',
                    icon: Icons.phone_android_rounded,
                    controller: mobilrController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: SizeConfig.h(16)),
                  CustomTextField(
                    hintText: 'Select Date of Birth',
                    icon: Icons.calendar_today,
                    controller: dobController,
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          dobController.text = "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.h(16)),
                  CustomTextField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: SizeConfig.h(24)),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    controller: confirmPasswordController,
                    isPassword: true,
                    errorText: passwordError,
                  ),

                  SizedBox(height: SizeConfig.h(16)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.h(14)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 0),
                      elevation: 4,
                      shadowColor: AppColors.secondary.withOpacity(0.4),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.buttonText,
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
