import 'package:flutter/material.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veli gorunumu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Defne\'nin Gelisimi', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          const Text('Bu hafta: ilerliyor ↗'),
          const SizedBox(height: 18),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Matematik seviyesi'),
                  SizedBox(height: 8),
                  LinearProgressIndicator(value: 0.78),
                  SizedBox(height: 8),
                  Text('%78'),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text('Guclu alan'),
            subtitle: Text('Dogal Sayilar'),
          ),
          const ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('Uzerinde calisiyoruz'),
            subtitle: Text('Problem Cozme'),
          ),
          const ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text('Odev'),
            subtitle: Text('7 / 10 tamamlandi'),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ogretmen notu', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text(
                    'Islemleri dogru yapiyor. Problem metninden hangi islemi sececegini belirleme konusunda pratik yapacagiz.',
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
