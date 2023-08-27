import 'package:flutter/material.dart';

enum Type {
  success,
  warning,
  error,
}

SnackBar toastAlert({type = Type, messages = List<String>}) {
  IconData getIcon() {
    switch (type) {
      case Type.success:
        return Icons.check_circle;

      case Type.warning:
        return Icons.assignment_late_outlined;

      case Type.error:
        return Icons.error_outline_outlined;

      default:
        return Icons.remove_red_eye_outlined;
    }
  }

  Color getBgColor() {
    switch (type) {
      case Type.success:
        return Colors.green.shade600;

      case Type.warning:
        return Colors.deepOrange.shade400;

      case Type.error:
        return Colors.red.shade400;

      default:
        return Colors.green.shade600;
    }
  }

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
              ...messages.map((message) => Text(
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
