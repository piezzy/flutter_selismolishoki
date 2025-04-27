import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cek status',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SearchReservationPage(reservationNumber: ''),
    );
  }
}

class SearchReservationPage extends StatelessWidget {
    final String reservationNumber;

  const SearchReservationPage({
    Key? key,
    required this.reservationNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Cek Status Perbaikan',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Center(
              child: Text(
                'Masukkan nomor resi perbaikan Anda untuk melihat status terkini dari unit yang sedang diperbaiki.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Masukkan nomor resi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                },
                child: Text('Cek Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
