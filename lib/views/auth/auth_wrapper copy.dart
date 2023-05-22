// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:student_riverpod/views/auth/login_view.dart';
// import 'package:student_riverpod/views/home/home_view.dart';
// import 'controller/auth_controller.dart';


// class AuthWrapper extends ConsumerWidget {
//   const AuthWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final token = ref.read(authControllerProvider).getToken();
//     // print(token.toString());
//     return FutureBuilder<String>(
//       future: token,
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//           return const HomeView();
//         } else {
//           return  LoginView();
//         }
//       },
//     );
//   }
// }


