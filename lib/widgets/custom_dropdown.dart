import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;         // List of dropdown options
  final dynamic selectedValue;      // Currently selected value
  final String title;               // Title of the dropdown
  final Map<String, Function?>? events;  // Map of event handlers from Ensemble
  
  const CustomDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.title = 'Select an option',
    this.events,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    
    // Initialize with value passed from Ensemble
    if (widget.selectedValue != null) {
      _selectedValue = widget.selectedValue.toString();
    }
    
    // Set up focus listener to trigger focus/blur events
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _triggerEvent('onFocus');
      } else {
        _triggerEvent('onBlur');
      }
    });
  }
  
  /*
   * Trigger an event handler if it exists in the events map
   * The value parameter is the data to pass back to Ensemble
   * It will be available in Ensemble as event.data.value
   */
  void _triggerEvent(String eventName, [dynamic value]) {
    print('Triggering event: $eventName with value: $value');
    if (widget.events != null && widget.events![eventName] != null) {
      print('Event $eventName triggered');
      widget.events![eventName]!(value);
    }
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title row
              Row(
                children: [
                  const Icon(Icons.arrow_drop_down_circle_outlined),
                  const SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              
              // Dropdown field
              if (widget.items.isEmpty)
                const Text('No items available')
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text('Select an option'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                      print('Selected value: $newValue');
                      
                      // Trigger onChange event to send data back to Ensemble
                      _triggerEvent('onChange', newValue);
                      
                      // For backward compatibility
                      _triggerEvent('onValueChanged', newValue);
                    },
                    items: widget.items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 16),
              
              // Info text
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This dropdown is a custom Flutter widget used in Ensemble',
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
      ),
    );
  }
}