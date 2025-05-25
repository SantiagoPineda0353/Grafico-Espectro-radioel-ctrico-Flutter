import 'dart:math';

import 'package:proyecto/models/signal.dart';

class SpectrumCalculator {
  static double thermalNoise(double T, double B, [double? N]) {
    const k = 1.38064852e-23; // Boltzmann
    double noisePower = k * T * B;
    double dBm = 10 * log(noisePower / 1e-3) / log(10);
    return N != null ? dBm + N : dBm;
  }

  static List<double> generateSignal(Signal signal, int points, double fs) {
    List<double> spectrum = List.filled(points, 0.0);
    double stdDev = signal.bw / (2 * sqrt(2 * log(2)));  // Ancho Gaussiano
    
    for(int i = 0; i < points; i++) {
      double freq = i * fs / points;
      spectrum[i] = signal.potencia * exp(-pow((freq - signal.fc)/(2 * stdDev), 2));
    }
    return spectrum;
  }
}