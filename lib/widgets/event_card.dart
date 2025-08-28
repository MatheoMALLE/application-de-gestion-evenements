import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                event.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.location,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(event.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(event.subtitle,
                        style: const TextStyle(color: Colors.green)),
                    const SizedBox(height: 4),
                    Text(event.date,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.red)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.share_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
