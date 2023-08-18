import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantmonitoringsystem/services/biometrics.dart';
import 'package:provider/provider.dart';

import 'package:plantmonitoringsystem/routes/routes.dart';
import 'package:plantmonitoringsystem/services/firebase_auth_methods.dart';
import 'package:plantmonitoringsystem/ui/widgets/constants.dart';
import 'package:plantmonitoringsystem/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // demo
  @override
  void initState() {
    super.initState();
    emailController.text = "djrandeez@gmail.com";
    passwordController.text = "password";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initFingerPrint();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _initFingerPrint() async {
    final navigator = Navigator.of(context);

    bool isAuthenticated = await BiometricsMethods.authenticateWithBiometrics();

    if (isAuthenticated) {
      navigator.pushNamed(homeScreenRoute);
    } else {
      showSnackbar(context, "Biometric Authentication Failed");
    }
  }

  Future<bool> loginUser() async {
    return await context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: const Color.fromARGB(68, 255, 255, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Plant Monitoring System",
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 0.5),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                  _linkimage(),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        _inputEmail(emailController),
                        _inputPassword(passwordController),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.green,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: const EdgeInsets.all(8),
                              ),
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  final navigator = Navigator.of(context);
                                  final success = await loginUser();

                                  if (success) {
                                    navigator.pushNamed(homeScreenRoute);
                                  }
                                }
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.montserrat(
                                    fontSize: 21,
                                    color: Colors.white,
                                    letterSpacing: 0.168,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ])),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                  _forgotPass(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _linkimage() {
  return Column(
    children: [
      const Padding(padding: EdgeInsets.only()),
      Center(
        child: Image.asset(
          UIGuide.linkImage,
        ),
      )
    ],
  );
}

Widget _inputEmail(emailController) {
  return Column(
    children: [
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required field';
            }
            RegExp regex = RegExp(kTextValidatorEmailRegex);
            if (!regex.hasMatch(value)) return 'Invalid email address';
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'enter your email',
              isCollapsed: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              )),
        ),
      )
    ],
  );
}

Widget _inputPassword(passwordController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          obscureText: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required field';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'enter your password',
              isCollapsed: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              )),
        ),
      )
    ],
  );
}

Widget _forgotPass(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.pushNamed(context, registerScreenRoute);
            },
            child: const Text(" Register"),
          )),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            textStyle: GoogleFonts.montserrat(
                fontSize: 15, color: Colors.green, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pushNamed(context, forgotPasswordScreenRoute);
          },
          child: const Text("Forgot Password? "),
        ),
      ),
    ],
  );
}
