import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'homeservice_screen.dart';
import 'bengkelservice_screen.dart';
import 'CekStatus.dart';
import 'FAQ_screen.dart';
import 'testimoni_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _reservationController = TextEditingController();

  void _checkReservation() {
    if (_reservationController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchReservationPage(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: .0),
            decoration: const BoxDecoration(
              color: Color(0xFFF97316),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _reservationController,
                            decoration: const InputDecoration(
                              hintText: 'Cek Status Servis',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _checkReservation(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _checkReservation,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Layanan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: false,
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
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['subtitle'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: item['onPressed'] as VoidCallback,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: Size(90, 35),
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7), 
                                ),
                                child: Text(
                                  item['buttonText'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, 
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> menuItems = [
                      {
                        'icon': Icons.home_repair_service,
                        'label': 'Home Service',
                        'page': HomeServiceScreen(),
                      },
                      {
                        'icon': Icons.build,
                        'label': 'Bengkel Service',
                        'page': BengkelServiceScreen(),
                      },
                      {
                        'icon': Icons.reviews,
                        'label': 'Testimoni',
                        'page': TestimonialPage(),
                      },
                      {
                        'icon': Icons.help_outline,
                        'label': 'FAQ',
                        'page': FAQPage(),
                      },
                    ];

                    if (index < menuItems.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => menuItems[index]['page']),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF4FC),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                menuItems[index]['icon'],
                                size: 38,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                menuItems[index]['label'],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // return Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade200,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}