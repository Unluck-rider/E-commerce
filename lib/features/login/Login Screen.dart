import 'package:e_commerce/base/size_config.dart';
import 'package:e_commerce/base/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/ResponsiveLayout.dart';
import '../Sing Up/sign_up.dart';
import 'Widget/Textfield Widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> onWillPop() async {
    SystemNavigator.pop();
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
                    'Login and Enjoy Your Shopping!',
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.h(24)),
                  CustomTextField(
                    hintText: 'Email or Phone',
                    icon: Icons.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: SizeConfig.h(16)),
                  CustomTextField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: SizeConfig.h(8)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14 * scaleFactor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(24)),
                  ElevatedButton(
                    onPressed: () {
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
                      'Login',
                      style: TextStyle(
                        color: AppColors.buttonText,
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.h(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print('TextButton pressed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),



                    ],
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
