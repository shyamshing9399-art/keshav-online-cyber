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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'हमारी प्रमुख सेवाएं:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerStatusScreen()),
                    );
                  },
                  icon: const Icon(Icons.track_changes),
                  label: const Text('मेरा स्टेटस देखें'),
                ),
              ],
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

class CustomerStatusScreen extends StatelessWidget {
  const CustomerStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('मेरे आवेदन और स्टेटस', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: globalPanRequests.isEmpty
          ? const Center(child: Text('आपने अभी तक कोई आवेदन नहीं किया है।', style: TextStyle(fontSize: 16)))
          : ListView.builder(
              itemCount: globalPanRequests.length,
              itemBuilder: (context, index) {
                final req = globalPanRequests[index];
                bool isCompleted = req['pdfUploaded'] == true;

                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('नाम: ${req['name']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('मोबाइल: ${req['phone']}'),
                        const SizedBox(height: 8),
                        Text(
                          'स्टेटस: ${req['status']}',
                          style: TextStyle(
                            color: isCompleted ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (isCompleted)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('🔒 Pan Card File (Locked)', style: TextStyle(fontWeight: FontWeight.bold)),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('QR स्कैन करके भुगतान करें'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('फाइल अनलॉक करने के लिए QR कोड पर पेमेंट करें:'),
                                            const SizedBox(height: 15),
                                            Container(
                                              height: 150,
                                              width: 150,
                                              color: Colors.grey.shade300,
                                              child: const Center(
                                                child: Text('QR CODE\n[Scanner]', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text('राशि: ₹ 50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('बंद करें'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.lock_open, size: 16),
                                  label: const Text('Download'),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
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
  bool _aadharDone = false;
  bool _voterDone = false;

  void _submitForm() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया पूरा नाम और मोबाइल नंबर भरें!')),
      );
      return;
    }

    if (!_aadharDone || !_voterDone) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया आधार और वोटर आईडी दोनों कन्फर्म करें!')),
      );
      return;
    }

    globalPanRequests.add({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'aadhar': 'Verified',
      'voter': 'Verified',
      'status': 'Pending',
      'pdfUploaded': false,
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('सफलतापूर्वक जमा हुआ!'),
        content: const Text('पैन कार्ड आवेदन ऑपरेटर के पास भेज दिया गया है।'),
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
              'दस्तावेज़ की स्थिति:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('आधार कार्ड अपलोड / कन्फर्म किया गया'),
              value: _aadharDone,
              onChanged: (val) {
                setState(() {
                  _aadharDone = val ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('वोटर आईडी अपलोड / कन्फर्म किया गया'),
              value: _voterDone,
              onChanged: (val) {
                setState(() {
                  _voterDone = val ?? false;
                });
              },
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
                bool isAccepted = req['status'] == 'Accepted' || req['status'] == 'Completed (PDF Ready)';
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
                        const SizedBox(height: 10),
                        const Divider(),
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
                                    const SnackBar(content: Text('रिक्वेस्ट स्वीकार कर ली गई है!')),
                                  );
                                },
                                icon: const Icon(Icons.check, size: 18),
                                label: const Text('Accept'),
                        
