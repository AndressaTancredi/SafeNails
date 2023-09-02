import 'package:flutter/material.dart';
import 'package:safe_nails/data/app_strings.dart';

enum ToastType {
  success,
  warning,
  error,
}

SnackBar toastAlert(
    {ToastType type = ToastType.success, List<String> messages = const []}) {
  IconData getIcon() {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;

      case ToastType.warning:
        return Icons.assignment_late_outlined;

      case ToastType.error:
        return Icons.error_outline_outlined;

      default:
        return Icons.remove_red_eye_outlined;
    }
  }

  Color getBgColor() {
    switch (type) {
      case ToastType.success:
        return Colors.green.shade600;

      case ToastType.warning:
        return Colors.deepOrange.shade400;

      case ToastType.error:
        return Colors.red.shade400;

      default:
        return Colors.green.shade600;
    }
  }

  final translatedMessages = messages.map((message) {
    return AppStrings.errorMessages.containsKey(message)
        ? AppStrings.errorMessages[message]!
        : message;
  }).toList();

  return SnackBar(
    backgroundColor: getBgColor(),
    content: Row(
      children: [
        Icon(
          getIcon(),
          size: 24,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...translatedMessages.map((message) => Text(
                    message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ))
            ],
          ),
        ),
      ],
    ),
  );
}
