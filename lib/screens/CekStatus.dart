import 'package:flutter/material.dart';

class SearchReservationPage extends StatefulWidget {
  final String? initialResiNumber;

  const SearchReservationPage({super.key, this.initialResiNumber});

  @override
  State<SearchReservationPage> createState() => _SearchReservationPageState();
}

class _SearchReservationPageState extends State<SearchReservationPage> {
  late TextEditingController _resiController;

  @override
  void initState() {
    super.initState();
    _resiController = TextEditingController(text: widget.initialResiNumber ?? '');
  }

  @override
  void dispose() {
    _resiController.dispose();
    super.dispose();
  }

  void _searchReservation() {
    final resiNumber = _resiController.text;
    if (resiNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan nomor resi terlebih dahulu')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Cek Status Perbaikan',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Masukkan nomor resi perbaikan Anda untuk melihat status terkini dari unit yang sedang diperbaiki.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _resiController,
                    decoration: const InputDecoration(
                      labelText: 'Masukkan nomor resi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 55,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: _searchReservation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}