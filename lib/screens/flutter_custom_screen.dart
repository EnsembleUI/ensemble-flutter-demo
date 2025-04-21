import 'package:flutter/material.dart';

class FlutterCustomScreen extends StatefulWidget {
  final Map<String, dynamic>? data; // Data passed from Ensemble
  
  const FlutterCustomScreen({
    super.key,
    this.data,
  });

  @override
  State<FlutterCustomScreen> createState() => _FlutterCustomScreenState();
}

class _FlutterCustomScreenState extends State<FlutterCustomScreen> {
  @override
  Widget build(BuildContext context) {
    // Extract values from data passed from Ensemble
    final title = widget.data?['title'] ?? 'Flutter Custom Screen';
    final message = widget.data?['message'] ?? 'No message provided';
    final List<String> options = [];
    
    // Convert options list from dynamic to String
    if (widget.data?['options'] is List) {
      for (var option in widget.data!['options']) {
        options.add(option.toString());
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Screen'),
        backgroundColor: Colors.green.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              Text(
                'Data received from Ensemble screen',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Display user-entered message with highlighting
              Card(
                elevation: 4,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.blue.shade200, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.message, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Message',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Text(
                          message,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Button to return to Ensemble screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Return to Ensemble Screen'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Return data back to Ensemble
                    Navigator.pop(context, {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}