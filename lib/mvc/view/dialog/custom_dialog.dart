import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/color.dart';
import '../../../constant/value.dart';

Future<void> showCustomDialog(BuildContext context, String title, Widget widget,
    int heightReduce, int widthReduce) async {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width - widthReduce,
            height: MediaQuery.of(context).size.height - heightReduce,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryBackground,
            ),
            child: Column(
              children: [
                dialogHeader(title, context),
                //Divider(color: textSecondary, thickness: 1),
                const SizedBox(height: 10),
                Expanded(
                  child: widget,
                ),
              ],
            ),
          ));
    },
  );
}

void showWarningDialog(String message, {Function()? onAccept}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: white,
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.orange,
          ),
          Text(' Warning!', style: TextStyle(color: primaryText)),
        ],
      ),
      content: Text(message, style: TextStyle(color: primaryText)),
      actions: [
        TextButton(
          onPressed: onAccept,
          child: Text("Yes"),
        ),
        TextButton(
          child: Text(
            "No",
            style: TextStyle(color: textSecondary),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

void showInputDialog(
    String title, String message, TextEditingController controller,
    {Function()? onAccept}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: alternate,
      title: Row(
        children: [
          Icon(
            Icons.input,
            color: Colors.green,
          ),
          Text('  ' + title, style: TextStyle(color: primaryText)),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: TextStyle(color: primaryText)),
          SizedBox(
            height: 40,
            child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller,
                style: TextStyle(fontSize: fontVerySmall, color: textSecondary),
                decoration: InputDecoration(
                    fillColor: secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Type here...',
                    contentPadding: EdgeInsets.only(left: 5),
                    hintStyle: TextStyle(
                        fontSize: fontVerySmall, color: textSecondary))),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onAccept,
          child: Text("Add"),
        ),
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: textSecondary),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

Widget dialogHeader(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: primaryColor),
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            color: textSecondary,
          ),
        ),
      ],
    ),
  );
}
