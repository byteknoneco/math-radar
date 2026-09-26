import 'package:flutter/material.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key, required this.studentName});
  final String studentName;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int correct = 14;
  int wrong = 4;
  int empty = 2;
  String errorType = 'Problem anlama';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ders takibi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(widget.studentName, style: Theme.of(context).textTheme.headlineSmall),
          const Text('Bugun: Dogal Sayilar + Problem Cozme'),
          const SizedBox(height: 20),
          _CounterTile(
            label: 'Dogru',
            value: correct,
            icon: Icons.check_circle_outline,
            onMinus: () => setState(() => correct = correct > 0 ? correct - 1 : 0),
            onPlus: () => setState(() => correct++),
          ),
          _CounterTile(
            label: 'Yanlis',
            value: wrong,
            icon: Icons.cancel_outlined,
            onMinus: () => setState(() => wrong = wrong > 0 ? wrong - 1 : 0),
            onPlus: () => setState(() => wrong++),
          ),
          _CounterTile(
            label: 'Bos',
            value: empty,
            icon: Icons.radio_button_unchecked,
            onMinus: () => setState(() => empty = empty > 0 ? empty - 1 : 0),
            onPlus: () => setState(() => empty++),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: errorType,
            decoration: const InputDecoration(
              labelText: 'Son yanlisin nedeni',
              border: OutlineInputBorder(),
            ),
            items: const [
              'Problem anlama',
              'Dikkat hatasi',
              'Islem hatasi',
              'Konu eksikligi',
              'Soruyu yanlis okudu',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (value) => setState(() => errorType = value ?? errorType),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo ders kaydi olusturuldu.')),
              );
            },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Dersi kaydet'),
          ),
        ],
      ),
    );
  }
}

class _CounterTile extends StatelessWidget {
  const _CounterTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.onMinus,
    required this.onPlus,
  });

  final String label;
  final int value;
  final IconData icon;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text('$value soru'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onMinus, icon: const Icon(Icons.remove_circle_outline)),
            IconButton(onPressed: onPlus, icon: const Icon(Icons.add_circle_outline)),
          ],
        ),
      ),
    );
  }
}
