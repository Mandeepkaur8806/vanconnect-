import 'package:flutter/material.dart';

void main() {
  runApp(VanConnectApp());
}

class VanConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VanConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class Ride {
  String driver, from, to, time, car;
  int seats;
  double price;
  Ride({required this.driver, required this.from, required this.to, required this.time, required this.car, required this.seats, required this.price});
}

class HomePage extends StatelessWidget {
  final List<Ride> rides = [
    Ride(driver: "Mandeep S.", from: "Surrey Central", to: "Downtown Vancouver", time: "7:30 AM", car: "Honda Civic - White", seats: 2, price: 10),
    Ride(driver: "Arshdeep K.", from: "Newton Exchange", to: "UBC", time: "8:00 AM", car: "Toyota Corolla - Black", seats: 3, price: 12),
    Ride(driver: "Jaspreet", from: "Scott Road Station", to: "Metrotown", time: "8:15 AM", car: "Tesla Model 3", seats: 1, price: 8),
    Ride(driver: "Simran", from: "Guildford Mall", to: "SFU Burnaby", time: "7:45 AM", car: "Hyundai Elantra", seats: 2, price: 9),
    Ride(driver: "Gurpreet", from: "Surrey Central", to: "Richmond Centre", time: "9:00 AM", car: "Kia Seltos", seats: 3, price: 11),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("VanConnect - Share Your Ride"), backgroundColor: Color(0xFF1E88E5)),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Row(children: [
              Icon(Icons.search, color: Colors.blue),
              SizedBox(width: 8),
              Text("Surrey -> Vancouver | Today 7-9 AM", style: TextStyle(fontWeight: FontWeight.bold))
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                final r = rides[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(r.driver[0]), backgroundColor: Colors.blue[100]),
                    title: Text("${r.from} → ${r.to}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("${r.driver} • ${r.car}"),
                        Text("${r.time} • ${r.seats} seats left • \$${r.price.toStringAsFixed(0)}"),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(ride: r)));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Offer a Ride"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Ride ride;
  DetailPage({required this.ride});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride Details")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${ride.from} → ${ride.to}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Driver: ${ride.driver} ⭐ 4.8 (120 rides)"),
            Text("Car: ${ride.car}"),
            Text("Time: Today at ${ride.time}"),
            Text("Price: \$${ride.price} (split gas)"),
            Text("Seats Available: ${ride.seats}"),
            SizedBox(height: 30),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ride Request Sent to ${ride.driver}!"))); }, child: Text("Request Ride - \$${ride.price}"))),
            SizedBox(height: 10),
            Text("This is for your CGI interview — you can explain how this reduces traffic, saves money, and is eco-friendly for Vancouver commuters.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}