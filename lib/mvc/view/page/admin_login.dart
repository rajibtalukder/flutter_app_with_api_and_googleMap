import 'dart:convert';
import 'package:elm/constant/color.dart';
import 'package:elm/mvc/controller/home_controller.dart';
import 'package:elm/mvc/view/dialog/custom_dialog.dart';
import 'package:elm/mvc/view/page/admin_homepage.dart';
import 'package:elm/mvc/view/page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/value.dart';
import '../../../service/api/api_client.dart';
import '../../../service/local/shared_pref.dart';
import '../../../utils/utils.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});

  final formKey = GlobalKey<FormState>();

  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerPass = TextEditingController();
  HomeController homeController =Get.put(HomeController());

  // @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: primaryColor,
      padding:
          EdgeInsets.symmetric(horizontal: width / 12, vertical: height / 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'BACK',
                      style: TextStyle(color: white),
                    )
                  ],
                ),
              ),
              Image.asset(
                'assets/logoo.png',
                height: 40,
                fit: BoxFit.cover,
                color: white,
              ),
            ],
          ),
          Expanded(
              child: Card(
                  color: white,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                      vertical: height / 26, horizontal: width / 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(children: [
                        const Text('Admin Panel',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: fontMedium,
                            )),
                        SizedBox(height: height / 22),
                        Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Text(
                                  'User Login',
                                  style: TextStyle(
                                      fontSize: fontVeryBig,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    'Enter your details to sign in your user account',
                                    style: TextStyle(
                                        fontSize: fontVerySmall,
                                        color: textSecondary)),
                                SizedBox(height: 30),
                                SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                      onChanged: (text) async {},
                                      onEditingComplete: () async {},
                                      keyboardType: TextInputType.text,
                                      controller: controllerEmail,
                                      validator: (value) {
                                        if (Utils.isEmailValid(value!)) {
                                          return null;
                                        } else {
                                          return "Invalid Email";
                                        }
                                      },
                                      style: TextStyle(
                                          fontSize: fontVerySmall,
                                          color: primaryText),
                                      decoration: InputDecoration(
                                        fillColor: textSecondary,
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: textSecondary),
                                        hintText: "Username",
                                        labelText: "Email Address",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: fontVerySmall,
                                            color: primaryText),
                                      )),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                      onChanged: (text) async {},
                                      onEditingComplete: () async {},
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      controller: controllerPass,
                                      validator: (value) {
                                        if (Utils.isPasswordValid(value!)) {
                                          return null;
                                        } else {
                                          return "Minimum password length is six";
                                        }
                                      },
                                      style: TextStyle(
                                          fontSize: fontVerySmall,
                                          color: primaryText),
                                      decoration: InputDecoration(
                                        fillColor: textSecondary,
                                        prefixIcon: Icon(Icons.password,
                                            color: textSecondary),
                                        hintText: "Password",
                                        labelText: "Password",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: fontVerySmall,
                                            color: primaryText),
                                      )),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    showWarningDialog(
                                        'Are you forget you password?',
                                        onAccept: () {
                                      Get.back();
                                    });
                                  },
                                  child: const Text('Forget Password',
                                      style: TextStyle(color: black)),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: alternate,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();

                                        Utils.showLoading();
                                        var response = await ApiClient()
                                            .post(
                                                '/api/login',
                                                json.encode({
                                                  "email": controllerEmail.text,
                                                  "password":
                                                      controllerPass.text,
                                                }),
                                                header: Utils.apiHeader)
                                            .catchError((e) {
                                          Utils.showSnackBar(
                                              "Invalid Username or Password $e");
                                        });
                                        if (response == null) {
                                          Utils.hidePopup();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Home()));
                                          //Utils.showSnackBar(jsonDecode(response)["message"]);
                                        }
                                        await SharedPref().saveValue('token',
                                            jsonDecode(response)["token"]);
                                        homeController.loadData();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AdminHomepage()));
                                      }
                                      controllerEmail.clear();
                                      controllerPass.clear();
                                    },
                                    child: Text('Log In',
                                        style: TextStyle(color: white)),
                                  ),
                                ),
                              ]),
                            ))
                      ]))))
        ],
      ),
    );
  }
}
