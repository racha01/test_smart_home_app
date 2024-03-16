
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Scan'),
          onPressed: () async {
            await FlutterBluePlus.startScan(timeout: Duration(seconds: 4), androidUsesFineLocation: true);

            if (await FlutterBluePlus.isSupported == false) {
              print("Bluetooth not supported by this device");
              return;
            }

            FlutterBluePlus.adapterState
                .listen((BluetoothAdapterState state) async {
              if (state == BluetoothAdapterState.on) {
                
                var subscription = FlutterBluePlus.onScanResults.listen(
                  (results) {
                    if (results.isNotEmpty) {
                      ScanResult r =
                          results.last; // the most recently found device
                      print(
                          '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
                    }
                  },
                  onError: (e) => print(e),
                );

                FlutterBluePlus.cancelWhenScanComplete(subscription);

                await FlutterBluePlus.adapterState
                    .where((val) => val == BluetoothAdapterState.on)
                    .first;

                await FlutterBluePlus.startScan(
                    withServices: [Guid("180D")],
                    withNames: ["Bluno"],
                    timeout: Duration(seconds: 15));

                await FlutterBluePlus.isScanning
                    .where((val) => val == false)
                    .first;
              } else {
                // show an error to the user, etc
              }
            });
          },
        ),
      ),
    );
  }
}
