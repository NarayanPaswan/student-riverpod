class AppConstants{
  static const String appName = "StudentRiverpod";
  static const String token = "";
  static const appVersion = 1;
  static const String baseUrl ="http://192.168.16.104:8000/api/";
  static const String imageUrl ="http://192.168.16.104:8000/storage/"; 

  static const String registrationUri ="${baseUrl}auth/register";
  static const String loginUri ="${baseUrl}auth/login";
  static const String userUri ="auth/me";
  //students
  static const String allStudentsUri ='${baseUrl}auth/all-students';
 
}