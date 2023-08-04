import 'package:elm/constant/value.dart';
import 'package:elm/mvc/controller/admin_controller.dart';
import 'package:elm/mvc/view/dialog/custom_dialog.dart';
import 'package:elm/mvc/view/page/home.dart';
import 'package:elm/mvc/view/widget/dashboard.dart';
import 'package:elm/mvc/view/widget/hadith.dart';
import 'package:elm/mvc/view/widget/add_new_project.dart';
import 'package:elm/mvc/view/widget/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';

class AdminHomepage extends StatefulWidget {
  AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  AdminController _controller = Get.put(AdminController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 30,14,14),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logoo.png',
                          height: 40,
                          fit: BoxFit.cover,
                          color: primaryColor,
                        ),
                        Text(
                          'ELM',
                          style: TextStyle(fontSize: fontBig, letterSpacing: 4),
                        ),
                        SizedBox(height: 30),
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  _controller.selectContainer(0);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.dashboard, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Dashboard',
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ],
                                ))),
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  _controller.selectContainer(1);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.padding_rounded, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Projects',
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ],
                                ))),
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  _controller.selectContainer(2);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle_outlined, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Add New Project',
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ],
                                ))),
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  _controller.selectContainer(3);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.file_copy_rounded, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Hadith',
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ],
                                ))),
                        Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  showWarningDialog("Are you sure you want to Log Out?", onAccept: (){
                                    Get.offAll(Home());
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ))),
          Expanded(
              flex: 4,
              child: Obx(() {
                return _controller.selectedContainerIndex == 0
                    ?  Dashboard()
                    : _controller.selectedContainerIndex == 1
                        ? ProjectWidget()
                    : _controller.selectedContainerIndex == 2
                            ? NewProject()
                            : _controller.selectedContainerIndex==3
                            ? Hadith()
                            : SizedBox();
              })),
        ]),
      ),
    );
  }
}
