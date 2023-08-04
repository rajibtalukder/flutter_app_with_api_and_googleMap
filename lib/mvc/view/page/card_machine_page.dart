
import 'package:elm/mvc/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';
import '../widget/custom_widget.dart';
import 'payment_done.dart';
import 'package:sumup/sumup.dart';


class CardPage extends StatelessWidget {
   CardPage({Key? key}) : super(key: key, );

  // @override
  PaymentController _paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {

    var payment= Get.arguments;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Container(
      color: primaryColor,
      padding:  EdgeInsets.symmetric(horizontal: width/12, vertical: height/16),
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
              margin: EdgeInsets.symmetric(horizontal: width/6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 72,
                      width: 300,
                      child: Theme(
                        data: ThemeData(
                          canvasColor: white,
                            colorScheme: ColorScheme.light(
                                primary: primaryColor
                            )
                        ),
                        child: Stepper(
                          type: StepperType.horizontal,
                          currentStep: 0,
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          steps: const <Step>[
                            Step(
                              title: Text(''),
                              content: SizedBox(),
                              isActive: false,
                              state: StepState.disabled,
                            ),
                            Step(
                              title: Text(''),
                              content: SizedBox(),
                              isActive: true,
                              state: StepState.disabled,
                            ),
                            Step(
                              title: Text(''),
                              content: SizedBox(),
                              isActive: false,
                              state: StepState.disabled,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text('Your Payment',
                    //     style: TextStyle(
                    //         color: primaryColor,
                    //         fontSize: fontVeryBig,
                    //         fontWeight: FontWeight.bold)),

                    RichText(text:const TextSpan(
                        text: 'Your ',style: TextStyle(color: primaryColor,fontSize: 30, letterSpacing: 1),
                        children: [
                          TextSpan(
                            text: 'Payment',style: TextStyle(color: secondaryColor,fontSize: 30, fontWeight: FontWeight.bold,letterSpacing: 1),
                          )]
                    )),
                    Container(
                      height: 52,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                          Border.all(color: primaryColor, width: 1.5)),
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
                                  borderRadius:const BorderRadius.all(Radius.circular(8)),
                                  color: primaryColor,
                                  border: Border.all(
                                      color: primaryColor, width: 1.5)),
                              alignment: Alignment.center,
                              child: Text('£ $payment',
                                  style: const TextStyle(
                                      color: white, fontSize: fontSmall)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: Image.asset('assets/img 5.png'),
                    ),
                   const Text('PLEASE FOLLOW THE\nINSTRUCTIONS ON THE\nCARD MACHINE BELOW',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: borderButton(
                          'CONFIRM DONATION', alternate, white, white,
                          onPressed: () async{
                            ///Here the functionality of SUMUP payment....
                              await Sumup.init('sup_afk_beL7U0bbaS49deLKQFVRWOfIUOZEW2J');
                              var login = await Sumup.login();
                              print(login);
                              var settings = await Sumup.openSettings();
                              print(settings);
                              await Sumup.isLoggedIn;
                                await _paymentController.startSumUpPayment(payment.toDouble(), 'EUR');

                                Get.to(PaymentDone());

                          }),
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
}

