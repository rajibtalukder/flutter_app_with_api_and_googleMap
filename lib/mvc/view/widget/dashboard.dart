import 'package:elm/mvc/controller/admin_controller.dart';
import 'package:elm/mvc/model/admin_payment_model.dart';
import 'package:elm/mvc/view/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  AdminController _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(
            "All Donation",
            style: TextStyle(fontSize: fontBig, color: secondaryBackground),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Obx(
              () => _adminController.isLoading.value
                  ? Center(child: CircularProgressIndicator(color: white))
                  : Column(children: [
                      Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: GetBuilder<AdminController>(
                            builder: (controller) => DataTable(
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
                                      'Donor Name',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Paid Amount',
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
                                rows: controller.paymentList.value.data
                                    .map((datum) {
                                  return DataRow(cells: [
                                    DataCell(Text(datum.id.toString(),
                                        style: TextStyle(
                                            color: primaryBackground))),
                                    DataCell(Text(datum.project.name == null
                                        ? "Quick Donated"
                                        : datum.project.name.toString(),
                                        style: TextStyle(
                                            color: primaryBackground))),
                                    DataCell(Text(
                                        datum.customerInfo.name == null
                                            ? "None"
                                            : datum.customerInfo.name
                                                .toString(),
                                        style: TextStyle(
                                            color: primaryBackground))),
                                    DataCell(Text(datum.amount.toString(),
                                        style: TextStyle(
                                            color: primaryBackground))),
                                    DataCell(Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            showCustomDialog(context, "",
                                                donorDetails(datum), 200, 450);
                                          },
                                          child: Icon(Icons.info_outline,
                                              size: 20, color: primaryColor),
                                        ))),
                                  ]);
                                }).toList()),
                          ),
                        ),
                      )
                    ]),
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
                      _adminController.fetchPaymentList(_adminController
                          .currentPage = _adminController.currentPage - 1);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 40,
                      color: white,
                    )),
                SizedBox(width: 40),
                IconButton(
                    onPressed: () async {
                      _adminController.fetchPaymentList(_adminController
                          .currentPage = _adminController.currentPage + 1);
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

  Widget donorDetails(Datum datum) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Donor Information',
            style: TextStyle(fontSize: fontVeryBig, color: primaryColor)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          child: DataTable(
              columnSpacing: 200.0,
              // decoration: BoxDecoration(
              //     border: Border.all(color: textSecondary, width: 1),
              //     borderRadius: BorderRadius.all(Radius.circular(10))),
              columns: [
                DataColumn(label: Text('Info')),
                DataColumn(label: Text('Field')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('Donor Name')),
                    DataCell(Text(datum.customerInfo.name == null
                        ? "None"
                        : datum.customerInfo.name.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Email')),
                    DataCell(Text(datum.customerInfo.email == null
                        ? "None"
                        : datum.customerInfo.email.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Address ')),
                    DataCell(Text(datum.customerInfo.address == null
                        ? "None"
                        : datum.customerInfo.address.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Project Name ')),
                    DataCell(Text(datum.project.name.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Project Title ')),
                    DataCell(Text(datum.project.title.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Target Amount')),
                    DataCell(Text(datum.targetAmount.toString())),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Paid Amount')),
                    DataCell(Text(datum.amount.toString())),
                  ],
                ),
              ]),
        ),
      ],
    );
  }
}
