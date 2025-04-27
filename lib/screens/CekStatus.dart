import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cek Status',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SearchReservationPage(),
    );
  }
}

class SearchReservationPage extends StatelessWidget {
  const SearchReservationPage({super.key});

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Masukkan nomor resi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10), 
                Container(
                  height: 55, // tinggi
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
