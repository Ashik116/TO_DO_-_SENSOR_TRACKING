




// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:sensors_plus/sensors_plus.dart';
//
// class SensorGraph extends StatelessWidget {
//   final List<dynamic> data;
//   final String sensorType;
//
//   SensorGraph({required this.data, required this.sensorType});
//
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         minX: 0,
//         maxX: 100,
//         minY: -20,
//         maxY: 20,
//         titlesData: FlTitlesData(show: false),
//         gridData: FlGridData(show: false),
//         lineBarsData: [
//           LineChartBarData(
//             spots: _generateSpots(),
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 2,
//             dotData: FlDotData(show: false),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<FlSpot> _generateSpots() {
//     List<FlSpot> spots = [];
//     for (int i = 0; i < data.length; i++) {
//       double value;
//       if (sensorType == 'accelerometer') {
//         value = data[i].x;
//       } else {
//         value = data[i].x;
//       }
//       spots.add(FlSpot(i.toDouble(), value));
//     }
//     return spots;
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorGraph extends StatelessWidget {
  final List<double> dataX; // X-axis data
  final List<double> dataY; // Y-axis data
  final List<double> dataZ; // Z-axis data
  final String sensorType;

  SensorGraph({
    required this.dataX,
    required this.dataY,
    required this.dataZ,
    required this.sensorType,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: dataX.length.toDouble(),
        minY: -20,
        maxY: 20,
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _generateSpots(dataX),
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: _generateSpots(dataY),
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: _generateSpots(dataZ),
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSpots(List<double> data) {
    List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]));
    }
    return spots;
  }
}

