import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Control',
      home: DeviceListPage(),
    );
  }
}

// Halaman Daftar Perangkat
class DeviceListPage extends StatefulWidget {
  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  String selectedDevice = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Smart Control')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDeviceCard(context, 'Smart TV', 'Mitsubishi 294', '192.168.1.11', Icons.tv),
            _buildDeviceCard(context, 'Smart AC', 'Temperature 25°', '192.168.1.12', Icons.ac_unit),
            _buildDeviceCard(context, 'Smart Fan', 'Dyson 102', '192.168.1.13', Icons.air),
            _buildDeviceCard(context, 'Smart Lock', 'Lock 234', '192.168.1.14', Icons.lock),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, String title, String subtitle, String ip, IconData icon) {
    bool isSelected = selectedDevice == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDevice = title;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceControlPage(deviceName: title)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: isSelected ? Colors.blue : Colors.grey),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Text('IP: $ip', style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Kontrol Perangkat (StatefulWidget)
class DeviceControlPage extends StatefulWidget {
  final String deviceName;
  DeviceControlPage({required this.deviceName});

  @override
  _DeviceControlPageState createState() => _DeviceControlPageState();
}

class _DeviceControlPageState extends State<DeviceControlPage> {
  bool isOn = false; // Status awal perangkat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.deviceName} Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.device_hub, size: 100, color: isOn ? Colors.blue : Colors.grey),
            SizedBox(height: 10),
            Text(widget.deviceName, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
              isOn ? '✅ Status: Menyala' : '❌ Status: Mati',
              style: TextStyle(fontSize: 18, color: isOn ? Colors.blue : Colors.red),
            ),
            SizedBox(height: 20),
            Switch(
              value: isOn,
              onChanged: (value) {
                setState(() {
                  isOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
