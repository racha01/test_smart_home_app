import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothOffScreen extends StatefulWidget {
  final BluetoothAdapterState adapterState;
  const BluetoothOffScreen({
    required this.adapterState,
    super.key
  });

  @override
  State<BluetoothOffScreen> createState() => _BluetoothOffScreenState();
}

class _BluetoothOffScreenState extends State<BluetoothOffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Off Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Bluetooth Off'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}