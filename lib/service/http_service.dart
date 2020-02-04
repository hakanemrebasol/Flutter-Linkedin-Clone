import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskproject/helper/preferences_manager.dart';
import 'package:taskproject/models/authentication/login_model.dart';
import 'package:taskproject/models/education/userEducation/user_education.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/models/profile/profile.dart';
import 'package:taskproject/models/publication/publication.dart';

class HttpService {
  static Dio dio;

  static PreferencesManager pm = new PreferencesManager();

  static final String baseUrl = "http://192.168.0.11:5000/api";
  static final String profileUrl = "/profile";
  static final String utilizationUrl = "/utilization";
  static final String experienceUrl = "/experience";
  static final String educationUrl = "/education";
  static final String skillUrl = "/skill";
  static final String publicationUrl = "/publication";

  static getPPpath(String userId) {
    return "${baseUrl}${profileUrl}/getProfilePicture/${userId}";
  }

  static getCompanyIconPath(int companyId) {
    return "${baseUrl}${utilizationUrl}/GetCompanyImage/${companyId}";
  }

  static getEducationIconPath(int educationId) {
    return "${baseUrl}${utilizationUrl}/GetEducationImage/${educationId}";
  }

  HttpService() {
    dio = createDio();
    dio = addInterceptors(dio);
  }

