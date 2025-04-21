import 'package:ensembleflutterdemo/screens/flutter_custom_screen.dart';
import 'package:ensembleflutterdemo/widgets/custom_dropdown.dart';
import 'package:ensembleflutterdemo/widgets/custom_text_editor.dart';
import 'package:flutter/material.dart';
import 'package:ensemble/ensemble.dart';
import 'package:ensemble/ensemble_app.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EnsembleWrapper extends StatelessWidget {
  final Widget child;

  // Navigator key for navigation between screens
  // This is shared with the MaterialApp to allow programmatic navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const EnsembleWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EnsembleApp(
      // Pass the navigator key to Ensemble for navigation between screens
      navigatorKey: navigatorKey,
      // Pass the Ensemble configuration to the app
      ensembleConfig: Ensemble().getConfig(),
      // Register external methods that can be called from Ensemble screens
      externalMethods: _getExternalMethods(),
      // Register custom Flutter widgets that can be used within Ensemble screens
      externalWidgets: _getExternalWidgets(),
      // The Flutter app to wrap with Ensemble
      child: child,
    );
  }

  /*
   * External methods can be called from Ensemble screens using the callExternalMethod action.
   * Each method is registered with a name and can accept parameters from Ensemble.
   * Example YAML usage:
   * 
   * callExternalMethod:
   *   name: navigateToFlutterScreen
   *   payload:
   *     title: "Screen from Ensemble"
   *     message: "This screen was opened from Ensemble"
   */
  Map<String, Function> _getExternalMethods() {
    return {
      // Method to navigate to a Flutter screen from Ensemble
      'navigateToFlutterScreen': (
          {String? title, String? message, List? options}) {
        // Create a map of the parameters received from Ensemble
        final Map<String, dynamic> data = {
          if (title != null) 'title': title,
          if (message != null) 'message': message,
          if (options != null) 'options': options,
        };
        print('Navigating to Flutter screen with data: $data');

        // Navigate to a Flutter screen with the collected data
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => FlutterCustomScreen(data: data),
          ),
        );
      },

      // Method to show a Flutter modal dialog from Ensemble
      'showFlutterModal': ({String? title, String? message}) {
        final Map<String, dynamic> data = {
          if (title != null) 'title': title,
          if (message != null) 'message': message,
        };

        print('Showing Flutter modal with data: $data');

        // Show modal with the passed data
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Flutter Modal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Data received from Ensemble:'),
                const SizedBox(height: 8),
                Text(data.toString()),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },

      // Method to get user profile data and return it to Ensemble
      'getUserProfile': () {
        // Return some mock user profile data for demo purposes
        // This data will be available in the onComplete event in Ensemble
        return {
          'name': 'Test User',
          'languageCode': 'en',
          'email': 'user@example.com'
        };
      },
    };
  }

  /*
   * External widgets can be used within Ensemble screens using the ExternalWidget component.
   * Each widget is registered with a name and can receive parameters from Ensemble.
   * Example YAML usage:
   * 
   * ExternalWidget:
   *   name: CustomDropdown
   *   inputs:
   *     items: ${ensemble.storage.dropdownItems}
   *     title: "Select an option"
   *   events:
   *     onChange:
   *       executeCode:
   *         body: |
   *           ensemble.storage.selectedOption = event.data.value;
   */
  Map<String, CustomBuilder> _getExternalWidgets() {
    return {
      // Custom dropdown widget
      'CustomDropdown': (BuildContext context, Map<String, dynamic>? data) {
        // Extract data for the dropdown from the payload
        List<String> items = [];
        if (data?['items'] is List) {
          items =
              (data!['items'] as List).map((item) => item.toString()).toList();
        }

        // Ensure selectedValue is valid
        String? selectedValue;
        if (data?['selectedValue'] != null) {
          // If selectedValue is provided, ensure it's in the items list
          selectedValue = data!['selectedValue'].toString();
          if (!items.contains(selectedValue)) {
            // If the provided selectedValue is not in the list, set to null
            selectedValue = null;
          }
        }

        // Create and return the custom dropdown widget
        return CustomDropdown(
          items: items,
          selectedValue: selectedValue,
          title: data?['title'] ?? 'Select an option',
          // Map event handlers from Ensemble to the widget
          events: {
            'onChange': data?['onChange'],
            'onValueChanged': data?['onValueChanged'],
            'onFocus': data?['onFocus'],
            'onBlur': data?['onBlur'],
          },
        );
      },

      // Custom text editor widget
      'CustomTextEditor': (BuildContext context, Map<String, dynamic>? data) {
        // Create and return the custom text editor widget
        return CustomTextEditor(
          initialText: data?['initialText'] ?? '',
          label: data?['label'] ?? 'Edit Text',
          onTextChanged: data?['onTextChanged'],
          onSubmit: data?['onSubmit'],
        );
      },

      // Custom toggle switch widget
      'CustomToggleSwitch': (BuildContext context, Map<String, dynamic>? data) {
        // Extract data for the toggle switch from the payload
        List<String> labels = [];
        if (data?['labels'] is List) {
          labels =
              (data!['labels'] as List).map((item) => item.toString()).toList();
        }

        // Extract the initial index
        int initialIndex = -1;
        if (data?['initialIndex'] != null) {
          initialIndex = int.tryParse(data!['initialIndex'].toString()) ?? -1;
        }

        // Return the toggle switch widget directly
        return ToggleSwitch(
          // Number of switches - derived from labels length
          totalSwitches: labels.length,
          // Labels array
          labels: labels,
          // Set initial selected index (-1 means nothing selected initially)
          initialLabelIndex: initialIndex,
          // Customize appearance - these can also be passed as payload if desired
          minWidth: 100.0,
          cornerRadius: 20.0,
          activeBgColors: const [
            [Colors.blue],
            [Colors.green],
            [Colors.orange],
            [Colors.purple]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey.shade300,
          inactiveFgColor: Colors.grey.shade800,
          // Handle toggle selection - call the onChange handler from Ensemble
          onToggle: (index) {
            if (data != null && data['onChange'] != null && index != null) {
              // Call the onChange handler with the selected index
              data['onChange'](index);
            }
          },
        );
      },
    };
  }
}
