import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'homeservice_screen.dart';
import 'bengkelservice_screen.dart';
import 'CekStatus.dart';
import 'FAQ_screen.dart';
import 'testimoni_screen.dart'; 


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.orange,
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
                      const SizedBox(width: 12),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Halo,',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Selamat datang!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
                    child: const Row(
                      children: [
                        Text(
                          'Cek Pesananmu',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.search),
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
                  'Promo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 120,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                  items: [
                    'assets/testpromo.jpeg',
                    'assets/testpromo2.jpeg',
                    'assets/testpromo3.jpeg',
                  ].map((imagePath) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
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
                      'icon': Icons.search,
                      'label': 'Reservasi',
                      'page': SearchReservationPage(),
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
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
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