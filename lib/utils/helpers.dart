import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:woltmobile2024/providers/providers.dart';
import 'package:woltmobile2024/utils/coordinates.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _saveCounter(int counter) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('counter', counter);
}

void updateCoordinates(WidgetRef ref) {
  int counter = ref.read(counterProvider);
  // Timer for updating coordinates every 10sec
  Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) => {
            counter = (counter + 1) % coordinates.length,
            _saveCounter(counter),
          });
}

void updateScreen(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final currentCounter = prefs.getInt('counter')!;
  ref.read(counterProvider.notifier).state = currentCounter;
}
