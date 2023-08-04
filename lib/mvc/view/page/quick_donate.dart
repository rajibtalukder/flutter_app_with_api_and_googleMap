import 'dart:math';

import 'package:elm/mvc/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';
import '../widget/custom_widget.dart';
import 'card_machine_page.dart';

class QuickDonate extends StatefulWidget {
  QuickDonate({Key? key}) : super(key: key);

  @override
  State<QuickDonate> createState() => _QuickDonateState();
}

class _QuickDonateState extends State<QuickDonate> {
  var rng = Random();
  String payType = "Card"; //if you want to set default value
  bool withGift = false;
  List<String> donateType = ['Sadaqah', 'Lillah', 'Zakah', 'Zakatul Fitr'];

  List<int> moneyList = [5, 10, 25, 50];
  var amount = 0;
  var newAmount = 0;
  var _selectedIndex = -1;
  String? selectedValue;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  PaymentController _paymentController = Get.put(PaymentController());

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding:
            EdgeInsets.symmetric(horizontal: width / 14, vertical: height / 16),
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
                        'HOME',
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
                  horizontal: width / 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: height / 30),
                        const Text('Quick Donate',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: fontVeryBig,
                                fontWeight: FontWeight.bold)),
                        Container(
                            height: height / 14,
                            width: 300,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Image.asset(
                                    'assets/Donate Icon.png',
                                    color: white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButton<String>(
                                    iconEnabledColor: white,
                                    value: selectedValue,
                                    items: donateType.map((dynamic val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(val,
                                              style: const TextStyle(
                                                  color: white,
                                                  fontSize: fontVerySmall)),
                                        ),
                                      );
                                    }).toList(),
                                    borderRadius: BorderRadius.circular(10),
                                    underline: const SizedBox(),
                                    disabledHint: const Text('Disable'),
                                    isExpanded: true,
                                    dropdownColor: primaryColor,
                                    hint: const Text('Choose Donation Type',
                                        style: TextStyle(color: white)),
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: fontVerySmall),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: height / 10,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i in moneyList)
                                roundButton(
                                    '£$i',
                                    _selectedIndex == i
                                        ? alternate
                                        : primaryColor,
                                    _selectedIndex == i ? alternate : white,
                                    _selectedIndex == i ? white : primaryColor,
                                    onPressed: () {
                                  setState(() {
                                    _selectedIndex = i;
                                    amount = i;
                                    if (withGift == true) {
                                      newAmount = (amount +
                                          ((amount / 100) * 20).toInt());
                                    }
                                  });
                                }),
                              Container(
                                height: height / 14,
                                width: width / 7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: primaryColor, width: 1.5)),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 4,
                                        child: Text('OTHER\nAMOUNT',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: fontVerySmall))),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: WheelChooser(
                                          onValueChanged: (s) {
                                            setState(() {
                                              amount = int.parse(
                                                  s.toString().split('£')[1]);
                                            });
                                          },
                                          datas: [
                                            for (int i = 0; i <= 50; i++) '£$i'
                                          ],
                                          itemSize: 20,
                                          magnification: 1.2,
                                          selectTextStyle:
                                              const TextStyle(color: white),
                                          unSelectTextStyle:
                                              const TextStyle(color: white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        TextButton(
                          child: RichText(
                              text: const TextSpan(
                                  text: 'CLICK HERE TO ',
                                  style: TextStyle(
                                      color: primaryColor, letterSpacing: 1),
                                  children: [
                                TextSpan(
                                  text: 'ADD 20% ',
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                                // TextSpan(
                                //   text: 'CLICK HERE TO',
                                //   style: TextStyle(
                                //       color: primaryColor, letterSpacing: 1),
                                // )
                              ])),
                          onPressed: () {
                            setState(() {
                              withGift == true
                                  ? withGift = false
                                  : withGift = true;
                            });
                            if (withGift == true) {
                              newAmount =
                                  (amount + ((amount / 100) * 20).toInt());
                            }
                          },
                        ),
                        withGift
                            ? Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height / 10,
                                      child: normalTextField(nameController,
                                          'Full Name', Icons.person),
                                    ),
                                    const SizedBox(height: 0),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height / 10,
                                      child: normalTextField(emailController,
                                          'Email Address', Icons.mail),
                                    ),
                                    const SizedBox(height: 0),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: height / 10,
                                      child: normalTextField(
                                          addressController,
                                          'Home Address',
                                          Icons.location_on_rounded),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: height / 14,
                              margin: const EdgeInsets.only(bottom: 6),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: white,
                                  ),
                                  const Text(
                                    'Card Machine',
                                    style: TextStyle(color: white),
                                  ),
                                  Radio(
                                    value: "Card",
                                    activeColor: white,
                                    groupValue: payType,
                                    onChanged: (value) {
                                      setState(() {
                                        payType = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height / 40),
                        SizedBox(
                          width: double.maxFinite,
                          height: height / 14,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: height / 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: primaryColor, width: 1.5)),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                          flex: 4,
                                          child: Text('TOTAL',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: fontSmall))),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: double.maxFinite,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              color: primaryColor,
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width: 1.5)),
                                          alignment: Alignment.center,
                                          child: Text(
                                              withGift
                                                  ? '£ $newAmount'
                                                  : '£ $amount',
                                              style: const TextStyle(
                                                  color: white,
                                                  fontSize: fontSmall)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: height / 14,
                                  child: withGift
                                      ? normalButton(
                                          "DONATE NOW", alternate, white,
                                          onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            _paymentController.makePayment(
                                              null,
                                              emailController.text,
                                              addressController.text,
                                              null,
                                              name: nameController.text,
                                              amount: newAmount,
                                            );
                                            Get.to(() => CardPage(),
                                                arguments: withGift
                                                    ? newAmount
                                                    : amount);
                                          }
                                        })
                                      : normalButton(
                                          "DONATE NOW", alternate, white,
                                          onPressed: () {
                                          _paymentController.makePayment(
                                            null,
                                            emailController.text,
                                            addressController.text,
                                            null,
                                            name: selectedValue.toString(),
                                            amount: amount,
                                          );

                                          Get.to(() => CardPage(),
                                              arguments: withGift
                                                  ? newAmount
                                                  : amount);
                                        }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
