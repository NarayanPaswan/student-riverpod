
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/components/app_constant.dart';

final authControllerProvider = ChangeNotifierProvider(
  (ref)=> AuthController(),
);

class AuthController extends ChangeNotifier {
     
  String _name='';
  String get name => _name;
  set name(String name){
    _name = name;
    notifyListeners();  
  }

  String _email='';
  String get email => _email;
  set email(String email){
    _email = email;
    notifyListeners();  
  }

  String _password ='';
  String get password => _password;
  set password(String password){
    _password = password;
    notifyListeners();
  }
  
  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String confirmPassword){
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  String _phone='';
  String get phone => _phone;
  set phone(String phone){
    _phone = phone;
    notifyListeners();  
  }
  

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
  
  String? emailValidate(String value){
    const String format = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(format).hasMatch(value) ? "Enter valid email" : null;
  }

  
  String? validatePassword(String value) {

    if (value.isEmpty) {
      return 'Please enter password';
    } else if(value.length< 8){
      return 'Password can not be less than 8 char.';
    }
    else{
      return null;
    }

  }

   String? validateConfirmPassword(String value) {

    
    if(value.isEmpty){
      return 'Please enter confirm password';
    }else if(value != password){
      return 'Confirm password does not match.';
    }
    else{
      return null;
    }

  }

  bool _obscurePassword =true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool obscureText) {
    _obscurePassword = obscureText;
    notifyListeners();
  }

  bool _obscureConfirmPassword =true;
   bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool obscureConfirmText) {
    _obscureConfirmPassword = obscureConfirmText;
    notifyListeners();
  }

   clearText() async{
    name ='';
    email = '';
    password = '';
    confirmPassword = '';
    phone = '';
    notifyListeners();
  }
  

  Future<void> login() async {
    loading = true;
    try {
      final dio = Dio();
      final response = await dio.post(
        AppConstants.loginUri,
        data: {
          'email': email,
          'password': password
        },
      );
      final token = response.data['token'];
      await _saveToken(token);
      clearText();
      _loading = false; 
         
    } catch (e) {
      loading = false;
      if (e is DioError) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['error'] != null) {
          // throw Exception(errorResponse['error']);
          throw errorResponse['error'];
        }
      }
      throw Exception('Login failed');  
      }
  }

  Future<void> register() async {
    loading = true;
    try {
      final dio = Dio();
      final response = await dio.post(
        AppConstants.registrationUri,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'phone': phone,
        },
      );
      final token = response.data['token'];
      await _saveToken(token);
      clearText();
      _loading = false; 
      
      
    } catch (e) {
    loading = false;
    if (e is DioError) {
      final errorResponse = e.response?.data;
      if (errorResponse != null && errorResponse['name'] != null) {
        final errorMessage = errorResponse['name'][0];
        throw errorMessage;

      }else if (errorResponse != null && errorResponse['email'] != null) {
        final errorMessage = errorResponse['email'][0];
        throw Exception(errorMessage);
      }
      else if (errorResponse != null && errorResponse['password'] != null) {
        final errorMessage = errorResponse['password'][0];
       throw errorMessage;
      }
      else if (errorResponse != null && errorResponse['phone'] != null) {
        final errorMessage = errorResponse['phone'][0];
        throw errorMessage;
      }
      
      else if (errorResponse != null && errorResponse['error'] != null) {
        throw Exception(errorResponse['error']);
      }
    }
    throw Exception('Register failed');
      
    }
  }
  


  Future<void> logout() async {
    await _clearToken();
  }

    Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    // print(token);
    await prefs.setString('token', token);
    
    
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
  
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // get user id
  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

 
}

