import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_riverpod/views/auth/login_view.dart';
import '../auth/controller/auth_controller.dart';

class HomeView extends ConsumerWidget {
  
  const HomeView({super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
           IconButton(
            onPressed: ()async{
             await ref.read(authControllerProvider).logout();
             // ignore: use_build_context_synchronously
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginView()), (route) => false);
            }, 
            icon: const Icon(Icons.logout_outlined)
            ),
        ],
      ),
      body: Column(
        children: const[
            Text("Home Page"),
           
        ],
      ),
    );
  }
}