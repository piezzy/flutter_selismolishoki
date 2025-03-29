import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'location_picker_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_selismolishoki/screens/home_screen.dart';

class BengkelServiceScreen extends StatefulWidget {
  const BengkelServiceScreen({Key? key}) : super(key: key);

  @override
  State<BengkelServiceScreen> createState() => _BengkelServiceScreenState();
}

class _BengkelServiceScreenState extends State<BengkelServiceScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _alamatlengkapController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _selectedKerusakan;
  DateTime? _selectedDate;
  String? _selectedStartTime;
  String? _selectedEndTime;
  File? _selectedImage;
  LatLng? _selectedLocation;
  String? _locationError;

  final List<String> _jenisKerusakan = [
    'Ban Kempes/Bocor',
    'Bisa Nyala tidak bisa digas',
    'Konslet/salah sambung',
    'Lemah saat dipakai, hanya mampu jarak pendek',
    'Tidak bisa kencang, lebih lambat dari biasanya',
    'Tidak bisa di cas, Lampu cas langsung hijau',
    'Lama tidak dipakai',
    'Riting nggak nyala',
    'Klakson Mati',
    'Lampu utama mati',
    'Lampu belakang mati',
    'Remot tidak berfungsi',
    'Tiba-tiba Mati',
    'Charger tidak berfungsi',
    'Kunci Kontak Hilang atau Rusak',
    'Kode Error',
    'Di gas Mblandang atau tidak bisa dikendalikan',
    'Susah berbelok',
    'Body Pecah atau Retak',
    'Aksesoris rusak',
    'Lain-lain',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _whatsappController.dispose();
    _alamatlengkapController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Servis di Bengkel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/garageservice.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Formulir Servis di Bengkel',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Servis secara mendalam kendaraan listrik Anda di bengkel kami dengan peralatan yang lebih lengkap.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'No. WhatsApp',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _whatsappController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                           const Text(
                            'Alamat Lengkap',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _alamatlengkapController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Jenis Kerusakan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedKerusakan,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                            hint: const Text('Pilih jenis kerusakan'),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: _jenisKerusakan.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedKerusakan = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Deskripsi Kerusakan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _deskripsiController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Tanggal Perbaikan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedDate = picked;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedDate == null
                                        ? 'dd/mm/yyyy'
                                        : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                                    style: TextStyle(
                                      color: _selectedDate == null ? Colors.grey[600] : Colors.black,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Waktu Mulai',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedStartTime,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                            hint: const Text('Pilih waktu mulai'),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: List.generate(24 * 60 ~/ 30, (index) {
                              String value =
                                  '${(index * 30 ~/ 60).toString().padLeft(2, '0')}:${(index * 30 % 60).toString().padLeft(2, '0')}';
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedStartTime = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Waktu Selesai',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedEndTime,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                            hint: const Text('Pilih waktu selesai'),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: List.generate(24 * 60 ~/ 30, (index) {
                              String value =
                                  '${(index * 30 ~/ 60).toString().padLeft(2, '0')}:${(index * 30 % 60).toString().padLeft(2, '0')}';
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedEndTime = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Upload Gambar Kerusakan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 1,
                                ),
                              ),
                              child: _selectedImage == null
                                  ? const Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                                          SizedBox(height: 8),
                                          Text('Tap untuk upload gambar'),
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_validateForm()) {
                                _submitForm();
                              }
                            },
                            child: const Text(
                              'Kirim',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateForm() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama lengkap')),
      );
      return false;
    }

    if (_whatsappController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nomor WhatsApp')),
      );
      return false;
    }

    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih lokasi')),
      );
      return false;
    }

    if (_selectedKerusakan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih jenis kerusakan')),
      );
      return false;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal perbaikan')),
      );
      return false;
    }

    return true;
  }

  void _submitForm() {
    final formData = {
      'nama': _namaController.text,
      'whatsapp': _whatsappController.text,
      'alamat lengkap': _alamatlengkapController.text,
      'lokasi': _selectedLocation,
      'jenis_kerusakan': _selectedKerusakan,
      'deskripsi': _deskripsiController.text,
      'tanggal': _selectedDate?.toIso8601String(),
      'waktu_mulai': _selectedStartTime,
      'waktu_selesai': _selectedEndTime,
      'gambar': _selectedImage?.path,
    };

    print('Form submitted: $formData');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permintaan servis berhasil dikirim')),
    );

  }
}