import 'package:flutter/material.dart';

void main() {
  runApp(const KeshavOnlineCyberApp());
}

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
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
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

class PanCardFormScreen extends StatefulWidget {
  const PanCardFormScreen({super.key});

  @override
  State<PanCardFormScreen> createState() => _PanCardFormScreenState();
}

class _PanCardFormScreenState extends State<PanCardFormScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _isAadharUploaded = false;
  bool _isVoterUploaded = false;

  void _uploadAadhar() {
    setState(() {
      _isAadharUploaded = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('आधार कार्ड फोटो चुन ली गई है!')),
    );
  }

  void _uploadVoter() {
    setState(() {
      _isVoterUploaded = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('वोटर आईडी फोटो चुन ली गई है!')),
    );
  }

  void _submitForm() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया पूरा नाम और मोबाइल नंबर भरें!')),
      );
      return;
    }

    globalPanRequests.add({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'aadhar': _isAadharUploaded ? 'Uploaded' : 'Not Uploaded',
      'voter': _isVoterUploaded ? 'Uploaded' : 'Not Uploaded',
      'status': 'Pending',
      'pdfUploaded': false,
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('सफलतापूर्वक जमा हुआ!'),
        content: const Text('पैन कार्ड आवेदन और दस्तावेज़ ऑपरेटर के पास भेज दिए गए हैं।'),
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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'पूरा नाम',
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
            const SizedBox(height: 20),
            const Text(
              'दस्तावेज़ अपलोड करें:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _uploadAadhar,
                icon: Icon(_isAadharUploaded ? Icons.check_circle : Icons.camera_alt, 
                  color: _isAadharUploaded ? Colors.green : Colors.blueAccent),
                label: Text(
                  _isAadharUploaded ? 'आधार कार्ड अपलोड हो गया ✓' : 'आधार कार्ड फोटो अपलोड करें',
                  style: TextStyle(color: _isAadharUploaded ? Colors.green.shade800 : Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(color: _isAadharUploaded ? Colors.green : Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _uploadVoter,
                icon: Icon(_isVoterUploaded ? Icons.check_circle : Icons.camera_alt, 
                  color: _isVoterUploaded ? Colors.green : Colors.blueAccent),
                label: Text(
                  _isVoterUploaded ? 'वोटर आईडी अपलोड हो गया ✓' : 'वोटर आईडी फोटो अपलोड करें',
                  style: TextStyle(color: _isVoterUploaded ? Colors.green.shade800 : Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(color: _isVoterUploaded ? Colors.green : Colors.blueAccent),
                ),
              ),
            ),
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
                child: const Text('आवेदन भेजें', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperatorLoginScreen extends StatefulWidget {
  const OperatorLoginScreen({super.key});

  @override
  State<OperatorLoginScreen> createState() => _OperatorLoginScreenState();
}

class _OperatorLoginScreenState extends State<OperatorLoginScreen> {
  final _passController = TextEditingController();

  void _login() {
    if (_passController.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OperatorDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('गलत पासवर्ड! (Default: 1234)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ऑपरेटर लॉगिन', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'पासवर्ड दर्ज करें',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                child: const Text('लॉगिन करें'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperatorDashboardScreen extends StatefulWidget {
  const OperatorDashboardScreen({super.key});

  @override
  State<OperatorDashboardScreen> createState() => _OperatorDashboardScreenState();
}

class _OperatorDashboardScreenState extends State<OperatorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ऑपरेटर डैशबोर्ड', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: globalPanRequests.isEmpty
          ? const Center(child: Text('कोई नई रिक्वेस्ट नहीं है।'))
          : ListView.builder(
              itemCount: globalPanRequests.length,
              itemBuilder: (context, index) {
                final req = globalPanRequests[index];
                bool isAccepted = req['status'] == 'Accepted' || req['status'] == 'Completed';
                bool isPdfUploaded = req['pdfUploaded'] == true;

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(req['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(
                              req['status'],
                              style: TextStyle(
                                color: isPdfUploaded ? Colors.green : (isAccepted ? Colors.blue : Colors.orange),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('मोबाइल: ${req['phone']}'),
                        Text('आधार: ${req['aadhar']} | वोटर आईडी: ${req['voter']}'),
                        const SizedBox(height: 10),
                        const Divider(),
                        // Accept and Upload PDF actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!isAccepted)
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    req['status'] = 'Accepted';
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('रिक्वेस्ट स्वीकार कर ली गई है! अब PDF अपलोड करें।')),
                                  );
                                },
                                icon: const Icon(Icons.check, size: 18),
                                label: const Text('Accept'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                              ),
                            if (isAccepted && !isPdfUploaded)
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    req['pdfUploaded'] = true;
                                    req['status'] = 'Completed (PDF Ready)';
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('पैन कार्ड PDF सफलतापूर्वक अपलोड हो गई!')),
                                  );
                                },
                                icon: const Icon(Icons.upload_file, size: 18),
                                label: const Text('Upload Pan PDF'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                              ),
                            if (isPdfUploaded)
                              const Text(
                                '✓ PDF Uploaded & Locked',
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
