import 'package:flutter/material.dart';
import 'widgets/category_card.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2E),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<HistoryScreenState> _historyKey = GlobalKey<HistoryScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeContent(),
          HistoryScreen(key: _historyKey),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1F2E),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white38,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Refresh history when switching to history tab
          if (index == 1) {
            _historyKey.currentState?.refresh();
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Icon(Icons.swap_horiz, color: Colors.blue, size: 32),
                const SizedBox(width: 12),
                const Text(
                  'Unit Converter',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2F3E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white30),
                  SizedBox(width: 12),
                  Text(
                    'Search for a category...',
                    style: TextStyle(color: Colors.white30, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  CategoryCard(
                    title: 'Length',
                    icon: Icons.straighten,
                    color: Color(0xFF4A90E2),
                  ),
                  CategoryCard(
                    title: 'Weight',
                    icon: Icons.monitor_weight_outlined,
                    color: Color(0xFFFF9F43),
                  ),
                  CategoryCard(
                    title: 'Temperature',
                    icon: Icons.thermostat,
                    color: Color(0xFF26D0CE),
                  ),
                  CategoryCard(
                    title: 'Volume',
                    icon: Icons.science_outlined,
                    color: Color(0xFF9B59B6),
                  ),
                  CategoryCard(
                    title: 'Area',
                    icon: Icons.crop_square,
                    color: Color(0xFF7ED321),
                  ),
                  CategoryCard(
                    title: 'Time',
                    icon: Icons.access_time,
                    color: Color(0xFF1ABC9C),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
