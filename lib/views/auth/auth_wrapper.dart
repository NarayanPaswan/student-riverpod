import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:student_riverpod/views/auth/login_view.dart';
import 'package:student_riverpod/views/home/home_view.dart';
import 'controller/auth_controller.dart';


class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(authControllerProvider).getToken();
    return FutureBuilder<String>(
      future: token,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Check if the token has expired
          final tokenExpireTime = JwtDecoder.getExpirationDate(snapshot.data!);
          final currentTime = DateTime.now();
          if (currentTime.isAfter(tokenExpireTime)) {
            // Token has expired, logout and clear token
            ref.read(authControllerProvider).logout();
            return LoginView();
          } else {
            // Token is valid, show HomeView
            return const HomeView();
          }
        } else {
          return LoginView();
        }
      },
    );
  }
}



