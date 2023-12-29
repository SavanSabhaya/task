import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/logger_util.dart';
import 'package:task/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

 

  @override
  void initState() {
    // emailController.text = "bhavik.patel@iottive.com";
    // passwordController.text = 'Bhavik123#';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoadStatus.validationError) {
          showErrorSnackBar(context, state.message);
           EasyLoading.dismiss();
        } else if (state.status == LoadStatus.success) {
          showSuccessSnackBar(context, state.message);
          Navigator.pushNamedAndRemoveUntil(context, routeHome,(route) => true,);
           EasyLoading.dismiss();
        }else if(state.status == LoadStatus.failure){
           showErrorSnackBar(context, state.message);
           EasyLoading.dismiss();
        }else if(state.status == LoadStatus.loading){
          EasyLoading.show();
        }
      },
      builder: (context, state) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 100,
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
                        controller: passwordController,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          child: state.isObscureText
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye_outlined),
                          onTap: () {
                            context.read<LoginBloc>().add(
                                LoginPasswordChangedEvent(
                                    !state.isObscureText));
                          },
                        ),
                        isObscureText: state.isObscureText,
                      ),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(ValidateEvent(
                              emailController.text, passwordController.text));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.primaryColor,
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
