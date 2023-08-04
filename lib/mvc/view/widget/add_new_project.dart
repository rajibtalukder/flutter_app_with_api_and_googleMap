import 'dart:io';

import 'package:elm/mvc/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';
import '../../../utils/utils.dart';


class NewProject extends StatefulWidget {
  NewProject({Key? key}) : super(key: key);

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final formKey = GlobalKey<FormState>();

  AdminController _controller = Get.put(AdminController());


  String zakatType ='Eligible';

  TextEditingController _controllerName = TextEditingController();

  TextEditingController _controllerTitle = TextEditingController();

  TextEditingController _controllerDescription = TextEditingController();

  TextEditingController _controllerTargetAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Add New Project",
            style: TextStyle(fontSize: fontBig, color: secondaryBackground),
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Invalid field";
                        }
                        return null;
                      },
                      controller: _controllerName,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: fontVerySmall, color: white),
                      decoration: InputDecoration(
                        fillColor: white,
                        //prefixIcon: Icon(Icons.text_fields, color: white),
                        hintText: "Project Name",
                        contentPadding: EdgeInsets.only(left: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        hintStyle:
                            TextStyle(fontSize: fontVerySmall, color: white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Invalid field";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: _controllerTitle,
                        style: TextStyle(fontSize: fontVerySmall, color: white),
                        decoration: InputDecoration(
                          fillColor: textSecondary,
                          //prefixIcon: Icon(Icons.title, color: primaryBackground),
                          hintText: "Project Title",
                          contentPadding: EdgeInsets.only(left: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintStyle:
                              TextStyle(fontSize: fontVerySmall, color: white),
                        )),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Invalid field";
                          }
                          return null;
                        },
                        controller: _controllerDescription,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: fontVerySmall, color: white),
                        decoration: InputDecoration(
                          fillColor: textSecondary,
                          //prefixIcon: Icon(Icons.title, color: primaryBackground),
                          hintText: "Description",
                          contentPadding: EdgeInsets.only(left: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintStyle:
                              TextStyle(fontSize: fontVerySmall, color: white),
                        )),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Invalid field";
                          }
                          return null;
                        },
                        controller: _controllerTargetAmount,
                        onChanged: (text) async {},
                        onEditingComplete: () async {},
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: fontVerySmall, color: white),
                        decoration: InputDecoration(
                          fillColor: textSecondary,
                          //prefixIcon: Icon(Icons.title, color: primaryBackground),
                          hintText: "Target Amount",
                          contentPadding: EdgeInsets.only(left: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintStyle:
                              TextStyle(fontSize: fontVerySmall, color: white),
                        )),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Zakat  : ",
                          style: TextStyle(fontSize: fontSmall, color: white),
                        ),
                      ),
                      Container(
                          width: 160,
                          child: RadioListTile(
                            activeColor: white,
                            contentPadding: EdgeInsets.all(0.0),
                            value: "Eligible",
                            groupValue: zakatType,
                            title: Text(
                              "Eligible",
                              style: TextStyle(color: white),
                            ),
                            onChanged: (value) {
                              setState(() {
                                zakatType= value.toString();
                                print(zakatType);
                              });
                            },
                          )),
                      Container(
                          width: 160,
                          child: RadioListTile(
                            activeColor: white,
                            contentPadding: EdgeInsets.all(0.0),
                            value: "Not Eligible",
                            groupValue: zakatType,
                            title: Text(
                              "Not Eligible",
                              style: TextStyle(color: white),
                            ),
                            onChanged: (value) {
                              setState(() {
                                zakatType =value.toString();
                                print(zakatType);
                              });
                            },
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: Center(
                          child: MaterialButton(
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    height: 50,
                    minWidth: double.infinity,
                    color: white,
                    onPressed: () async {
                      await _controller.importProjectImage();
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        Text('Upload Image',
                            style:
                                TextStyle(fontSize: fontSmall, color: black)),
                      ],
                    ),
                  ))),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      _controller.imageeFile == null
                          ? ""
                          : _controller.imageeFile.toString(),
                      style: TextStyle(color: white),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: alternate,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Utils.showLoading();
                          _controller.postImageAndData(
                            _controllerName.text,
                            _controllerTitle.text,
                            _controllerDescription.text,
                            _controllerTargetAmount.text,
                            zakatType.toString(),
                            _controller.imageeFile as File,
                          );
                          Utils.hidePopup();
                        } else {
                          // _controllerName.clear();
                          // _controllerTitle.clear();
                          // _controllerDescription.clear();
                          // _controllerTargetAmount.clear();
                          Utils.showSnackBar('Invalid user data');
                        }
                      },
                      child: Text("Submit",
                          style: TextStyle(fontSize: fontSmall, color: white)),
                    ),
                  ),
                ]),
              ),
            )),
      ],
    );
  }
}
