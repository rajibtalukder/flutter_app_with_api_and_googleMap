import 'package:flutter/material.dart';

import '../../../constant/color.dart';
import '../../../constant/value.dart';

Widget sideBarIconBtn(String imagePath, Color color, {Function()? onPressed}) {
  return IconButton(
    icon: Image.asset(
      imagePath,
      color: color,
    ),
    onPressed: onPressed,
  );
}

Widget bottomIconTextBtn(String imagePath, String text, Color background,
    {Function()? onPressed}) {
  return Expanded(
    child: MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: background,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: white,
            height: 15,
            width: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: white),
          )
        ],
      ),
    ),
  );
}

Widget topBarIconBtn(
    Image image, Color background, double padding, double radius, double size,
    {Function()? onPressed}) {
  return SizedBox(
    height: size,
    width: size,
    child: MaterialButton(
        elevation: 0,
        color: background,
        padding: EdgeInsets.all(padding),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: image),
  );
}

Widget iconTextBtn(
    String imagePath, String text, Color background, Color iconColor,
    {Function()? onPressed}) {
  return Column(
    children: [
      MaterialButton(
        elevation: 0,
        height: 50,
        padding: EdgeInsets.zero,
        color: background,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(imagePath, color: iconColor),
      ),
      SizedBox(height: 5),
      Expanded(child: Text(text, style: TextStyle(color: white, fontSize: fontVerySmall))),
    ],
  );
}

Widget iconTextBtnWide(
    String imagePath, String text, Color backColor, Color contentColor,
    {Function()? onPressed}) {
  return Container(
    width: 110,
    height: 60,
    decoration: BoxDecoration(
        color: backColor, borderRadius: BorderRadius.circular(10)),
    child: MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: contentColor,
          ),
          Text(text,
              style: TextStyle(color: contentColor, fontSize: fontVerySmall)),
        ],
      ),
    ),
  );
}

Widget normalButton(String text, Color background, Color textColor,
    {Function()? onPressed}) {
  return MaterialButton(
      elevation: 0,
      color: background,
      height: 40,
      minWidth: 120,
      padding: const EdgeInsets.all(10),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSmall),
      ));
}

Widget normalTextField(TextEditingController controller, String hint, IconData suffixIcon) {
  return TextFormField(
    validator: (value){
      if(value!.isEmpty){
        return 'The field is required';
      }else{
        return null;
      }
    },
      onChanged: (text) async {},
      onEditingComplete: () async {},
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: fontVerySmall, color: primaryText),
      decoration: InputDecoration(
        fillColor: secondaryBackground,
        prefixIcon: Icon(suffixIcon),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: fontVerySmall, color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}

Widget borderButton(String text, Color background, Color textColor,Color borderColor,
    {Function()? onPressed}) {
  return MaterialButton(
      elevation: 0,
      color: background,
      height: 60,
      // minWidth: 60,
      padding: EdgeInsets.all(10),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: borderColor, width: 1.5)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSmall),
      ));
}

Widget roundButton(String text, Color background, Color bgColor, Color textColor,
    {Function()? onPressed}) {
  return MaterialButton(
      elevation: 0,
      color: bgColor,
      height: 50,
      minWidth: 50,
      padding: const EdgeInsets.all(10),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
        side: BorderSide(width: 1, color: background)
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ));
}

Widget textMixer(
    String boldText, String normalText, MainAxisAlignment alignment) {
  return Row(
    mainAxisAlignment: alignment,
    children: [
      Text(
        boldText,
        style: const TextStyle(
            fontSize: fontVerySmall,
            color: primaryText,
            fontWeight: FontWeight.bold),
      ),
      Text(
        normalText,
        style: const TextStyle(fontSize: fontVerySmall, color: textSecondary),
      ),
    ],
  );
}

Widget textMixer2(
    String boldText, String normalText, MainAxisAlignment alignment) {
  return Row(
    mainAxisAlignment: alignment,
    children: [
      Text(
        boldText,
        style: const TextStyle(fontSize: fontVerySmall, color: textSecondary),
      ),
      Text(
        normalText,
        style: const TextStyle(fontSize: fontVerySmall, color: textSecondary),
      ),
    ],
  );
}

Widget textRow1(String text1, String text2) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          text1,
          style: TextStyle(
              fontSize: fontVerySmall,
              color: primaryText,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(width: 20),
      Expanded(
        flex: 1,
        child: Text(
          text2,
          style: TextStyle(
              fontSize: fontVerySmall,
              color: primaryText,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget textFieldRow1(String text1, String text2,
    {TextEditingController? controller1, TextEditingController? controller2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          flex: 1,
          child: SizedBox(
            height: 40,
            child: TextFormField(
                controller: controller1,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: fontVerySmall, color: primaryText),
                decoration: InputDecoration(
                    fillColor: secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintStyle:
                        TextStyle(fontSize: fontVerySmall, color: textSecondary),
                    hintText: text1)),
          )),
      SizedBox(width: 20),
      Expanded(
          flex: 1,
          child: SizedBox(
            height: 40,
            child: TextFormField(
                controller: controller2,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: fontVerySmall, color: primaryText),
                decoration: InputDecoration(
                    fillColor: secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintStyle:
                        TextStyle(fontSize: fontVerySmall, color: textSecondary),
                    hintText: text2)),
          )),
    ],
  );
}

Widget roundTextButton(Text text,
    {double padding = 5.0,
    Color backgroundColor = Colors.transparent,
    Color borderSideColor = Colors.transparent,
    Color shadowColor = Colors.white,
    double elevation = 0.0,
    double borderRadius = 0.0,
    Function()? onPressed}) {
  return TextButton(
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: text,
    ),
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(color: borderSideColor),
    ),
    onPressed: onPressed,
  );
}
