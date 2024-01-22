import 'package:flutter/material.dart';

import '../../utils/toast_msg_status.dart';

class OverlayCustomToast extends StatelessWidget {
  OverlayCustomToast(
      {super.key,
      required this.message,
      this.status = ToastMessageStatus.normal});

  ToastMessageStatus? status;
  String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
                color: Colors.black12,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: status == ToastMessageStatus.success
                ? Colors.green
                : status == ToastMessageStatus.failed
                    ? Colors.red
                    : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: status == ToastMessageStatus.normal
                        ? Colors.black
                        : Colors.white),
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
