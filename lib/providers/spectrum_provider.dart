import 'dart:math';

import 'package:flutter/material.dart';
import '../models/signal.dart';          // Importar modelo Signal
import '../models/noise.dart';           // Importar modelo NoiseParameters
import '../utils/calculator.dart';       // Importar SpectrumCalculator

class SpectrumProvider with ChangeNotifier {

 
  List<double> _spectrumData = [];
  List<Signal> _signals = [];
  NoiseParameters? _noiseParams;

  List<double> get spectrumData => _spectrumData;

  set temperatureK(double temperatureK) {}

  void setSignals(List<Signal> signals) {
    _signals = signals;
  }

  void setNoiseParameters(NoiseParameters params) {
    _noiseParams = params;
  }

  void calculateSpectrum() {
    if (_noiseParams == null) throw Exception("Parámetros de ruido no configurados");
    
    // 1. Calcular ruido térmico
    final noise = _noiseParams!;
    double noiseLevel = SpectrumCalculator.thermalNoise(
      noise.temperatureK,
      noise.bw,
      noise.systemNoisedBm,
    );
    
    // 2. Generar y combinar señales
    List<double> combinedSpectrum = List.filled(1024, 0.0);
    for (var signal in _signals) {
      List<double> signalData = SpectrumCalculator.generateSignal(signal, 1024, 2e9);
      combinedSpectrum = _sumLists(combinedSpectrum, signalData);
    }
    
    // 3. Añadir ruido aleatorio
    combinedSpectrum = _addNoise(combinedSpectrum, noiseLevel);
    
    _spectrumData = combinedSpectrum;
    notifyListeners();  // Actualizar UI
  }

  List<double> _sumLists(List<double> a, List<double> b) {
    return List.generate(a.length, (i) => a[i] + b[i]);
  }

  List<double> _addNoise(List<double> spectrum, double avgNoise) {
    final random = Random();
    return spectrum.map((value) {
      // Algoritmo Box-Muller para distribución normal
      double u1 = 1.0 - random.nextDouble();
      double u2 = 1.0 - random.nextDouble();
      double randNormal = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
      
      return value + avgNoise * (1 + 0.2 * randNormal);
    }).toList();
  }
}