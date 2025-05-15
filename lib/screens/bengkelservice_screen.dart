import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'location_picker_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_selismolishoki/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart'; 
import 'dart:convert';

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
  int? _selectedKerusakan;
  DateTime? _selectedDate;
  String? _selectedStartTime;
  String? _selectedEndTime;
  File? _selectedImage;
  File? _selectedVideo;
  LatLng? _selectedLocation;
  String? _locationError;
  String _reservationNumber = "GR-TESTDOANG";
  bool _isSubmitting = false;

  Map<int, String> _jenisKerusakanMap = {};

  @override
  void dispose() {
    _namaController.dispose();
    _whatsappController.dispose();
    _alamatlengkapController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadJenisKerusakan();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            constraints: const BoxConstraints(maxWidth: 340),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Reservasi Berhasil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                SelectableText(
                  'No Resi Anda: $_reservationNumber',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  onTap: () {
                    if (_reservationNumber != null) {
                      Clipboard.setData(ClipboardData(text: _reservationNumber!));
                    }
                  },
                ),

                const Text(
                  'Simpan No Resi anda untuk melihat status servis anda!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF97316),
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'OK',
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
        );
      },
    );
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
              color: const Color(0xFFF97316),
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
                          DropdownButtonFormField<int>(
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

                            // Map entries to DropdownMenuItem<int>
                            items: _jenisKerusakanMap.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,         // int id
                                child: Text(entry.value), // String name
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
                              backgroundColor: const Color(0xFFF97316), // Orange color
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isSubmitting ? null : () async {
                              if (_validateForm()) {
                                setState(() => _isSubmitting = true);
                                final success = await _submitForm();
                                setState(() => _isSubmitting = false);
                                if (success) _showSuccessDialog();
                              }
                            },
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : const Text(
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


Future<void> _loadJenisKerusakan() async {
  try {
    final map = await fetchJenisKerusakanMap();
    setState(() {
      _jenisKerusakanMap = map;
    });
  } catch (e) {
    // Handle error (e.g., show a snackbar or log)
    print('Error fetching jenis kerusakan: $e');
  }
}

  Future<Map<int, String>> fetchJenisKerusakanMap() async {
  final String apiUrl = 'http://10.0.2.2:8000/api/jenis-kerusakan/list';
  
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['status'] == 'success') {
        // Convert API response to Map<int, String> (ID → Nama)
        final Map<int, String> jenisKerusakanMap = {};
        for (var item in data['data']) {
          jenisKerusakanMap[item['id']] = item['nama'];
        }
        return jenisKerusakanMap;
      } else {
        throw Exception('Failed to load data: ${data['message']}');
      }
    } else {
      throw Exception('HTTP error ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch jenis kerusakan: $e');
  }
}


  Future<bool> _submitForm() async {  // Changed from void to Future<bool>
  final uri = Uri.parse('http://10.0.2.2:8000/api/reservasi/garage');
  final request = http.MultipartRequest('POST', uri);

  try {
    // Add form fields
    request.fields['namaLengkap'] = _namaController.text;
    request.fields['noTelp'] = _whatsappController.text;
    request.fields['alamatLengkap'] = _alamatlengkapController.text;
    request.fields['idJenisKerusakan'] = _selectedKerusakan.toString();
    request.fields['deskripsi'] = _deskripsiController.text;
    request.fields['tanggal'] = _selectedDate?.toIso8601String() ?? '';
    request.fields['waktuMulai'] = _selectedStartTime ?? '';
    request.fields['waktuSelesai'] = _selectedEndTime ?? '';

    // Add image file
    if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gambar',
            _selectedImage!.path,
            contentType: MediaType('image','png',), // adjust based on image type
          ),
        );
      }

      if (_selectedVideo != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'video',
            _selectedVideo!.path,
            contentType: MediaType('video', 'mp4'), // adjust based on video type
          ),
        );
      }
    
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        _reservationNumber = jsonData['data']['no_resi'];
        return true;  // Success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim data: ${response.statusCode}')),
        );
        return false;  // Failure
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi error: $e')),
      );
      return false;  // Failure
    }
  }
}