import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void login() {
    // Implement your login logic here
    print('Login button pressed');
  }

  void forgotPassword() {
    // Implement forgot password functionality
    print('Forgot password pressed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoadStatus.validationError) {
          showErrorSnackBar(context, state.message);
        } else if (state.status == LoadStatus.success) {
          Navigator.popAndPushNamed(context, '');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstants.imageslogin),
                    fit: BoxFit.fill)),
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: FontConstants.font_24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColor),
                  ),
                  Text(
                    'Enter your login detail',
                    style: TextStyle(
                        fontSize: FontConstants.font_16,
                        color: const Color.fromARGB(255, 106, 63, 63)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomTextField(
                        labelText: 'Enter email',
                        controller: emailController,
                        prefixIcon: Icon(Icons.mail),
                      ),
                      SizedBox(height: 20.0),

                      CustomTextField(
                        labelText: 'Enter password',
                        controller: emailController,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: state.isObscureText
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                      SizedBox(height: 40.0), // Add spacing

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, routeHome);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants
                              .primaryColor, // Change the background color here
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(color: ColorConstants.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
