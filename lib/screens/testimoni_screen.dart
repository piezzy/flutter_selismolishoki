import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:async';

class TestimonialPage extends StatefulWidget {
  @override
  _TestimonialPageState createState() => _TestimonialPageState();
}

class _TestimonialPageState extends State<TestimonialPage> {
  List<Map<String, String>> testimonials = [];

  @override
  void initState() {
    super.initState();
    fetchTestimonials();
  }

  Future<void> fetchTestimonials() async {
    final url = 'https://docs.google.com/spreadsheets/d/1vA8Ev-IYUjMKldFN4Rl5gu6tWA-wncbb_cWXrdOiWRE/gviz/tq?tqx=out:csv';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<String> rows = response.body.split("\n").where((row) => row.trim().isNotEmpty).toList();
      List<Map<String, String>> parsedData = [];

      for (int i = 1; i < rows.length; i++) { 
        List<String> columns = _parseCsvRow(rows[i]);

        if (columns.length >= 3) { // Parsing data csv dan sesuaikan dengan indikator yang ada pada csv
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

  void _launchURL() async {
    final Uri url = Uri.parse('https://forms.gle/6nxugD1c9eofhLtv8');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Testimoni', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)), backgroundColor: Colors.orange,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Terimakasih telah menggunakan layanan kami, jika anda berkenan silahkan berikan testimoni pada link berikut:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: _launchURL,
                  child: Text(
                    'https://forms.gle/6nxugD1c9eofhLtv8',
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 13, 140, 244), fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: testimonials.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) {
                      final testimonial = testimonials[index];

                      final String name = testimonial["Nama"] ?? "Nama";
                      final int rating = int.tryParse(testimonial["Rating Tingkat Kepuasan"]?.replaceAll(RegExp(r'[^0-9]'), '') ?? "0")?.clamp(0, 5) ?? 0;
                      final String comment = testimonial["Testimoni"] ?? "-";

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        color: Color.fromARGB(255, 249, 255, 200),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Mengatur sudut melengkung
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: List.generate(
                                  rating,
                                  (index) => Icon(Icons.star, color: Colors.amber),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                comment,
                                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black, fontFamily: 'Poppins'),
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
    );
  }
}
