import 'package:flutter/material.dart';
import '../models/student.dart';
import 'parent_dashboard_screen.dart';
import 'student_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.backendEnabled});

  final bool backendEnabled;

  static const student = Student(
    name: 'Defne Yilmaz',
    grade: 4,
    overallScore: 78,
    strongTopic: 'Dogal Sayilar',
    focusTopic: 'Problemler',
    homeworkDone: 7,
    homeworkTotal: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MathRadar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              avatar: Icon(
                backendEnabled ? Icons.cloud_done_outlined : Icons.science_outlined,
                size: 18,
              ),
              label: Text(backendEnabled ? 'Supabase' : 'Demo'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Ogretmen Paneli', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          const Text('Ogrencinin sadece sonucunu degil, ogrenme desenini takip et.'),
          const SizedBox(height: 18),
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StudentDetailScreen(student: student),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(child: Text('D')),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student.name, style: Theme.of(context).textTheme.titleLarge),
                              Text('${student.grade}. Sinif'),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 18),
                    LinearProgressIndicator(value: student.overallScore / 100),
                    const SizedBox(height: 8),
                    Text('Genel seviye %${student.overallScore}'),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text('Guclu: ${student.strongTopic}')),
                        Chip(label: Text('Odak: ${student.focusTopic}')),
                        Chip(label: Text('Odev: ${student.homeworkDone}/${student.homeworkTotal}')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ParentDashboardScreen()),
            ),
            icon: const Icon(Icons.family_restroom_outlined),
            label: const Text('Veli ekranini onizle'),
          ),
          const SizedBox(height: 18),
          const Card(
            child: ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Sonraki adim'),
              subtitle: Text('Supabase baglandiginda bu demo veriler ortak veritabanindan gelecek.'),
            ),
          ),
        ],
      ),
    );
  }
}
