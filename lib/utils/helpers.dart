import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:woltmobile2024/providers/providers.dart';
import 'package:woltmobile2024/utils/coordinates.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/styles.dart';

class Helpers {
  Timer? timer;

  void _saveCounter(int counter) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }

  void updateCoordinates(WidgetRef ref) {
    int counter = ref.read(counterProvider);
    // Timer for updating coordinates every 10sec
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) => {
        counter = (counter + 1) % coordinates.length,
        _saveCounter(counter),
      },
    );
  }

  void cancelTimer() {
    timer!.cancel();
  }

  void updateScreen(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final currentCounter = prefs.getInt('counter')!;
    ref.watch(counterProvider.notifier).state = currentCounter;
  }

  void showInfoSnackBar(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Refresh venues by double tapping the screen"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
      backgroundColor: CustomDesign().mainColor,
      action: SnackBarAction(
        textColor: Colors.white,
        label: "OK",
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ref.watch(infoProvider.notifier).state = true;
        },
      ),
      duration: const Duration(days: 365),
    ));
  }
}
