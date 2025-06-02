import 'package:flutter/material.dart';
import 'dart:convert';
import 'Transaction.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_selismolishoki/screens/home_screen.dart';
import 'package:flutter_selismolishoki/screens/FAQ_screen.dart';


class Reservation {
  final String nama;
  final String telp;
  final String servis;
  final String deskripsi;
  final String status;
  final String? tanggal;
  final String? waktuMulai;
  final String? waktuSelesai;
  final String? alamat;
  final String? latitude;
  final String? longitude;

  Reservation({
    required this.nama,
    required this.telp,
    required this.servis,
    required this.deskripsi,
    required this.status,
    this.tanggal,
    this.waktuMulai,
    this.waktuSelesai,
    this.alamat,
    this.latitude,
    this.longitude,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      nama: json['namaLengkap'],
      telp: json['noTelp'],
      servis: json['servis'],
      deskripsi: json['deskripsi'],
      status: json['status'],
      tanggal: json['tanggal'],
      waktuMulai: json['waktuMulai'],
      waktuSelesai: json['waktuSelesai'],
      alamat: json['alamat'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class SearchReservationPage extends StatefulWidget {
  final String reservationNumber;

  const SearchReservationPage({Key? key, required this.reservationNumber})
    : super(key: key);

  @override
  _SearchReservationPageState createState() => _SearchReservationPageState();
}

class _SearchReservationPageState extends State<SearchReservationPage> {
  int _currentIndex = 1;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.reservationNumber;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FAQPage()),
      );
    }
  }

  Future<void> _checkReservation() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nomor resi terlebih dahulu'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final resiNumber = _controller.text.trim();

    try {
      final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/reservasi/checkresi?noResi=$resiNumber'),
    );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        final reservation = Reservation.fromJson(data);
        _showReservationStatus(reservation);
      } else {
        _showResiNotFoundDialog();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Error fetching reservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat mengambil data.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showResiNotFoundDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Resi Tidak Ditemukan'),
            content: const Text(
              'Nomor resi yang Anda masukkan tidak terdaftar. '
              'Silakan periksa kembali nomor resi Anda.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showReservationStatus(Reservation data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Status Perbaikan'),
        content: SingleChildScrollView(
          child: Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
            },
            border: TableBorder.all(),
            children: [
              _buildRow('Nama', data.nama),
              _buildRow('No. Telepon', data.telp),
              _buildRow('Jenis Servis', data.servis),
              _buildRow('Deskripsi', data.deskripsi),
              _buildRow('Status', data.status),
              if (data.tanggal != null) _buildRow('Tanggal', data.tanggal!),
              if (data.waktuMulai != null) _buildRow('Waktu Mulai', data.waktuMulai!),
              if (data.waktuSelesai != null) _buildRow('Waktu Selesai', data.waktuSelesai!),
              if (data.alamat != null) _buildRow('Alamat', data.alamat!),
              if (data.latitude != null) _buildRow('Latitude', data.latitude!),
              if (data.longitude != null) _buildRow('Longitude', data.longitude!),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Link Pembayaran'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PembayaranPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Klik untuk lihat',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.qr_code, size: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('TUTUP'),
          ),
        ],
      ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF97316),
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
                'Masukkan nomor resi perbaikan Anda untuk melihat status terkini dari unit yang sedang diperbaikan.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Masukkan nomor resi',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
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
                  child:
                      _isLoading
                          ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: _checkReservation,
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cek Status',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'FAQ'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF97316),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
