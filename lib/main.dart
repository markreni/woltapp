import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/providers.dart';
import './screens/venue_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const VenueScreen(),
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 8, 196, 236),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      ),
    ),
  );
}
