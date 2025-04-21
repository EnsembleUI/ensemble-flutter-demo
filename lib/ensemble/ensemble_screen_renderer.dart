import 'package:ensembleflutterdemo/ensemble/ensemble_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ensemble/ensemble.dart';
import 'package:ensemble/ensemble_app.dart';
import 'package:ensemble/framework/widget/screen.dart' as ensemble;
import 'package:ensemble/page_model.dart';
import 'package:ensemble/framework/apiproviders/api_provider.dart';

/*
 * This class is responsible for rendering an Ensemble screen within a Flutter app.
 * It acts as a bridge between Flutter and Ensemble, allowing you to:
 * 1. Navigate to an Ensemble screen from Flutter
 * 2. Pass data from Flutter to Ensemble
 * 3. Use the same navigator key for both Flutter and Ensemble
 */
class EnsembleScreenRenderer extends StatelessWidget {
  final String? screenName;     // The name of the Ensemble screen to render
  final String? screenId;       // The ID of the Ensemble screen to render
  final Map<String, dynamic>? arguments; // Data to pass to the Ensemble screen
  final Color placeholderBackgroundColor; // Background color while loading
  
  const EnsembleScreenRenderer({
    super.key,
    this.screenName,
    this.screenId,
    this.arguments,
    this.placeholderBackgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Use Ensemble's Screen widget to render the Ensemble screen
    return ensemble.Screen(
      // AppProvider is required to fetch the screen definition
      appProvider: AppProvider(
        definitionProvider: Ensemble().getConfig()!.definitionProvider,
      ),
      // Screen payload contains information about which screen to render
      screenPayload: ScreenPayload(
        screenName: screenName,
        screenId: screenId,
        arguments: arguments, // Pass data from Flutter to Ensemble
      ),
      // API providers allow the screen to make API calls
      apiProviders: APIProviders.clone(
        Ensemble().getConfig()!.apiProviders ?? {},
      ),
      // Use the same navigator key for both Flutter and Ensemble
      navigatorKey: EnsembleWrapper.navigatorKey,
      // Background color while loading
      placeholderBackgroundColor: placeholderBackgroundColor,
    );
  }
}