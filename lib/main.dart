import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  // Controller for temperature TextField
  final TextEditingController _tempController = TextEditingController();

  // Dropdown options
  final List<String> _options = [
    'Celsius to Fahrenheit (°C → °F)',
    'Fahrenheit to Celsius (°F → °C)',
  ];

  String _selectedOption = 'Celsius to Fahrenheit (°C → °F)';
  String _result = '';
  String _errorMessage = '';

  // Calculate / Convert function
  void _calculate() {
    String input = _tempController.text.trim();

    // 1. Validation: check if empty
    if (input.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a temperature value';
        _result = '';
      });
      return;
    }

    // 2. Validation: check if valid number
    double? temp = double.tryParse(input);
    if (temp == null) {
      setState(() {
        _errorMessage = 'Please enter a valid number';
        _result = '';
      });
      return;
    }

    // 3. Conversion logic
    setState(() {
      _errorMessage = ''; // clear error

      if (_selectedOption == 'Celsius to Fahrenheit (°C → °F)') {
        // F = (C * 9/5) + 32
        double f = (temp * 9 / 5) + 32;
        _result = '${f.toStringAsFixed(2)} °F';
      } else {
        // C = (F - 32) * 5/9
        double c = (temp - 32) * 5 / 9;
        _result = '${c.toStringAsFixed(2)} °C';
      }
    });
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Title
                const Center(
                  child: Text(
                    'Temperature converter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Degrees and Type Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Degrees Input
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Degrees', style: TextStyle(color: Colors.grey)),
                          TextField(
                            key: const Key('temperature_input'),
                            controller: _tempController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            decoration: const InputDecoration(
                              hintText: '72',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Type Dropdown
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Type', style: TextStyle(color: Colors.grey)),
                          DropdownButton<String>(
                            key: const Key('conversion_dropdown'),
                            value: _selectedOption,
                            isExpanded: true,
                            items: _options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(
                                  option,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Result Section
                const Text('Result', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  key: const Key('result_display'),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    _result.isNotEmpty ? _result : '--',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Error Message Display
                if (_errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    key: const Key('error_message'),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // Calculate / Convert Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('calculate_button'),
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Convert',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