  Dio createDio() {
    return Dio(BaseOptions(
        connectTimeout: 10000, receiveTimeout: 10000, baseUrl: baseUrl));
  }

  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options),
          //  onResponse: (Response response) => responseInterceptor(response),
          onError: (DioError dioError) => errorInterceptor(dioError)));
  }

  dynamic requestInterceptor(RequestOptions options) async {
    dio.interceptors.requestLock.lock();
    options.headers.remove("requiresToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("access_token");
    options.headers.addAll({"Authorization": "Bearer $token"});
    dio.interceptors.requestLock.unlock();
    return options;
  }

  dynamic errorInterceptor(DioError dioError) async {
    print(dioError.response);
  }

  /*
   *
   * 
   * 2
   * Login Service
   * Start
   * 
   * 
   */

  Future<Response> getTokenWithPassword(
      LoginModel loginModel, bool rememberMe) async {
    print('***LOGIN***');
    print(loginModel.toJson().toString());
    try {
      Response response = await dio.post('/Authentication/authenticate',
          data: loginModel.toJson(),
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
      print(response.toString());
      return response;
    } on DioError catch (e) {
      print('ERR ' + e.message);
      return null;
    }
  }

  /*
   *
   * 
   * 
   * Login Service
   * End
   * 
   * 
   */

  /*
   *
   * 
   * 
   * Profile Service
   * Start
   * 
   * 
   */

  Future<Response> getProfileSummary() async {
    Response response =
        await dio.get('$profileUrl/ProfileSummary', options: Options());
    return response;
  }

  Future<Response> getProfile() async {
    Response response = await dio.get('$profileUrl', options: Options());
    return response;
  }

  Future<Response> uploadPP(File file) async {
    var data = FormData.fromMap({
      "files": [
        await MultipartFile.fromFile(file.path, filename: "pp.png"),
      ]
    });
    Response response = await dio.post('${profileUrl}/uploadpp',
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ));
    return response;
  }

  Future<Response> updateProfile(Profile updateProfileModel) async {
    print(updateProfileModel.toJson());
    Response response = await dio.put('$profileUrl/updateProfile',
        data: updateProfileModel.toJson());
    return response;
  }

  Future<Response> updateUserAbout(String newAbout) async {
    Response response =
        await dio.put('$profileUrl/updateAbout', data: {"about": newAbout});
    return response;
  }

  /*
   *
   * 
   * 
   * Profile Service
   * End
   * 
   * 
   */

  /*
   *
   * 
   * 
   * Util Service 
   * Start
   * 
   * 
   */

  Future<Response> getProvinceList() async {
    Response response =
        await dio.get('$utilizationUrl/provinces', options: Options());
    return response;
  }

  Future<Response> getDistrictList(int provinceId) async {
    Response response = await dio.get('$utilizationUrl/districts/$provinceId',
        options: Options());
    return response;
  }

  Future<Response> getIndustryList() async {
    Response response = await dio.get('$utilizationUrl/industries');
    return response;
  }

  Future<Response> getCompanies() async {
    Response response = await dio.get(
      '$utilizationUrl/companies',
    );
    return response;
  }

  Future<Response> filterEducations(String keyWord) async {
    Response response = await dio
        .post('$utilizationUrl/FilterEducations', data: {'keyWord': keyWord});
    return response;
  }

  /*
   *
   * 
   * 
   * Util Service
   * End
   * 
   * 
   */

  /*
   *
   * 
   * 
   * Experience Service
   * Start
   * 
   * 
   */

  Future<Response> addUserExperience(Experience experience) async {
    Response response = await dio.post('$experienceUrl/addUserExperience',
        data: experience.toJson());
    return response;
  }

  Future<Response> updateUserExperience(Experience experience) async {
    Response response = await dio.put('$experienceUrl/updateUserExperience',
        data: experience.toJson());
    return response;
  }

  Future<Response> deleteUserExperience(int userExperienceId) async {
    Response response = await dio.delete(
      '$experienceUrl/deleteUserExperience/$userExperienceId',
    );
    return response;
  }

  Future<Response> getExperiences() async {
    Response response = await dio.get(
      '$experienceUrl/UserExperiences',
    );
    return response;
  }

  /*
   *
   * 
   * Experience Service
   * End
   * 
   * 
   * 
   */

  /*
   *
   * 
   * Education Service
   * Start
   * 
   * 
   * 
   */

  Future<Response> addUserEducation(UserEducation userEducation) async {
    print(userEducation.toJson());
    Response response = await dio.post('$educationUrl/addUserEducation',
        data: userEducation.toJson());
    return response;
  }

  Future<Response> updateUserEducation(UserEducation userEducation) async {
    print(userEducation.toJson());
    Response response = await dio.put('$educationUrl/updateUserEducation',
        data: userEducation.toJson());
    return response;
  }

  Future<Response> deleteUserEducation(int userEducationId) async {
    Response response = await dio
        .delete('$educationUrl/deleteUserEducation/$userEducationId');
    return response;
  }

  Future<Response> getUserEducations() async {
    Response response = await dio.get('$educationUrl/GetUserEducations');
    return response;
  }

  /*
   *
   * 
   * Education Service
   * End
   * 
   * 
   * 
   */

  /*
   *
   * 
   * Skill Service
   * Start
   * 
   * 
   * 
   */

  Future<Response> getAllUserSkills() async {
    Response response = await dio.get('$skillUrl/GetAllUserSkills');
    return response;
  }

  Future<Response> getUserSkills() async {
    Response response = await dio.get('$skillUrl/GetUserSkills');
    return response;
  }

  Future<Response> addUserSkill(int skillId) async {
    Response response = await dio.post('$skillUrl/AddUserSkill/$skillId');
    return response;
  }

  Future<Response> deleteUserSkill(int skillId) async {
    Response response = await dio.delete('$skillUrl/deleteUserSkill/$skillId');
    return response;
  }

  /*
   *
   * 
   * Skill Service
   * End
   * 
   * 
   * 
   */

  /*
   *
   * 
   * Publication Service
   * Start
   * 
   * 
   * 
   */

  Future<Response> addPublication(Publication publication) async {
    Response response = await dio.post('$publicationUrl/addPublication',
        data: publication.toJson());
    return response;
  }

  Future<Response> updatePublication(Publication publication) async {
    Response response = await dio.put('$publicationUrl/updatePublication',
        data: publication.toJson());
    return response;
  }

  Future<Response> deletePublication(int publicationId) async {
    Response response =
        await dio.delete('$publicationUrl/deletePublication/$publicationId');
    return response;
  }

  Future<Response> getUserPublications() async {
    Response response = await dio.get(
      '$publicationUrl/GetUserPublications',
    );
    return response;
  }

  /*
   *
   * 
   * Publication Service
   * End
   * 
   * 
   * 
   */

}
