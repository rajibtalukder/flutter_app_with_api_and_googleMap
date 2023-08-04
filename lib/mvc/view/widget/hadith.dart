import 'dart:io';

import 'package:elm/constant/color.dart';
import 'package:elm/constant/value.dart';
import 'package:elm/mvc/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Hadith extends StatefulWidget {
  Hadith({Key? key}) : super(key: key);

  @override
  State<Hadith> createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  AdminController _controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              height: 50,
              minWidth: double.infinity,
              color: white,
              onPressed: () async {
                await _controller.importHadithFile();
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload),
                  Text('Upload File',
                      style: TextStyle(fontSize: fontSmall, color: black)),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                    _controller.hadithFile==null
                        ? 'Upload here CSV file only..!'
                        : _controller.hadithFile.toString(),
                    style: TextStyle(color:_controller.hadithFile == null?black: white))),
            //SizedBox(height: 6),
            MaterialButton(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              height: 50,
              minWidth: double.infinity,
              color: alternate,
              onPressed: () async{
                _controller.postHadith(_controller.hadithFile as File);
              },
              child: Text('Submit',
                  style: TextStyle(fontSize: fontSmall, color: white)),
            )
          ],
        ),
      ),
    );
  }
}
