import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqList = [
    {
      "question": "Bagaimana cara merawat sepeda listrik agar awet?",
      "answer": "Merawat sepeda listrik dengan baik dapat memperpanjang masa pakainya. Tips perawatan meliputi pengecekan rutin baterai, tekanan ban, dan pelumas rantai. Pastikan juga untuk mengisi daya baterai secara berkala dan tidak membiarkannya habis total."
    },
    {
      "question": "Berapa lama umur baterai sepeda listrik?",
      "answer": "Umur baterai sepeda listrik bergantung pada jenis dan kualitasnya, biasanya berkisar antara 2 hingga 5 tahun. Faktor lain seperti frekuensi penggunaan, cara pengisian daya, dan kondisi penyimpanan juga memengaruhi masa pakai baterai."
    },
    {
      "question": "Apakah sepeda listrik memerlukan perawatan khusus?",
      "answer": "Ya, sepeda listrik memerlukan perawatan tambahan seperti pengecekan sistem kelistrikan, terutama baterai dan motor. Selain itu, komponen mekanis seperti rantai, rem, dan ban juga perlu perawatan seperti pada sepeda biasa."
    },
    {
      "question": "Apa saja komponen utama yang harus diganti secara berkala?",
      "answer": "Komponen yang perlu diganti secara berkala meliputi baterai, ban, rantai, dan rem. Baterai biasanya perlu diganti setelah beberapa tahun, sementara komponen mekanis seperti rantai dan ban tergantung pada frekuensi penggunaan."
    },
    {
      "question": "Bagaimana cara membersihkan sepeda listrik tanpa merusak komponen elektroniknya?",
      "answer": "Bersihkan sepeda listrik dengan menggunakan kain lembap dan hindari menyemprotkan air langsung pada komponen elektronik seperti baterai dan motor. Pastikan juga area pengisian daya tetap kering selama pembersihan."
    },
    {
      "question": "Bagaimana cara memilih baterai yang tepat untuk sepeda listrik?",
      "answer": "Pemilihan baterai yang tepat tergantung pada kapasitas (Wh) dan tegangan (V) yang sesuai dengan sepeda Anda. Sebaiknya konsultasikan dengan teknisi atau baca spesifikasi sepeda listrik Anda sebelum membeli baterai baru."
    },
    {
      "question": "Apakah suku cadang sepeda listrik mudah ditemukan?",
      "answer": "Sebagian besar suku cadang sepeda listrik seperti baterai, motor, dan komponen mekanis dapat ditemukan di bengkel resmi atau toko suku cadang. Pastikan untuk menggunakan suku cadang asli agar performa sepeda tetap optimal."
    },
    {
      "question": "Berapa biaya penggantian baterai sepeda listrik?",
      "answer": "Biaya penggantian baterai bervariasi tergantung pada jenis dan mereknya. Secara umum, harga baterai berkisar antara Rp 1.000.000 hingga Rp 3.000.000, tergantung kapasitas dan teknologinya."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 253, 255, 241),
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Atur jarak antar Card
              child: ExpansionTile(
                title: Text(
                  faqList[index]['question']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(faqList[index]['answer']!, style: TextStyle(fontFamily: 'Poppins')),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
