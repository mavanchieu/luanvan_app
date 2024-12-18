import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 30,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              message,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

Future<void> toast(BuildContext context, String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 0, 87, 25),
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<void> toastError(BuildContext context, String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 206, 0, 34),
      textColor: Colors.white,
      fontSize: 16.0);
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.actionText,
    this.onPressed,
  });

  final String? actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(actionText ?? 'Ok', style: const TextStyle(fontSize: 16)),
    );
  }
}
