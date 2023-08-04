import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:elm/mvc/controller/home_controller.dart';
import 'package:elm/mvc/model/admin_payment_model.dart';
import 'package:elm/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constant/value.dart';
import '../../service/api/api_client.dart';
import '../../service/api/api_exception.dart';
import 'error_controller.dart';

class AdminController extends GetxController with ErrorController {
  HomeController _homeController = Get.put(HomeController());
  var isLoading = false.obs;


//onInit method...
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPayment();
  }

  //Admin homepage Controller...
  RxInt selectedContainerIndex = 0.obs;

  void selectContainer(int index) {
    selectedContainerIndex.value = index;
  }

  ///payment controller ....
  final paymentList = AdminPayment(
    data: [],
    links: Links(first: '', last: '', prev: null, next: ''),
    meta: Meta(
      currentPage: 0,
      from: 0,
      lastPage: 0,
      links: [],
      path: '',
      perPage: 0,
      to: 0,
      total: 0,
    ),
  ).obs;

///pagination for payments
  int currentPage = 1;
  void fetchPaymentList(int page) async {
    isLoading.value = true;
    try {
      var response = await ApiClient()
          .get('/api/admin/payment?page=$page', header: Utils.apiHeader)
          .catchError(handleApiError);
      var jsonResponse = json.decode(response);
      var adminPayment = AdminPayment.fromJson(jsonResponse);
      // Update the observable with the new data
      paymentList.update((val) {
        val?.data = adminPayment.data;
        val?.links = adminPayment.links;
        val?.meta = adminPayment.meta;
      });
      // Update the current page number
      currentPage = page;
      isLoading.value = false;
    } catch (error) {
      print('Pagination Error $error');
    }
  }

  ///Get payment
  Future<void> getPayment() async {
    try {
      isLoading.value = true;
      var response = await ApiClient()
          .get('/api/admin/payment', header: Utils.apiHeader)
          .catchError(handleApiError);
      paymentList.value = adminPaymentFromJson(response);
      isLoading.value = false;
    } catch (err) {
      print("Error :  ");
      print(err);
    }
  }

//importing file from device File Picker
  File? imageeFile;

  Future<void> importProjectImage() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (file != null) {
      imageeFile = File(file.files.single.path!);
      print("$imageeFile");
    } else {
      print("failed");
    }
  }

  ///POST Project
  void postImageAndData(
      String projectName,
      String projectTitle,
      String description,
      String targetAmount,
      String zakat,
      File imgPath) async {
    // Define headers
    Utils.showLoading();
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://elm.klio.tech/api/admin/project'));
    var imageFile = File(imgPath.path);
    var imageStream = http.ByteStream(imageFile.openRead());
    var imageLength = await imageFile.length();
    var multipartFile = http.MultipartFile('image', imageStream, imageLength,
        filename: imageFile.path.split('/').last);
    request.files.add(multipartFile);
    request.fields['name'] = projectName;
    request.fields['title'] = projectTitle;
    request.fields['description'] = description;
    request.fields['target_amount'] = targetAmount;
    request.fields['zakat'] = zakat;
    request.headers.addAll(headers);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(response.statusCode);
    //print(jsonDecode(respStr));
    _homeController.loadData();
    if (response.statusCode == 200) {
      Utils.hidePopup();
      print('Image and data posted successfully ');
      Utils.showSnackBar('New project added successfully');
    } else {
      Utils.showSnackBar(
          'Error posting image and data: ${response.reasonPhrase}');
    }
  }

  ///Update Projects

  Future<void> projectUpdate(
    String projectId,
    String projectName,
    String projectTitle,
    String description,
    String targetAmount,
    String zakat,
   // File imgPath,
  ) async {
    // Define headers
    Utils.showLoading();
    var uri = Uri.parse(baseUrl + "/api/admin/project/$projectId");

    try {
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.headers.addAll(Utils.apiHeader);
      if (imageeFile != null) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', imageeFile!.path);
        request.files.add(multipartFile);
      }
      Map<String, String> _fields = Map();
      _fields.addAll(<String, String>{
        "name": projectName,
        "title": projectTitle,
        "description": description,
        "target_amount": targetAmount,
        "zakat": zakat,
        "_method": 'PUT',
      });
      request.fields.addAll(_fields);
      http.StreamedResponse response = await request.send();
      var res = await http.Response.fromStream(response);
      await _homeController.getAllProjects();
      update(["mealPeriodTable"]);
      Utils.hidePopup();
      Get.back();
      print('chekOurMessage${res.body}');
      _processResponse(res);
      //foodDataLoading();
    } on SocketException {
      throw ProcessDataException("No internet connection", uri.toString());
    } on TimeoutException {
      throw ProcessDataException("Not responding in time", uri.toString());
    }

      // "name": projectName,
      // "title": projectTitle,
      // "description": description,
      // "target_amount": targetAmount,
      // "zakat": zakat,
      // "image": null,



  }

  ///DELETE Projects

  void deleteProject(String id) async {
    Utils.showLoading();
    String endPoint = '/api/admin/project/$id';
    var response = await ApiClient()
        .delete(endPoint, header: Utils.apiHeader)
        .catchError(handleApiError);
    _homeController.loadData();
    Utils.hidePopup();
    Utils.showSnackBar('Deleted successfully');
  }

//Importing Hadith CSV File from Device.....
  File? hadithFile;

  Future<void> importHadithFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (file != null) {
      hadithFile = File(file.files.single.path!);
      print("This is path $hadithFile");
    } else {
      print("failed");
      hadithFile = null;
    }
  }

//POST hadith to API
  void postHadith(File filePath) async {
    // Define headers
    Utils.showLoading();
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://elm.klio.tech/api/admin/hadith'));
    var csvFile = File(filePath.path);
    var fileStream = http.ByteStream(csvFile.openRead());
    var fileLength = await csvFile.length();
    var multipartFile = http.MultipartFile('file', fileStream, fileLength,
        filename: csvFile.path.split('/').last);
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    print(jsonEncode(respStr));
    Utils.hidePopup();
    if (response.statusCode == 200) {
      print('File posted successfully');
      Utils.showSnackBar('File Uploaded successfully');
    } else {
      Utils.showSnackBar('Error posting File: ${response.reasonPhrase}');
    }
  }


  dynamic _processResponse(http.Response response) {
    var jsonResponse = utf8.decode(response.bodyBytes);
    print('check body response${response.body}');
    var jsonDecode = json.decode(response.body);
    Utils.showSnackBar(jsonDecode['message']);
    print(response.statusCode);
    print(response.request!.url);
    switch (response.statusCode) {
      case 200:
        return jsonResponse;
      case 201:
        return jsonResponse;
      case 422:
        return jsonResponse;
      case 400:
        throw BadRequestException(
            jsonResponse, response.request!.url.toString());
      case 500:
        throw BadRequestException(
            jsonResponse, response.request!.url.toString());
      default:
        throw ProcessDataException(
            "Error occurred with code ${response.statusCode}",
            response.request!.url.toString());
    }
  }


}
