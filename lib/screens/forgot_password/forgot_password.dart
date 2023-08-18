import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:plantmonitoringsystem/services/firebase_auth_methods.dart';
import 'package:plantmonitoringsystem/ui/widgets/constants.dart';
import 'package:plantmonitoringsystem/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<bool> forgotPassword() async {
    bool response = await context.read<FirebaseAuthMethods>().forgotPassword(
          email: emailController.text.trim(),
          context: context,
        );
    if (response) {
      emailController.clear();
    }
    return response;
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
                        "Forgot Password Page",
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
                                  final success = await forgotPassword();

                                  if (success) {
                                    navigator.pop();
                                  }
                                }
                              },
                              child: Text(
                                "Submit",
                                style: GoogleFonts.montserrat(
                                    fontSize: 21,
                                    color: Colors.white,
                                    letterSpacing: 0.168,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ])),
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
