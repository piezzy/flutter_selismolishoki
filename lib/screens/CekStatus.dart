import 'package:flutter/material.dart';
import 'package:flutter_selismolishoki/screens/home_screen.dart';
import 'package:flutter_selismolishoki/screens/FAQ_screen.dart';

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

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Check if reservation number is valid (dummy validation)
    final isValidResi =
        _controller.text.trim().length >= 6; // Example validation

    if (!isValidResi) {
      _showResiNotFoundDialog();
    } else {
      // If valid, proceed to show reservation status
      _showReservationStatus();
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

  void _showReservationStatus() {
    // In a real app, you would show actual reservation data
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Status Perbaikan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nomor Resi:'),
                Text(
                  _controller.text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text('Status: Dalam Proses Perbaikan'),
                const SizedBox(height: 8),
                const Text('Estimasi Selesai: 3 Hari Lagi'),
              ],
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
