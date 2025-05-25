import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MeasurementToolsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.straighten),
          onPressed: () => _activateMeasurementMode(context),
        ),
        IconButton(
          icon: Icon(Icons.save), onPressed: () {  },
          
        ),
      ],
    );
  }

  void _activateMeasurementMode(BuildContext context) {
    // Implementar lógica para selección de puntos
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Modo Medición"),
        content: Text("Toque dos puntos en el gráfico para medir"),
      ),
    );
  }

  
}