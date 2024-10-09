// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:todo_app/sensor_graph.dart';
//
//
// class SensorTrackingScreen extends StatefulWidget {
//   @override
//   _SensorTrackingScreenState createState() => _SensorTrackingScreenState();
// }
//
// class _SensorTrackingScreenState extends State<SensorTrackingScreen> {
//   final List<AccelerometerEvent> _accelerometerEvents = [];
//   final List<GyroscopeEvent> _gyroscopeEvents = [];
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
//
//   // Parameters to detect high movement
//   final double movementThreshold = 15.0; // Adjust as needed
//
//   @override
//   void initState() {
//     super.initState();
//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//           setState(() {
//             _accelerometerEvents.add(event);
//             if (_accelerometerEvents.length > 100) _accelerometerEvents.removeAt(0);
//           });
//           _checkHighMovement(event.x, event.y, event.z);
//         });
//
//     _gyroscopeSubscription =
//         gyroscopeEvents.listen((GyroscopeEvent event) {
//           setState(() {
//             _gyroscopeEvents.add(event);
//             if (_gyroscopeEvents.length > 100) _gyroscopeEvents.removeAt(0);
//           });
//           _checkHighMovement(event.x, event.y, event.z);
//         });
//   }
//
//   void _checkHighMovement(double x, double y, double z) {
//     // Simple threshold check on any two axes
//     int highAxes = 0;
//     if (x.abs() > movementThreshold) highAxes++;
//     if (y.abs() > movementThreshold) highAxes++;
//     if (z.abs() > movementThreshold) highAxes++;
//
//     if (highAxes >= 2) {
//       _showAlert();
//     }
//   }
//
//   void _showAlert() {
//     // Show an alert dialog if not already showing
//     if (!mounted) return;
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('ALERT'),
//         content: Text('High movement detected on multiple axes!'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _gyroscopeSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Sensor Tracking'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Text('Accelerometer', style: TextStyle(fontSize: 18)),
//               SizedBox(
//                 height: 200,
//                 child: SensorGraph(
//                   dataX: _accelerometerEvents,
//                   sensorType: 'accelerometer',
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text('Gyroscope', style: TextStyle(fontSize: 18)),
//               SizedBox(
//                 height: 200,
//                 child: SensorGraph(
//                   data: _gyroscopeEvents,
//                   sensorType: 'gyroscope',
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:todo_app/sensor_graph.dart';

class SensorTrackingScreen extends StatefulWidget {
  @override
  _SensorTrackingScreenState createState() => _SensorTrackingScreenState();
}

class _SensorTrackingScreenState extends State<SensorTrackingScreen> {
  final List<AccelerometerEvent> _accelerometerEvents = [];
  final List<GyroscopeEvent> _gyroscopeEvents = [];
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  final double movementThreshold = 15.0; // Adjust as needed
  int _alertCount = 0;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
          setState(() {
            _accelerometerEvents.add(event);
            if (_accelerometerEvents.length > 100) _accelerometerEvents.removeAt(0);
          });
          _checkHighMovement(event.x, event.y, event.z);
        });

    _gyroscopeSubscription =
        gyroscopeEvents.listen((GyroscopeEvent event) {
          setState(() {
            _gyroscopeEvents.add(event);
            if (_gyroscopeEvents.length > 100) _gyroscopeEvents.removeAt(0);
          });
          _checkHighMovement(event.x, event.y, event.z);
        });
  }

  void _checkHighMovement(double x, double y, double z) {
    int highAxes = 0;
    if (x.abs() > movementThreshold) highAxes++;
    if (y.abs() > movementThreshold) highAxes++;
    if (z.abs() > movementThreshold) highAxes++;

    if (highAxes >= 2) {
      _showAlert();
    }
  }

  void _showAlert() {
    if (!mounted) return;
    _alertCount++;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('ALERT $_alertCount'),
        content: Text('High movement detected on multiple axes!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 200),
                Text('Gyro', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 200,
                  child: SensorGraph(
                    dataX: _gyroscopeEvents.map((e) => e.x).toList(),
                    dataY: _gyroscopeEvents.map((e) => e.y).toList(),
                    dataZ: _gyroscopeEvents.map((e) => e.z).toList(),
                    sensorType: 'gyroscope',
                  ),
                ),
                SizedBox(height: 20),
                Text('Accelerometer Sensor Data', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 200,
                  child: SensorGraph(
                    dataX: _accelerometerEvents.map((e) => e.x).toList(),
                    dataY: _accelerometerEvents.map((e) => e.y).toList(),
                    dataZ: _accelerometerEvents.map((e) => e.z).toList(),
                    sensorType: 'accelerometer',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
