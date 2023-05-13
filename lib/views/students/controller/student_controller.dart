// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:student_riverpod/models/student_model.dart';
// import 'package:student_riverpod/views/auth/controller/auth_controller.dart';

// import '../../../utils/components/app_constant.dart';


// final studentControllerProvider = ChangeNotifierProvider(
//   (ref)=> StudentController(),
// );

// class StudentController extends ChangeNotifier {
//   final Dio dio = Dio();
//   String? token;
//   List<Student>? _studentList;

//   StudentController() {
//     getTokenFromAuthController();
//   }

//   Future<void> getTokenFromAuthController() async {
//     final authController = AuthController();
//     token = await authController.getToken();
//     notifyListeners();
    
//   }

//   List<Student>? get studentList => _studentList;

//   set studentList(List<Student>? value) {
//     _studentList = value;
//     notifyListeners();
//   }

//   bool _loading = false;

//   bool get loading => _loading;

//   set loading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   Future<void> getAllStudents() async {
//     loading = true;
//     try {
//       final response = await dio.get(
//         AppConstants.allStudentsUri,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       final studentModel = StudentModel.fromJson(response.data);
//       studentList = studentModel.data!.data;
//     } catch (e) {
//       print(e);
//     } finally {
//       loading = false;
//     }
//   }
// }

