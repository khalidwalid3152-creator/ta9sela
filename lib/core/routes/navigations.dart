import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigations {
  static void pushReplacement(BuildContext context, String go, {Object? extra}) {
    context.pushReplacement(go, extra: extra);
  }

  static void push(BuildContext context, String go, {Object? extra}) {
    context.push(go, extra: extra);
  }

  static void pushRwmoveUntil(BuildContext context, String go, {Object? extra}) {
    context.go(go, extra: extra);
  }
}
