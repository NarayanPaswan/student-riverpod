import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_riverpod/views/home/home_view.dart';
import '../views/auth/auth_wrapper.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import 'app_routes_name.dart';
import 'app_routes_path.dart';

class AppRouter{
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: RouteNames.authWraper,
          path: RoutesPath.authWraper,
          pageBuilder: (context, state){
            return const MaterialPage(child: AuthWrapper());
          },
      ),
      GoRoute(
          name: RouteNames.login,
          path: RoutesPath.login,
          pageBuilder: (context, state){
            return MaterialPage(child: LoginView());
          },
      ),
      GoRoute(
          name: RouteNames.home,
          path: RoutesPath.home,
          pageBuilder: (context, state){
            return const MaterialPage(child: HomeView());
          },
      ),
       GoRoute(
          name: RouteNames.register,
          path: RoutesPath.register,
          pageBuilder: (context, state){
            return  MaterialPage(child: RegisterView());
          },
      ),
    ],
    
    );
}