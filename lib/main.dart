import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const KeshavOnlineCyberApp());
}

// Global list to store customer requests for Operator view
List<Map<String, dynamic>> globalPanRequests = [];

class KeshavOnlineCyberApp extends StatelessWidget {
  const KeshavOnlineCyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keshav Online Cyber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> services = const [
    {'title': 'पैन कार्ड', 'icon': '💳', 'route': 'pancard'},
    {'title': 'फोटो कॉपी & कलर प्रिंट', 'icon': '🖨️', 'route': 'other'},
    {'title': 'बिजली बिल भुगतान', 'icon': '⚡', 'route': 'other'},
    {'title': 'आधार कार्ड & पासपोर्ट फोटो', 'icon': '🪪', 'route': 'other'},
    {'title': 'ऑनलाइन फॉर्म', 'icon': '📝', 'route': 'other'},
    {'title': 'आयुष्मान & वोटर आईडी', 'icon': '🆔', 'route': 'other'},
    {'title': 'आय, जाति, निवास', 'icon': '📜', 'route': 'other'},
    {'title': 'CSC एवं अन्य कार्य', 'icon': '💻', 'route': 'other'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keshav Online Cyber',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          // Operator/Admin Panel Button
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
            tooltip: 'Operator Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OperatorLoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 3),
                image: const DecorationImage(
                  image: AssetImage('logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'केशव ऑनलाइन कंप्यूटर एंड CSC सेंटर',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            const Text(
              '📍 पिपल्याफूल, धोरानी रोड | 📞 9691259137',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'हमारी प्रमुख सेवाएं:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (services[index]['route'] == 'pancard') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PanCardFormScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${services[index]['title']} की सर्विस जल्द शुरू होगी!')),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          services[index]['icon']!,
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            services[index]['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- CUSTOMER PAN CARD FORM ---
class PanCardFormScreen extends StatefulWidget {
  const PanCardFormScreen({super.key});

  @override
  State<PanCardFormScreen> createState() => _PanCardFormScreenState();
}

class _PanCardFormScreenState extends State<PanCardFormScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  File? _aadharImage;
  File? _voterImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isAadhar) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isAadhar) {
          _aadharImage = File(pickedFile.path);
        } else {
          _voterImage = File(pickedFile.path);
        }
      });
    }
  }

  void _submitForm() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty || _aadharImage == null || _voterImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया सभी जानकारी भरें और दोनों दस्तावेज़ अपलोड करें!')),
      );
      return;
    }

    // Add request to global list so operator can see it
    globalPanRequests.add({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'aadhar': _aadharImage,
      'voter': _voterImage,
      'status': 'Pending',
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('सफलतापूर्वक जमा हुआ!'),
        content: const Text('पैन कार्ड के लिए आपके दस्तावेज़ ऑपरेटर के पास भेज दिए गए हैं। जल्द ही आपका काम शुरू होगा।'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ठीक है'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('नया पैन कार्ड आवेदन', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ग्राहक की जानकारी:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'पूरा नाम (As per ID)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'मोबाइल नंबर',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'दस्तावेज़ अपलोड करें (Documents):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(true),
                    icon: const Icon(Icons.upload_file),
                    label: Text(_aadharImage == null ? 'आधार कार्ड फोटो' : 'आधार अपलोड हो गया ✓'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _aadharImage == null ? Colors.blue.shade100 : Colors.green.shade100,
                    ),
                  ),
                ),
              ],
            ),
            if (_aadharImage != null) ...[
              const SizedBox(height: 8),
              Image.file(_aadharImage!, height: 100),
            ],
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(false),
                    icon: const Icon(Icons.upload_file),
                    label: Text(_voterImage == null ? 'वोटर आईडी फोटो' : 'वोटर आईडी अपलोड ✓'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _voterImage == null ? Colors.blue.shade100 : Colors.green.shade100,
                    ),
                  ),
                ),
              ],
            ),
            if (_voterImage != null) ...[
              const SizedBox(height: 8),
              Image.file(_voterImage!, height: 100),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'आवेदन भेजें (Submit Request)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- OPERATOR LOGIN SCREEN ---
class OperatorLoginScreen extends StatefulWidget {
  const OperatorLoginScreen({super.key});

  @override
  State<OperatorLoginScreen> createState() => _OperatorLoginScreenState();
}

class _OperatorLoginScreenState extends State<OperatorLoginScreen> {
  final _passController = TextEditingController();

  void _login() {
    // Simple password for operator: 1234 (Aap baad me badal sakte hain)
    if (_passController.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OperatorDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('गलत पासवर्ड! कृपया सही पासवर्ड दर्ज करें (Default: 1234)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ऑपरेटर लॉगिन (Admin)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_person, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              'केवल ऑपरेटर के लिए सुरक्षित क्षेत्र',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'ऑपरेटर पासवर्ड दर्ज करें',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('लॉगिन करें', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- OPERATOR DASHBOARD (ADMIN PANEL) ---
class OperatorDashboardScreen extends StatelessWidget {
  const OperatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ऑपरेटर डैशबोर्ड (Pan Card Requests)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: globalPanRequests.isEmpty
          ? const Center(
              child: Text(
                'अभी कोई नई रिक्वेस्ट नहीं है।',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: globalPanRequests.length,
              itemBuilder: (context, index) {
                final req = globalPanRequests[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('नाम: ${req['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('मोबाइल: ${req['phone']}', style: const TextStyle(fontSize: 15, color: Colors.blueGrey)),
                        const SizedBox(height: 10),
                        const Text('अपलोड किए गए दस्तावेज़:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (req['aadhar'] != null)
                              Image.file(req['aadhar'], height: 60, width: 60, fit: BoxFit.cover),
                            const SizedBox(width: 10),
                            if (req['voter'] != null)
                              Image.file(req['voter'], height: 60, width: 60, fit: BoxFit.cover),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('फाइल अपलोड और लॉक सिस्टम अगली स्टेप में जुड़ेगा!')),
                                );
                              },
                              icon: const Icon(Icons.upload_file),
                              label: const Text('तैयार फाइल अपलोड करें & Lock लगाएं'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
