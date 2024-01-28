import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/providers.dart';
import './screens/venue_screen.dart';
import './utils/styles.dart';

class PageWrapper extends StatelessWidget {
  final Widget page;

  const PageWrapper(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page);
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp(
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        routes: {'/home': (context) => const VenueScreen()},
        theme: ThemeData(
            textTheme: const TextTheme(
              labelLarge: TextStyle(fontSize: 22), // snackBar label
            ),
            scaffoldBackgroundColor: CustomDesign().mainColor,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      ),
    ),
  );
}
