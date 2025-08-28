import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_detail_page.dart';
import 'add_event_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Event> events = [
    Event(
      title: "Festival Solidays",
      subtitle: "Association Solidarité Sida",
      date: "Samedi 29 septembre 2024",
      location: "Paris 16e - 75016",
      imageUrl: "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2",
      description:
          "Chaque année à l’approche de l’été, le festival Solidays célèbre la solidarité en musique. Durant 3 jours et 2 nuits...",
      price: 0,
    ),
    Event(
      title: "Les Masters de Feu",
      subtitle: "Ville de Compiègne",
      date: "Dimanche 8 juin 2024, 18:00",
      location: "Hippodrome de Compiègne - 60200",
      imageUrl: "https://images.unsplash.com/photo-1508672019048-805c876b67e2",
      description:
          "Depuis 2016, les meilleurs artificiers du monde s’affrontent dans un spectacle pyrotechnique exceptionnel.",
      price: 23.0,
    ),
  ];

  void _addEvent() async {
    final newEvent = await Navigator.push<Event>(
      context,
      MaterialPageRoute(builder: (_) => const AddEventPage()),
    );

    if (newEvent != null) {
      setState(() {
        events.add(newEvent);
      });
    }
  }

  void _removeEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes favoris"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: events.isEmpty
          ? const Center(
              child: Text(
                "Aucun événement pour l’instant",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: events.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                  onDelete: () => _removeEvent(index),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EventDetailPage(event: event)),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        backgroundColor: const Color(0xFFB9D904),
        child: const Icon(Icons.add),
      ),
    );
  }
}
