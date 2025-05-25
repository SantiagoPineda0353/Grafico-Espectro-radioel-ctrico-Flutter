import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/spectrum_provider.dart';

// ignore: use_key_in_widget_constructors
class InputFormSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpectrumProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Campos para ruido térmico
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Temperatura (°K)"),
            onChanged: (v) => provider.temperatureK = double.tryParse(v) ?? 0,
          ),
          // Campos para 3 señales (similar)
          // Botón de cálculo
          ElevatedButton(
            onPressed: () => provider.calculateSpectrum(),
            child: Text("Generar Gráfico"),
          ),
        ],
      ),
    );
  }
}