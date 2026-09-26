import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/stat_card.dart';
import 'lesson_screen.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${student.grade}. Sinif Matematik Radari',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(value: student.overallScore / 100),
                  const SizedBox(height: 8),
                  Text('Genel gelisim: %${student.overallScore}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          StatCard(
            title: 'Guclu konu',
            value: student.strongTopic,
            icon: Icons.emoji_events_outlined,
            subtitle: 'Bu konuda performans istikrarli.',
          ),
          StatCard(
            title: 'Odak konusu',
            value: student.focusTopic,
            icon: Icons.track_changes,
            subtitle: 'Sonraki derste tekrar edilmesi oneriliyor.',
          ),
          StatCard(
            title: 'Odev durumu',
            value: '${student.homeworkDone}/${student.homeworkTotal}',
            icon: Icons.assignment_turned_in_outlined,
          ),
          const SizedBox(height: 8),
          Text('Hata DNA\'si', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _ErrorRow(label: 'Problem anlama', value: 0.40),
          const _ErrorRow(label: 'Dikkat hatasi', value: 0.25),
          const _ErrorRow(label: 'Islem hatasi', value: 0.20),
          const _ErrorRow(label: 'Konu eksikligi', value: 0.15),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => LessonScreen(studentName: student.name),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Yeni dersi baslat'),
          ),
        ],
      ),
    );
  }
}

class _ErrorRow extends StatelessWidget {
  const _ErrorRow({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(child: LinearProgressIndicator(value: value)),
          const SizedBox(width: 10),
          Text('%${(value * 100).round()}'),
        ],
      ),
    );
  }
}
