import 'package:ensembleflutterdemo/ensemble/ensemble_wrapper.dart';
import 'package:ensembleflutterdemo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ensemble/ensemble.dart';

void main() async {
  // Ensure Flutter is initialized before doing anything else
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Ensemble first - this loads configurations, themes, and resources
  // This must be called before creating any Ensemble screens or widgets
  await Ensemble().initialize();
  
  // Run the app wrapped with EnsembleWrapper
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EnsembleWrapper(
      child: MaterialApp(
        // Pass the navigator key here to allow Ensemble to navigate between screens
        navigatorKey: EnsembleWrapper.navigatorKey,
        title: 'Flutter-Ensemble Integration Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}