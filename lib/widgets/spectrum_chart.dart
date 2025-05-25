import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/spectrum_provider.dart';

// ignore: use_key_in_widget_constructors
class SpectrumChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpectrumProvider>(
      builder: (_, provider, __) => Container(
        height: 300,
        padding: EdgeInsets.all(8),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueGrey,
                getTooltipItems: (spots) => spots.map((spot) {
                  return LineTooltipItem(
                    "${spot.x.toStringAsFixed(2)} MHz\n${spot.y.toStringAsFixed(2)} dBm",
                    TextStyle(color: Colors.white),
                  );
                }).toList(),
              ),
              handleBuiltInTouches: true,
            ),
            // Configuración de ejes y datos...
            titlesData: FlTitlesData(
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) => Text( // ✅ Nombre correcto
        '${(value / 1e6).toStringAsFixed(1)} MHz',
        style: TextStyle(fontSize: 10),
      ),
    ),
  ),
),
            lineBarsData: [
              LineChartBarData(
                spots: provider.spectrumData
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
                isCurved: true,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}