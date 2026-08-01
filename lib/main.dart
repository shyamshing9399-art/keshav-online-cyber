import 'package:flutter/material.dart';

void main() {
  runApp(const KeshavOnlineCyberApp());
}

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
    {'title': 'फोटो कॉपी & कलर प्रिंट', 'icon': '🖨️'},
    {'title': 'बिजली बिल भुगतान', 'icon': '⚡'},
    {'title': 'आधार कार्ड & पासपोर्ट फोटो', 'icon': '🪪'},
    {'title': 'ऑनलाइन फॉर्म', 'icon': '📝'},
    {'title': 'पैन कार्ड', 'icon': '💳'},
    {'title': 'आयुष्मान & वोटर आईडी', 'icon': '🆔'},
    {'title': 'आय, जाति, निवास', 'icon': '📜'},
    {'title': 'CSC एवं अन्य कार्य', 'icon': '💻'},
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
                return Container(
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
