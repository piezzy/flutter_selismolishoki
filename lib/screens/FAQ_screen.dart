import 'package:flutter/material.dart';
import 'package:flutter_selismolishoki/screens/home_screen.dart';
import 'package:flutter_selismolishoki/screens/CekStatus.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int _selectedIndex = 2; // Index untuk FAQ

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchReservationPage(reservationNumber: ''),
        ),
      );
    }
    // Index 2 (FAQ) tidak perlu dihandle karena sudah di halaman FAQ
  }

  final List<Map<String, String>> faqList = [
    {
      "question": "Bagaimana cara merawat sepeda listrik agar awet?",
      "answer":
          "Merawat sepeda listrik dengan baik dapat memperpanjang masa pakainya. Tips perawatan meliputi:\n\n1. Bersihkan sepeda secara rutin\n2. Periksa tekanan ban setiap 2 minggu\n3. Pelumas rantai setiap 1-2 bulan\n4. Hindari pengisian baterai semalaman\n5. Simpan di tempat kering dan teduh",
    },
    {
      "question": "Berapa lama umur baterai sepeda listrik?",
      "answer":
          "Umur baterai tergantung pada:\n\n• Jenis baterai (Li-ion biasanya 3-5 tahun)\n• Frekuensi penggunaan\n• Cara pengisian daya\n\nDengan perawatan baik, baterai bisa bertahan:\n- 500-1000 siklus charge (baterai premium)\n- 300-500 siklus charge (standar)",
    },
    {
      "question": "Apa yang harus dilakukan jika sepeda tidak menyala?",
      "answer":
          "Langkah troubleshooting:\n\n1. Periksa koneksi baterai\n2. Pastikan daya baterai cukup\n3. Cek sekring/pengaman\n4. Periksa kabel daya dan konektor\n5. Jika masih bermasalah, hubungi teknisi kami",
    },
    {
      "question": "Berapa biaya servis rutin sepeda listrik?",
      "answer":
          "Biaya servis bervariasi:\n\n• Servis kecil: Rp 50.000-100.000\n  (Pengecekan dasar, pelumasan)\n• Servis besar: Rp 150.000-300.000\n  (Ganti sparepart, tune-up sistem)\n• Free diagnosis kerusakan",
    },
    {
      "question": "Bagaimana cara reset error code?",
      "answer":
          "Proses reset tergantung merek:\n\n1. Matikan sepeda\n2. Cabut baterai selama 5 menit\n3. Pasang kembali\n4. Nyalakan\n\nJika error tetap muncul, catat kode error dan hubungi kami",
    },
    {
      "question": "Apa penyebab daya baterai cepat habis?",
      "answer":
          "Faktor penyebab:\n\n• Baterai sudah tua (kapasitas berkurang)\n• Suhu ekstrim (terlalu panas/dingin)\n• Beban berlebihan (membawa barang berat)\n• Jalur menanjak terus menerus\n• Rem terjepit/tidak berfungsi optimal",
    },
    {
      "question": "Berapa lama waktu pengisian baterai?",
      "answer":
          "Waktu charging:\n\n• Baterai kosong → penuh: 4-8 jam\n• Fast charger: 2-4 jam (sesuai spesifikasi)\n\nTips:\n- Jangan biarkan tercharge >12 jam\n- Charging 80% lebih baik untuk umur baterai",
    },
    {
      "question": "Apakah garansi mencakup kerusakan akibat banjir?",
      "answer":
          "Kebijakan garansi kami:\n\n✓ Cover: Kerusakan pabrikasi\n✗ Tidak cover:\n  - Kerusakan akibat air/banjir\n  - Modifikasi tidak resmi\n  - Kecelakaan\n\n*Detail lengkap lihat di buku garansi",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF97316),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                title: Text(
                  faqList[index]['question']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      faqList[index]['answer']!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cek Status',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'FAQ'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF97316),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
