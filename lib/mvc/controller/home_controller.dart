import 'dart:convert';

import 'package:get/get.dart';
import '../../constant/value.dart';
import '../../service/api/api_client.dart';
import '../../service/local/shared_pref.dart';
import '../../utils/utils.dart';
import '../model/hadith_model.dart';
import '../model/home_projects.dart';
import '../model/projects.dart';
import 'error_controller.dart';

class HomeController extends GetxController with ErrorController {
  var isLoading = false.obs;

  //Refresh page logic
  Future<void> loadData() async {
    token = (await SharedPref().getValue('token'))!;
    await getAllProjects();
    await getHadith();
    fetchHomeProjectsList();
    //projectList.value;
    //Utils.hidePopup();
    // Utils.hidePopup();
    // Utils.hidePopup();
  }

  final homeProjectList = HomeProjects(data: []).obs;

  void fetchHomeProjectsList() async {
    var response = await ApiClient()
        .get('/api/project', header: Utils.apiHeader)
        .catchError(handleApiError);
    print(response);
    homeProjectList.value =  homeProjectsFromJson(response);
  }

  ///Admin perjects
  final projectList = Projects(
    data: [],
    links: Links(first: '', last: '', prev: null, next: null),
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

  //Pagination for Admin project page
  int currentPage = 1;
  void fetchProjectList(int page) async {
    isLoading.value = true;
    try {
      var response = await ApiClient()
          .get('/api/admin/project?page=$page', header: Utils.apiHeader)
          .catchError(handleApiError);
      var jsonResponse = json.decode(response);
      var projectModel = Projects.fromJson(jsonResponse);
      // Update the observable with the new data
      projectList.update((val) {
        val?.data = projectModel.data;
        val?.links = projectModel.links;
        val?.meta = projectModel.meta;
      });
      // Update the current page number
      currentPage = page;
      isLoading.value = false;
    } catch (err) {
      print('Pagination Error $err');
    }
  }

//All project data show in HomePage
  Future<void> getAllProjects() async {
    try {
    isLoading.value = true;
    var response = await ApiClient()
        .get('/api/admin/project', header: Utils.apiHeader)
        .catchError(handleApiError);
    projectList.value = projectsFromJson(response);
    isLoading.value = false;
    } catch (err) {
      print(err);
    }
  }

//For home left-hadith controller
  var hadithList =
      HadithModel(data: Data(name: '', description: '', reference: '')).obs;
  Future<void> getHadith() async {
    try {
      isLoading.value = true;
      var response =
          await ApiClient().get('/api/hadith').catchError(handleApiError);
      // projectList.value = projectFromJson(response);
      hadithList.value = hadithModelFromJson(response);
      isLoading.value = false;
    } catch (err) {
      print(err);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProjects();
    getHadith();
    fetchHomeProjectsList();
  }
}
