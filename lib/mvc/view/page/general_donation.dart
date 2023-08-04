import 'package:elm/constant/color.dart';
import 'package:elm/constant/value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../controller/home_controller.dart';
import '../../model/home_projects.dart';
import '../widget/custom_widget.dart';
import 'general_payment.dart';

class GeneralDonation extends StatefulWidget {
  final Datum homeProject;

  GeneralDonation(this.homeProject, {Key? key}) : super(key: key);

  @override
  State<GeneralDonation> createState() => _GeneralDonationState();
}

class _GeneralDonationState extends State<GeneralDonation> {
  List<int> moneyList = [5, 10, 25, 50];
  int moneySelected = 0;
  int wheelSelected = 0;
  var _selectedIndex = -1;

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: primaryColor,
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 30),
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
                  children: const [
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
                height: height / 12,
                fit: BoxFit.cover,
                color: white,
              ),
            ],
          ),
          Expanded(
            child: Card(
              color: secondaryColor,
              elevation: 5,
              margin: const EdgeInsets.all(70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(height / 18),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.homeProject.name.toString(),
                            //widget.project.name.toString(),
                            style: TextStyle(
                                color: Colors.white54, fontSize: fontSmall),
                          ),
                          Text(
                            widget.homeProject.title.toString(),
                            //widget.project.title.toString(),
                            style: TextStyle(
                                color: white,
                                fontSize: fontVeryBig,
                                letterSpacing: 1),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 20),
                              height: height / 2.2,
                              width: height / 2.2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.homeProject.image.toString(),
                                  // height: Size.infinite.height,
                                  // width: Size.infinite.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              carTopItem(
                                'Target Amount',
                                '£ ${widget.homeProject.targetAmount}',
                              ),
                              //widget.project.needAmount.toString()),
                              const SizedBox(width: 8),
                              carTopItem(
                                'Zakat',
                                widget.homeProject.zakat.toString(),
                                //widget.project.zakat.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 40),
                          Expanded(
                            child: Text(
                                widget.homeProject.description.toString(),
                                //widget.project.description.toString(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: fontSmall, color: white)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i in moneyList)
                                roundButton(
                                    '£$i',
                                    _selectedIndex == i ? alternate : white,
                                    _selectedIndex == i ? alternate : white,
                                    _selectedIndex == i ? white : primaryColor,
                                    onPressed: () {
                                  setState(() {
                                    _selectedIndex = i;
                                    moneySelected = i;
                                    wheelSelected = moneySelected;
                                  });
                                }),
                              Container(
                                height: height / 14,
                                width: width / 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: white, width: 1.5)),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 5,
                                        child: Text('OTHER\nAMOUNT',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: white,
                                                fontSize: fontVerySmall))),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: WheelChooser(
                                          onValueChanged: (s) {
                                            setState(() => wheelSelected =
                                                int.parse(s
                                                    .toString()
                                                    .split('£')[1]));
                                            print(s);
                                          },
                                          datas: [
                                            for (int i = 0; i <= 50; i++) '£$i'
                                          ],
                                          itemSize: 20,
                                          magnification: 1.1,
                                          selectTextStyle: const TextStyle(
                                              color: primaryColor),
                                          unSelectTextStyle: const TextStyle(
                                              color: textSecondary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: height / 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: height / 14,
                                width: width / 6,
                                child: borderButton(
                                    'ADD GIFT AID',
                                    Colors.transparent,
                                    white,
                                    white, onPressed: () {
                                  if (wheelSelected != 0) {
                                    Get.to(GeneralPayment(widget.homeProject),
                                        arguments: {
                                          "int": wheelSelected,
                                          'bool': true,
                                          'intt': 1,
                                        });
                                    // Get.to(GeneralPayment(
                                    //   wheelSelected, true,
                                    //   1,
                                    //   //widget.project.id!
                                    // ));
                                    return;
                                  }
                                  if (moneySelected != 0) {
                                    Get.to(GeneralPayment(widget.homeProject),
                                        arguments: {
                                          "int": wheelSelected,
                                          'bool': true,
                                          'intt': 2,
                                        });
                                    // Get.to(GeneralPayment(
                                    //   moneySelected, true, 2,
                                    //   //widget.project.id!
                                    // ));
                                  }
                                }),
                              ),
                              SizedBox(
                                  height: height / 14,
                                  width: width / 6,
                                  child: normalButton(
                                      "DONATE NOW", alternate, white,
                                      onPressed: () {
                                    //Get.to(const GeneralPayment());

                                    if (wheelSelected != 0) {
                                      Get.to(GeneralPayment(widget.homeProject),
                                          arguments: {
                                            "int": wheelSelected,
                                            'bool': false,
                                            'intt': 3,
                                          });

                                      // Get.to(GeneralPayment(
                                      //   wheelSelected, false, 3,
                                      //   //widget.project.id!
                                      // ));
                                      return;
                                    }
                                    if (moneySelected != 0) {
                                      Get.to(GeneralPayment(widget.homeProject),
                                          arguments: {
                                            "int": wheelSelected,
                                            'bool': false,
                                            'id': 4,
                                          });

                                      // Get.to(GeneralPayment(
                                      //   moneySelected,
                                      //   false,
                                      //   4,
                                      //   //widget.project.id!
                                      // ));
                                    }
                                  })),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget carTopItem(String type, String amount) {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: white, width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset(
                  'assets/Icon.png',
                  height: Size.infinite.height,
                  width: Size.infinite.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    type,
                    style: const TextStyle(fontSize: 10, color: white),
                  ),
                  Text(amount,
                      style: const TextStyle(fontSize: 10, color: white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
