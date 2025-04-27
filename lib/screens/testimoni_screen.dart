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
    const url = 'https://forms.gle/6nxugD1c9eofhLtv8';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimoni', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF97316),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Pesan - Pesan dari Pelanggan Sebelumnya',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
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
                      final String name = testimonial["Nama"] ?? "User";
                      final int rating = int.tryParse(testimonial["Rating Tingkat Kepuasan"]?.replaceAll(RegExp(r'[^0-9]'), '') ?? "0")?.clamp(0, 5) ?? 0;
                      final String comment = testimonial["Testimoni"] ?? "-";

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF97316),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    rating,
                                    (index) => Icon(Icons.star, color: Colors.yellow, size: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '“$comment”',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16,  fontFamily: 'Poppins'),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      "- $name",
                                      style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'Poppins'),
                                    ),
                                  ],
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
    );
  }
}
