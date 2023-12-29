import 'package:flutter/material.dart';

void removeFocus() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

