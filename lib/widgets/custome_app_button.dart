import '../utils/exports.dart';


class CustomeAppButton extends StatelessWidget {
  const CustomeAppButton({
    super.key, required this.onPressed, required this.buttonText, required this.icon
  });
 final VoidCallback onPressed;
 final String buttonText;
 final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                AppColorsStyle.myaccountButtonBGColor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                    vertical: 18, horizontal: 6)),
            shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                const RoundedRectangleBorder()),
          ),
          icon: Icon(
            icon,
            // CupertinoIcons.person_fill,
            color: AppColorsStyle.exclamationIconColor,
          ),
          label: Text(
            // "My Account",
            buttonText,
            style: TextStyle(
                color: AppColorsStyle
                    .myaccountButtonTextColor),
          )),
    );
  }
}
