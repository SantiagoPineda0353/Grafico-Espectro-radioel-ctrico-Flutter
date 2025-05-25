import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/spectrum_provider.dart';
import 'package:proyecto/widgets/input_form.dart';
import 'package:proyecto/widgets/measurement_tools.dart';
import 'package:proyecto/widgets/spectrum_chart.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SpectrumProvider()),
    ],
    child: MyApp(),
  ),
);

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analizador de Espectro',
      home: Scaffold(
        appBar: AppBar(title: const Text('RF Spectrum Analyzer')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InputFormSection(),
              const SizedBox(height: 20),
              SpectrumChartWidget(),
              MeasurementToolsSection(),
            ],
          ),
        ),
      ),
    );
  }
}