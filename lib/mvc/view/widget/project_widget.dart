import 'package:elm/mvc/controller/admin_controller.dart';
import 'package:elm/mvc/controller/home_controller.dart';
import 'package:elm/mvc/view/dialog/custom_dialog.dart';
import 'package:elm/mvc/view/widget/update_project.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';

class ProjectWidget extends StatelessWidget {
  ProjectWidget({Key? key}) : super(key: key);

  AdminController _adminController = Get.put(AdminController());

  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(
            "All Projects",
            style: TextStyle(fontSize: fontBig, color: secondaryBackground),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Obx(
              () => _homeController.isLoading.value
                  ? Center(child: CircularProgressIndicator(color: white))
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: GetBuilder<HomeController>(
                            builder: (controller) {
                              return DataTable(
                                dataRowHeight: 70,
                                columns: [
                                  // column to set the name
                                  DataColumn(
                                    label: Text(
                                      'Id No',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Project Name',
                                      style: TextStyle(color: white),
                                    ),
                                  ),

                                  DataColumn(
                                    label: Text(
                                      'Target Amount',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Action',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ],
                                rows: controller.projectList.value.data
                                    .map((datum) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(datum.id.toString(),
                                          style: TextStyle(
                                              color: primaryBackground))),
                                      DataCell(Text(datum.name,
                                          style: TextStyle(
                                              color: primaryBackground))),
                                      DataCell(Text(
                                        datum.targetAmount,
                                        style:
                                            TextStyle(color: primaryBackground),
                                      )),
                                      DataCell(
                                        Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      // showCustomDialog(context, '',
                                                      //     UpdateProject(), 140, 320);

                                                      Get.to(
                                                          UpdateProject(datum));
                                                    },
                                                    child: Icon(Icons.edit,
                                                        size: 20,
                                                        color: primaryColor))),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    showWarningDialog(
                                                        'Do you want to delete this project?',
                                                        onAccept: () async {
                                                      _adminController
                                                          .deleteProject(datum
                                                              .id
                                                              .toString());
                                                      Get.back();
                                                    });
                                                  },
                                                  child: Icon(Icons.delete,
                                                      size: 20,
                                                      color:
                                                          Color(0xffED0206))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      _homeController.fetchProjectList(_homeController
                          .currentPage = _homeController.currentPage - 1);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 40,
                      color: white,
                    )),
                SizedBox(width: 40),
                IconButton(
                    onPressed: () async {
                      _homeController.fetchProjectList(_homeController
                          .currentPage = _homeController.currentPage + 1);
                    },
                    icon: Icon(
                      Icons.chevron_right,
                      size: 40,
                      color: white,
                    )),
                SizedBox(width: 100),
              ],
            )),
      ],
    );
  }
}
