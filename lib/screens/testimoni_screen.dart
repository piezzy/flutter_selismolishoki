import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_selismolishoki/screens/home_screen.dart';
import 'package:flutter_selismolishoki/screens/FAQ_screen.dart';
import 'package:flutter_selismolishoki/screens/CekStatus.dart';

class TestimonialPage extends StatefulWidget {
  @override
  _TestimonialPageState createState() => _TestimonialPageState();
}

class _TestimonialPageState extends State<TestimonialPage> {
  List<Map<String, String>> testimonials = [];
  int _currentIndex = 1; // Default to testimonial page (middle icon)

  @override
  void initState() {
    super.initState();
    fetchTestimonials();
  }

  Future<void> fetchTestimonials() async {
    final url =
        'https://docs.google.com/spreadsheets/d/1vA8Ev-IYUjMKldFN4Rl5gu6tWA-wncbb_cWXrdOiWRE/gviz/tq?tqx=out:csv';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<String> rows =
            response.body
                .split("\n")
                .where((row) => row.trim().isNotEmpty)
                .toList();

        List<Map<String, String>> parsedData = [];
        for (int i = 1; i < rows.length; i++) {
          List<String> columns = _parseCsvRow(rows[i]);
          if (columns.length >= 3) {
            parsedData.add({
              "Nama": columns[1].trim(),
              "Rating Tingkat Kepuasan": columns[2].trim(),
              "Testimoni": columns[3].trim(),
            });
          }
        }
        setState(() {
          testimonials = parsedData;
        });
      }
    } catch (e) {
      print('Error fetching testimonials: $e');
    }
  }

  List<String> _parseCsvRow(String row) {
    List<String> result = [];
    String current = "";
    bool inQuotes = false;
    for (int i = 0; i < row.length; i++) {
      if (row[i] == '"') {
        inQuotes = !inQuotes;
      } else if (row[i] == ',' && !inQuotes) {
        result.add(current.trim());
        current = "";
      } else {
        current += row[i];
      }
    }
    result.add(current.trim());
    return result;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SearchReservationPage(reservationNumber: ''),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FAQPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Testimoni Pelanggan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFF97316),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pesan dari Pelanggan Kami',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child:
                testimonials.isEmpty
                    ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFF97316),
                        ),
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: testimonials.length,
                      itemBuilder: (context, index) {
                        final testimonial = testimonials[index];
                        final name = testimonial["Nama"] ?? "Pelanggan";
                        final rating =
                            int.tryParse(
                              testimonial["Rating Tingkat Kepuasan"]
                                      ?.replaceAll(RegExp(r'[^0-9]'), '') ??
                                  "0",
                            ) ??
                            0;
                        final comment = testimonial["Testimoni"] ?? "";

                        return Card(
                          margin: EdgeInsets.only(bottom: 16),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star,
                                          color:
                                              i < rating
                                                  ? Colors.amber
                                                  : Colors.grey[300],
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  comment,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
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
        selectedItemColor: Color(0xFFF97316),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}
