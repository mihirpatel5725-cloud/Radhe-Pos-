
import 'package:flutter/material.dart';

void main() => runApp(const RKApp());

class RKApp extends StatelessWidget {
  const RKApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radhe Kathiyawadi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A3E12)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool gujarati = true;

  String t(String gu, String en) => gujarati ? gu : en;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radhe Kathiyawadi'),
        actions: [
          TextButton(
            onPressed: () => setState(() => gujarati = !gujarati),
            child: Text(gujarati ? 'EN' : 'ગુજરાતી'),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _tile(context, Icons.receipt_long, t('બિલિંગ', 'Billing'),
              const BillingScreen()),
          _tile(context, Icons.soup_kitchen, t('KOT / કિચન ઓર્ડર', 'KOT / Kitchen'),
              const PlaceholderScreen(title: 'KOT / Kitchen')),
          _tile(context, Icons.table_restaurant, t('ટેબલ', 'Tables'),
              const PlaceholderScreen(title: 'Tables')),
          _tile(context, Icons.inventory_2, t('આઇટમ / સ્ટોક', 'Items / Stock'),
              const PlaceholderScreen(title: 'Items / Stock')),
          _tile(context, Icons.people, t('ગ્રાહક', 'Customer'),
              const PlaceholderScreen(title: 'Customer')),
          _tile(context, Icons.bar_chart, t('રિપોર્ટ', 'Reports'),
              const PlaceholderScreen(title: 'Reports')),
          _tile(context, Icons.settings, t('સેટિંગ્સ', 'Settings'),
              const SettingsScreen()),
        ],
      ),
    );
  }

  Widget _tile(BuildContext c, IconData icon, String title, Widget page) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => page)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 42),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final items = [
      ('પનીર બટર મસાલા', 'Paneer Butter Masala', 120),
      ('રોટલી', 'Roti', 15),
      ('દાળ તડકા', 'Dal Tadka', 70),
      ('છાશ', 'Chaas', 25),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Fast Billing / ઝડપી બિલિંગ')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'આઇટમ શોધો... / Search item...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.restaurant)),
                title: Text(items[i].$1),
                subtitle: Text(items[i].$2),
                trailing: Text('₹ ${items[i].$3}'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payment),
                label: const Text('Payment / પેમેન્ટ'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String paper = '58 mm';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Printer Settings / પ્રિન્ટર સેટિંગ્સ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Printer Type / પ્રિન્ટર પ્રકાર',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: 'Bluetooth Printer',
            items: const [
              DropdownMenuItem(value: 'Bluetooth Printer', child: Text('Bluetooth Printer')),
              DropdownMenuItem(value: 'USB Printer', child: Text('USB Printer')),
              DropdownMenuItem(value: 'Network Printer', child: Text('Network Printer')),
            ],
            onChanged: (_) {},
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          const Text('Paper Size / પેપર સાઇઝ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<String>(
            value: '58 mm',
            groupValue: paper,
            title: const Text('58 mm — Small Receipt'),
            onChanged: (v) => setState(() => paper = v!),
          ),
          RadioListTile<String>(
            value: '80 mm',
            groupValue: paper,
            title: const Text('80 mm — Wide Receipt'),
            onChanged: (v) => setState(() => paper = v!),
          ),
          const Divider(),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Auto Print after Billing'),
          ),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Print Kitchen Order (KOT)'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Print Duplicate Bill'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print),
            label: const Text('Test Print / ટેસ્ટ પ્રિન્ટ'),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(title)));
}
