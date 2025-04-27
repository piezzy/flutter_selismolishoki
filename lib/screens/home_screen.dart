import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'homeservice_screen.dart';
import 'bengkelservice_screen.dart';
import 'CekStatus.dart';
import 'FAQ_screen.dart';
import 'testimoni_screen.dart';
import 'testimoni_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _reservationController = TextEditingController();
  int _selectedIndex = 0;

  // Fungsi untuk menangani pemilihan item di BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah nilai indeks yang dipilih
    });

    // Navigasi ke halaman sesuai dengan indeks yang dipilih
    if (index == 1) {
      // Pindah ke SearchReservationPage jika tombol tengah ditekan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchReservationPage()),
      );
    } else if (index == 2) {
      // Pindah ke FAQPage jika tombol kanan ditekan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FAQPage()),
      );
    }
  }
  int _selectedIndex = 0;

  // Fungsi untuk menangani pemilihan item di BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah nilai indeks yang dipilih
    });

    // Navigasi ke halaman sesuai dengan indeks yang dipilih
    if (index == 1) {
      // Pindah ke SearchReservationPage jika tombol tengah ditekan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchReservationPage()),
      );
    } else if (index == 2) {
      // Pindah ke FAQPage jika tombol kanan ditekan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FAQPage()),
      );
    }
  }
  void _checkReservation() {
    if (_reservationController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchReservationPage(
            initialResiNumber: _reservationController.text,
            initialResiNumber: _reservationController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan nomor resi terlebih dahulu')),
      );
    }
  }

  @override
  void dispose() {
    _reservationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF97316),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    const SizedBox(width: 83),
                    const Text(
                      'Selismolis Hoki',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),),
                        ],
                      ),
                      child: TextField(
                        controller: _reservationController,
                        decoration: const InputDecoration(
                          hintText: 'Cek Status Servis',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _checkReservation(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF97316),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    const SizedBox(width: 83),
                    const Text(
                      'Selismolis Hoki',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),),
                        ],
                      ),
                      child: TextField(
                        controller: _reservationController,
                        decoration: const InputDecoration(
                          hintText: 'Cek Status Servis',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _checkReservation(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),),
                      ],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: _checkReservation,
                    ),
                  ),
                ],
              ),
            ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: _checkReservation,
                    ),
                  ),
                ],
              ),
            ),

            // Carousel Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 12),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: [
                      {
                        'image': 'assets/carousel1.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Ingin tahu status perbaikan kendaraan anda?',
                        'buttonText': 'Cek Status',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchReservationPage()));
                        },
                      },
                      {
                        'image': 'assets/carousel2.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Home Service dan Servis di Bengkel\nSiap Melayani Dimana Saja, Kapan Saja!',
                        'buttonText': 'Servis Sekarang',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeServiceScreen()));
                        },
                      },
                      {
                        'image': 'assets/carousel3.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Servis Kendaraan Listrik dan Sepeda Listrik Purwokerto.',
                        'buttonText': 'Servis Sekarang',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BengkelServiceScreen()));
                        },
                      },
                    ].map((item) {
                      return SizedBox(
                        width: 500,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(item['image'] as String),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.center,
                                  colors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      item['subtitle'] as String,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: item['onPressed'] as VoidCallback,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: const Size(120, 40),
                                    ),
                                    child: Text(
                                      item['buttonText'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Service Types Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Jenis Servis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
            // Carousel Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 12),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: [
                      {
                        'image': 'assets/carousel1.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Ingin tahu status perbaikan kendaraan anda?',
                        'buttonText': 'Cek Status',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchReservationPage()));
                        },
                      },
                      {
                        'image': 'assets/carousel2.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Home Service dan Servis di Bengkel\nSiap Melayani Dimana Saja, Kapan Saja!',
                        'buttonText': 'Servis Sekarang',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeServiceScreen()));
                        },
                      },
                      {
                        'image': 'assets/carousel3.jpg',
                        'title': 'Selis Molis Hoki',
                        'subtitle': 'Servis Kendaraan Listrik dan Sepeda Listrik Purwokerto.',
                        'buttonText': 'Servis Sekarang',
                        'onPressed': () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BengkelServiceScreen()));
                        },
                      },
                    ].map((item) {
                      return SizedBox(
                        width: 500,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(item['image'] as String),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.center,
                                  colors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      item['subtitle'] as String,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: item['onPressed'] as VoidCallback,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: const Size(120, 40),
                                    ),
                                    child: Text(
                                      item['buttonText'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Service Types Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Jenis Servis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 0),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                  const SizedBox(height: 0),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 4,
                    children: [
                      _buildServiceTypeButton(
                        label: 'Home Service',
                        page: HomeServiceScreen(),
                      ),
                      _buildServiceTypeButton(
                        label: 'Bengkel Service',
                        page: BengkelServiceScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Testimonial Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Testimoni Pelanggan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Single testimonial card that matches the image exactly
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: const Color(0xFFF97316),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "★★★★★",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                    childAspectRatio: 4,
                    children: [
                      _buildServiceTypeButton(
                        label: 'Home Service',
                        page: HomeServiceScreen(),
                      ),
                      _buildServiceTypeButton(
                        label: 'Bengkel Service',
                        page: BengkelServiceScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Testimonial Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Testimoni Pelanggan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Single testimonial card that matches the image exactly
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: const Color(0xFFF97316),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "★★★★★",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                '"Biaq Costum Motor Listrit Jugo Krecati"',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              const Text(
                                '"Biaq Costum Motor Listrit Jugo Krecati"',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '- User',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                              const Text(
                                '- User',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // View all testimonials button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TestimonialPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text(
                      'Lihat Semua Testimoni',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,

            ),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFFF97316),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTypeButton({
    required String label,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF97316),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // View all testimonials button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TestimonialPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text(
                      'Lihat Semua Testimoni',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 3,

            ),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFFF97316),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTypeButton({
    required String label,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF97316),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}