import 'package:flutter/material.dart';
import '../ensemble/ensemble_screen_renderer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for the input fields
  final TextEditingController _titleController = TextEditingController(text: "Ensemble Screen");
  final TextEditingController _messageController = TextEditingController(text: "Flutter Message");
  
  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter-Ensemble Integration Demo'),
        backgroundColor: Colors.blue.shade100,
      ),
      // Wrap the body content in a SingleChildScrollView to handle keyboard overlap
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter values to pass to Ensemble screen:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // Title input field
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Screen Title',
                  border: OutlineInputBorder(),
                  hintText: 'Enter title for Ensemble screen',
                ),
              ),
              const SizedBox(height: 16),
              
              // Message input field
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  hintText: 'Enter message to send',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              
              // Button to navigate to Ensemble screen with user input
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // Navigate to an Ensemble screen with user-entered data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnsembleScreenRenderer(
                          screenId: 'XuX0bcz7JasXuyh5zjH5',
                          arguments: {
                            // User-entered values
                            'title': _titleController.text,
                            'message': _messageController.text,
                            // Fixed values
                            'timestamp': DateTime.now().toString(),
                            'dropdown_items': const [
                              'Option 1',
                              'Option 2',
                              'Option 3',
                              'Option 4'
                            ],
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('Open Ensemble Screen', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              
              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'The Ensemble screen will receive the values you entered above, '
                  'along with the current timestamp and a fixed list of dropdown options.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              
              const Divider(height: 40),
              
              // Feature description
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This demo showcases:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Passing user-entered data to Ensemble screens'),
                    Text('• Using custom Flutter widgets in Ensemble'),
                    Text('• Calling Flutter methods from Ensemble'),
                    Text('• Two-way data exchange between Flutter and Ensemble'),
                  ],
                ),
              ),
              // Add extra space at the bottom to ensure everything is visible when the keyboard is open
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}