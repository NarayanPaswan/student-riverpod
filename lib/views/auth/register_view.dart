import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_riverpod/views/auth/login_view.dart';
import '../../utils/components/app_snackbar.dart';
import '../../utils/exports.dart';
import '../../utils/labels.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_login_textform_field.dart';
import '../home/home_view.dart';
import 'controller/auth_controller.dart';

class RegisterView extends ConsumerWidget {
  RegisterView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = authControllerProvider; 
    final authControllerInstance = ref.read(authControllerProvider);
    //when loading start then watch the widget changes.
    ref.watch(authProvider.select((value) => value.loading));           
    // print("widget re-build");
   

    return Stack(
      children: [
        Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: AppTextStyle.playFireBigHeading,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AppLoginTextFormField(
                    initialValue: authControllerInstance.name,
                    hintText: Labels.name,
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    onChanged: (newName) {
                      authControllerInstance.name = newName;
                    },
                  ),
                  AppLoginTextFormField(
                    initialValue: authControllerInstance.email,
                    hintText: Labels.email,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    
                    onChanged: (newEmailValue) {
                      authControllerInstance.email = newEmailValue;
                    },
                    
                    validator: (value) {
                      return authControllerInstance.emailValidate(value!);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer(builder: (context, ref, child){
                    // print("widget re-build obscure");
                    ref.watch(authProvider.select((value) => value.obscurePassword));
                    return AppLoginTextFormField(
                    initialValue: authControllerInstance.password,
                    hintText: Labels.password,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: authControllerInstance.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    suffixIconOnPressed: () {
                      authControllerInstance.obscurePassword =
                          !authControllerInstance.obscurePassword;
                    },
                    onChanged: (newPasswordValue) {
                      authControllerInstance.password = newPasswordValue;
                    },
                    obscureText: authControllerInstance.obscurePassword,
                    validator: (value) {
                      return authControllerInstance.validatePassword(value!);
                    },
                  );
                  }),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer(builder: (context,ref,child){
                    // print("widget re-build obscure");
                    ref.watch(authProvider.select((value) => value.obscureConfirmPassword));
                    return AppLoginTextFormField(
                    initialValue: authControllerInstance.confirmPassword,
                    hintText: Labels.confirmPassword,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: authControllerInstance.obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    suffixIconOnPressed: () {
                      authControllerInstance.obscureConfirmPassword =
                          !authControllerInstance.obscureConfirmPassword;
                    },
                    onChanged: (newConfirmPasswordValue) {
                      authControllerInstance.confirmPassword = newConfirmPasswordValue;
                    },
                    obscureText: authControllerInstance.obscureConfirmPassword,
                    validator: (value) {
                      return authControllerInstance.validateConfirmPassword(value!);
                    },
                  );
                  }),
            
                  AppLoginTextFormField(
                    initialValue: authControllerInstance.phone,
                    hintText: Labels.phone,
                    prefixIcon: Icons.mobile_friendly,
                    keyboardType: TextInputType.number,
                    onChanged: (newPhone) {
                      authControllerInstance.phone = newPhone;
                    },
                  ),
                  
                  const SizedBox(
                    height: 25,
                  ),
            
                  Consumer(builder: (context, ref, child){
                    ref.watch(authProvider);
                    return AppButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        
                        try {
                          await authControllerInstance.register();
                           // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomeView()), (route) => false);
                        } catch (e) {
                          AppSnackBar(context).error(e);
                        }
                      }
                    },
                    text: Labels.register.toUpperCase(),
                  );
                  }),
               
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> LoginView()), (route) => false);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: Labels.alreadyHaveAccount,
                        style: AppTextStyle.smallTextStyle,
                        children: const[
                          TextSpan(
                            text: Labels.signIn,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            
                          )
                        ]
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (authControllerInstance.loading)
          const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
