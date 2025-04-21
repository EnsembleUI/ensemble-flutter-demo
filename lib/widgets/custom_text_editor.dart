import 'package:flutter/material.dart';

class CustomTextEditor extends StatefulWidget {
  final String initialText;     // Initial text value
  final String label;           // Label for the editor
  final Function? onTextChanged; // Callback when text changes
  final Function? onSubmit;      // Callback when submit button is pressed
  
  const CustomTextEditor({
    super.key,
    required this.initialText,
    this.label = 'Edit Text',
    this.onTextChanged,
    this.onSubmit,
  });

  @override
  State<CustomTextEditor> createState() => _CustomTextEditorState();
}

class _CustomTextEditorState extends State<CustomTextEditor> {
  late TextEditingController _textController;
  
  @override
  void initState() {
    super.initState();
    // Initialize controller with the text from Ensemble
    _textController = TextEditingController(text: widget.initialText);
  }
  
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label row
            Row(
              children: [
                const Icon(Icons.edit),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Text field
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your text here',
              ),
              maxLines: 3,
              onChanged: (text) {
                // Send text back to Ensemble as user types
                if (widget.onTextChanged != null) {
                  widget.onTextChanged!(text);
                }
              },
            ),
            const SizedBox(height: 16),
            
            // Submit button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Send final text back to Ensemble on submit
                    if (widget.onSubmit != null) {
                      widget.onSubmit!(_textController.text);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Info text
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This text editor is a custom Flutter widget used in Ensemble',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}