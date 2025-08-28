import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(event.title),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(event.imageUrl, fit: BoxFit.cover),
                  const Positioned(
                    right: 16,
                    top: 40,
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border,
                            color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Icon(Icons.share, color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.date,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.place, color: Colors.green),
                      const SizedBox(width: 6),
                      Expanded(child: Text(event.location)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(event.description),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        event.price == 0
                            ? "Gratuit"
                            : "À partir de ${event.price.toStringAsFixed(2)} €",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () {},
                        child: const Text("Réserver des places"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
