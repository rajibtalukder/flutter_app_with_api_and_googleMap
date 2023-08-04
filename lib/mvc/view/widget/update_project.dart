
import 'package:elm/mvc/model/projects.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';
import '../../controller/admin_controller.dart';


class UpdateProject extends StatefulWidget {
  final Datum datum;

  UpdateProject(this.datum, {Key? key}) : super(key: key);

  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  AdminController _adminController = Get.put(AdminController());

  final formKey = GlobalKey<FormState>();

  String zakatType ='';

  late TextEditingController _controllerName;
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerDescription;
  late TextEditingController _controllerTargetAmount;

  @override
  void initState() {
    // TODO: implement initState
    _controllerName = TextEditingController(text: widget.datum.name);
    _controllerTitle = TextEditingController(text: widget.datum.title);
    _controllerDescription =
        TextEditingController(text: widget.datum.description);
    _controllerTargetAmount =
        TextEditingController(text: widget.datum.targetAmount);
    zakatType = widget.datum.zakat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
        child: Column(
          children: [
            SizedBox(height: 10),
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
            SizedBox(height: 20),
            Expanded(
              child: Card(
                color: white,
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  horizontal: width / 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Update/Edit Project",
                      style: TextStyle(fontSize: fontBig, color: primaryColor),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _controllerName,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: fontVerySmall, color: black),
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    //prefixIcon: Icon(Icons.text_fields, color: white),
                                    hintText: "Project Name",
                                    contentPadding: EdgeInsets.only(left: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: fontVerySmall, color: black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _controllerTitle,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: fontVerySmall, color: black),
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    //prefixIcon: Icon(Icons.text_fields, color: white),
                                    hintText: "Project Title",
                                    contentPadding: EdgeInsets.only(left: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: fontVerySmall, color: black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _controllerDescription,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: fontVerySmall, color: black),
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    //prefixIcon: Icon(Icons.text_fields, color: white),
                                    hintText: "Description",
                                    contentPadding: EdgeInsets.only(left: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: fontVerySmall, color: black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _controllerTargetAmount,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: fontVerySmall, color: black),
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    //prefixIcon: Icon(Icons.text_fields, color: white),
                                    hintText: "Target Amount",
                                    contentPadding: EdgeInsets.only(left: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: fontVerySmall, color: black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Zakat  : ",
                                      style: TextStyle(
                                          fontSize: fontSmall, color: black),
                                    ),
                                  ),
                                  Container(
                                      width: 160,
                                      child: RadioListTile(
                                        activeColor: primaryColor,
                                        contentPadding: EdgeInsets.all(0.0),
                                        value: "Eligible",
                                        groupValue: zakatType,
                                        title: Text(
                                          "Eligible",
                                          style: TextStyle(color: black),
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
                                        activeColor: primaryColor,
                                        contentPadding: EdgeInsets.all(0.0),
                                        value: "Not Eligible",
                                        groupValue: zakatType,
                                        title: Text(
                                          "Not Eligible",
                                          style: TextStyle(color: black),
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                height: 50,
                                minWidth: double.infinity,
                                color: primaryColor,
                                onPressed: () async {
                                  await _adminController.importProjectImage();
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload, color: white),
                                    Text('Update Image',
                                        style: TextStyle(
                                            fontSize: fontSmall, color: white)),
                                  ],
                                ),
                              ))),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  _adminController.imageeFile == null
                                      ? widget.datum.image

                                      ///here some method pending*******************************
                                      : _adminController.imageeFile.toString(),
                                  style: TextStyle(color: black),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: alternate,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                child: TextButton(
                                  onPressed: () async{

                                    await _adminController.projectUpdate(
                                        widget.datum.id.toString(),
                                        _controllerName.text,
                                        _controllerTitle.text,
                                        _controllerDescription.text,
                                         _controllerTargetAmount.text,
                                          zakatType.toString(),
                                        //_adminController.imageeFile as File
                                     );
                                  },
                                  child: Text("Update",
                                      style: TextStyle(
                                          fontSize: fontSmall, color: white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
