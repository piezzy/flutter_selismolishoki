import 'package:flutter/material.dart';

class TestimonialPage extends StatefulWidget {
  @override
  _TestimonialPageState createState() => _TestimonialPageState();
}

class _TestimonialPageState extends State<TestimonialPage> {
  List<Map<String, dynamic>> testimonials = [
    {
      "Nama": "Andi",
      "Rating": 4,
      "Testimoni": "Pelayanan sangat memuaskan!"
    },
    {
      "Nama": "Budi",
      "Rating": 5,
      "Testimoni": "Sangat direkomendasikan, mantap!"
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 5;
  bool _hasSubmitted = false;

  int _currentIndex = 1;

  void _addTestimonial() {
    if (_nameController.text.trim().isEmpty || _commentController.text.trim().isEmpty) return;

    setState(() {
      testimonials.insert(0, {
        "Nama": _nameController.text.trim(),
        "Rating": _selectedRating,
        "Testimoni": _commentController.text.trim(),
      });
      _hasSubmitted = true;
    });

    _nameController.clear();
    _commentController.clear();
    _selectedRating = 5;

    // Show thank you dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Terima Kasih!'),
        content: Text('Terima kasih telah memberi testimoni.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Tutup'),
          )
        ],
      ),
    );
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Tambahkan navigasi sesuai kebutuhan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testimoni', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF97316),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              !_hasSubmitted
                  ? Column(
                      children: [
                        Text(
                          'Beri Testimoni Anda',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text('Rating:', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 10),
                            Row(
                              children: List.generate(
                                5,
                                (index) => IconButton(
                                  icon: Icon(
                                    index < _selectedRating ? Icons.star : Icons.star_border,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedRating = index + 1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          controller: _commentController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Testimoni',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _addTestimonial,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF97316),
                          ),
                          child: Text('Kirim Testimoni', style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
                        ),
                        SizedBox(height: 24),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Anda sudah memberikan testimoni.',
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.grey[700]),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
              Divider(),
              Text(
                'Testimoni Pengguna',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 12),
              ...testimonials.map((testimonial) {
                final String name = testimonial["Nama"];
                final int rating = testimonial["Rating"];
                final String comment = testimonial["Testimoni"];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFFF97316),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('“$comment”', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                              SizedBox(height: 10),
                              Text('- $name', style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'Poppins')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFF97316),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Reservasi'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'FAQ'),
        ],
      ),
    );
  }
}
