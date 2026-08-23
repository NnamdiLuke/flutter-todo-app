import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/app.dart';

void main(List<String> args) {
  runApp(ProviderScope(child: MyApp()));
}
