

import '../exports.dart';

class AppSnackBar {
  final BuildContext context;
  AppSnackBar(this.context);
  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: AppTextStyle.regularHeading,
        ),
        // behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }
}
